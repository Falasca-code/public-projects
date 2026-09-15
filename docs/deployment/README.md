# Deploy corporativo

O Farol V1 é uma camada de consulta sobre um Zabbix corporativo existente.
O backend acessa somente a API HTTPS do Zabbix com token read-only. Não há acesso Farol → switches, APs ou routers.

## Estado auditado

- A cópia preservada documenta backend Node/Express, frontend React/Vite e PostgreSQL.
- O ambiente atual usa `zabbix_play_net` e o Zabbix Play para desenvolvimento.
- O Compose auditado publica `8082` e usa labels Traefik; isso deve ser ajustado conforme a política do cliente.
- Compatibilidade com templates reais ainda requer validação no cliente.

O sizing é inicial e não representa capacidade máxima. Use uma tag de release, nunca `latest` ou uma branch diretamente.

