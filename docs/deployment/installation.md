# KB — Instalação do Farol no cliente

Este procedimento instala a plataforma no ambiente do cliente usando Docker,
sem instalar ou transportar o Zabbix Play. O cliente deve fornecer um Zabbix
existente e acessível pela API.

## 1. Pré-requisitos

- Servidor Linux 64-bit, preferencialmente Debian estável ou Ubuntu Server LTS.
- Docker Engine e Docker Compose v2.
- uma camada de publicação escolhida pelo cliente (opcional em ambiente controlado);
- Pelo menos 2 vCPU, 4 GB RAM e 20 GB livres. Recomendado: 4 vCPU, 8 GB RAM e 50 GB.
- URL da API do Zabbix e token com permissão somente leitura.
- Comunicação de saída do backend para o Zabbix liberada.
- NTP funcionando.

O sizing é inicial. A capacidade real depende do número de hosts/items,
frequência de sincronização, histórico consultado e complexidade da topologia.

## 2. Obter a versão

Use uma release imutável, por exemplo `v1.0.0`. Não use `main` ou `latest` em
produção.

```bash
git clone --branch v1.0.0 <URL_DO_REPOSITORIO> farol
cd farol
```

Confirme a versão antes de continuar:

```bash
git describe --tags --always
```

## 3. Configurar o ambiente

```bash
cp deploy/.env.example .env
${EDITOR:-vi} .env
```

Preencha obrigatoriamente:

```dotenv
APP_VERSION=1.0.0
APP_URL=http://farol.internal.example
ZABBIX_URL=https://zabbix.cliente.example/api_jsonrpc.php
ZABBIX_TOKEN=<token-read-only>
POSTGRES_PASSWORD=<segredo-forte>
FAROL_ADMIN_PASSWORD=<senha-forte>
FAROL_SESSION_SECRET=<valor-aleatorio-com-32-ou-mais-caracteres>
```

Ajuste também o branding (`APP_NAME`, logos e cores). Nunca comite o arquivo
`.env` nem tokens, senhas ou dumps.

## 4. Preflight

Execute a partir do diretório do projeto:

```bash
./deploy/scripts/preflight.sh
```

O resultado esperado é `PREFLIGHT: READY`. O script é somente leitura e não
instala pacotes, altera firewall ou modifica o ambiente.

## 5. Subir a plataforma

Use o Compose de produção fornecido pela release:

```bash
docker compose -f deploy/docker-compose.yml up -d
docker compose -f deploy/docker-compose.yml ps
```

Devem estar saudáveis o frontend, backend e PostgreSQL. O Zabbix do laboratório
não deve aparecer nessa stack.

## 6. Primeiro acesso

1. Abra `APP_URL` no navegador, ou o endereço definido na camada de publicação do cliente.
2. Se houver publicação externa, confirme o TLS, domínio e controles definidos pelo cliente.
3. Entre com `FAROL_ADMIN_USER` e `FAROL_ADMIN_PASSWORD`.
4. Abra **Conexão Zabbix** e confirme estado conectado e versão detectada.
5. Abra **Dispositivos** e confirme que os hosts vêm do Zabbix corporativo.
6. Abra **Topologia**. Se LLDP/CDP não estiver coletado, a plataforma deve
   informar topologia parcial ou dados indisponíveis; isso é comportamento
   esperado, não motivo para acessar diretamente o equipamento.

Troque a senha administrativa após o primeiro acesso, conforme a política do
cliente, e armazene os segredos no cofre corporativo.

## 7. Validação pós-instalação

```bash
./deploy/scripts/validate.sh
```

Valide manualmente:

- frontend acessível via HTTPS;
- login funcionando;
- backend saudável;
- PostgreSQL sem porta publicada externamente;
- conexão com a API do Zabbix funcionando;
- hosts, status e problemas coerentes com o Zabbix;
- topologia parcial quando os dados de vizinhança não existirem;
- ausência de comunicação ou credenciais para switches;
- logs sem tokens ou senhas.

## 8. Troubleshooting rápido

### Zabbix desconectado

Verifique `ZABBIX_URL`, validade do token, DNS, firewall e o caminho correto da
API (`api_jsonrpc.php`). O token deve ser read-only e aceito pelo servidor
Zabbix do cliente.

### Nenhuma topologia

Confirme no Zabbix se LLDP/CDP foi coletado e se os items estão disponíveis.
O Farol não faz descoberta alternativa nem consulta SNMP diretamente.

### Login não funciona

Confirme `FAROL_ADMIN_USER`, `FAROL_ADMIN_PASSWORD` e
`FAROL_SESSION_SECRET`; depois consulte apenas os logs sanitizados do backend.

## 9. Rollback

Pare a atualização, retorne à tag anterior e valide o backup compatível:

```bash
docker compose -f deploy/docker-compose.yml down
git checkout v<versao-anterior>
docker compose -f deploy/docker-compose.yml up -d
./deploy/scripts/validate.sh
```

Não remova volumes PostgreSQL durante rollback.
