# Redistribuição pública

O projeto pode ser distribuído por releases versionadas em um repositório Git
público. Antes de publicar, revisar o conteúdo para garantir que não existam:

- `.env` ou tokens;
- dumps PostgreSQL;
- backups operacionais;
- screenshots com dados do cliente;
- domínios, IPs ou credenciais reais;
- dados do Zabbix Play que identifiquem o cliente.

O repositório público deve conter `deploy/.env.example`, documentação,
Compose de produção e tags como `v1.0.0`. O Zabbix Play deve ficar separado em
um perfil/documentação de desenvolvimento.

