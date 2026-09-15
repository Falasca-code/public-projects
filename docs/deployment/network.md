# Matriz de comunicação

| Origem | Destino | Porta | Finalidade |
|---|---|---:|---|
| Usuário | Camada de publicação do cliente / Farol | Porta definida pelo cliente | Interface |
| Backend Farol | Zabbix corporativo | Porta aprovada | API JSON-RPC read-only |
| Backend Farol | PostgreSQL | TCP 5432 interno | Persistência |
| Servidor | DNS | conforme política | Resolução |
| Servidor | NTP | UDP 123 | Relógio |

Não existe e não deve existir comunicação Farol → switches/APs/routers. PostgreSQL não deve ser publicado no host.

A camada de publicação pode ser HAProxy, NGINX, F5, Traefik, NAT, WAF, VPN,
DNS interno/público ou acesso somente LAN, conforme a política do cliente.
Nenhuma dessas opções é requisito técnico do Farol; em ambiente controlado, o
frontend pode ser acessado diretamente pela porta interna publicada pela
instalação.
