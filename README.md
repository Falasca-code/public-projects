# Farol

Plataforma de observabilidade e topologia de infraestrutura baseada no Zabbix.

O Farol consome exclusivamente informações já coletadas pelo Zabbix através de uma API read-only. Ele não acessa, configura ou executa comandos em switches, access points, roteadores ou outros equipamentos de rede.

## O que este repositório contém

- documentação de instalação no ambiente do cliente;
- checklist de requisitos e primeiro acesso;
- matriz de comunicação de rede;
- configuração de branding por cliente;
- exemplo seguro de variáveis de ambiente;
- scripts iniciais de preflight e validação;
- estratégia de versionamento, backup e rollback.

## Documentação

- [KB de instalação e primeiro acesso](docs/deployment/installation.md)
- [Guia de deployment](docs/deployment/README.md)
- [Integração read-only com Zabbix](docs/deployment/zabbix-integration.md)
- [Requisitos e checklist](docs/deployment/requirements.md)
- [Matriz de rede](docs/deployment/network.md)
- [Branding por cliente](docs/deployment/branding.md)
- [Versionamento e rollback](docs/deployment/versioning.md)
- [Roadmap futuro](docs/deployment/roadmap.md)

## Instalação rápida

```bash
git clone --branch v1.0.0 https://github.com/Falasca-code/public-projects.git farol
cd farol
cp deploy/.env.example .env
vi .env
./deploy/scripts/preflight.sh
```

O arquivo `.env` deve conter a URL do Zabbix, o token read-only, os segredos da plataforma e os dados de branding. Nunca publique esse arquivo.

## Arquitetura da V1

```text
Equipamentos → Zabbix → API read-only → Farol → Topologia e indicadores
```

Quando LLDP, CDP, VLANs ou MACs não estiverem disponíveis no Zabbix, o Farol deve informar uma capacidade parcial. Não existe fallback para acesso direto aos equipamentos.

## Segurança

- nenhum segredo deve ser versionado;
- PostgreSQL deve permanecer em rede interna;
- produção deve usar HTTPS;
- imagens e releases devem ser versionadas;
- o token do Zabbix deve ter somente permissões de leitura;
- o Zabbix Play pertence apenas ao ambiente de desenvolvimento.

## Licença e marca

O código é distribuído sob a [Apache License 2.0](LICENSE). A documentação é
distribuída sob a [Creative Commons BY 4.0](LICENSE-DOCS.md).

O nome Farol, seus logotipos e sua identidade visual são marcas reservadas.
Consulte [TRADEMARKS.md](TRADEMARKS.md) para regras de uso em forks e produtos
derivados. Dependências de terceiros permanecem sujeitas às suas próprias
licenças.

Implantação, suporte, treinamento, consultoria, customizações e integrações
podem ser oferecidos separadamente pela Falasca-code.

## Status

O pacote de documentação e preparação de deployment está disponível. O backend, frontend e o Compose completo de produção serão publicados em uma release própria após a revisão final do código e dos artefatos de implantação.
