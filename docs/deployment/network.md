# Matriz de comunicação

| Origem | Destino | Porta | Finalidade |
|---|---|---:|---|
| Usuário | Farol/reverse proxy | TCP 443 | Interface HTTPS |
| Backend Farol | Zabbix corporativo | TCP 443 ou aprovada | API JSON-RPC read-only |
| Backend Farol | PostgreSQL | TCP 5432 interno | Persistência |
| Servidor | DNS | conforme política | Resolução |
| Servidor | NTP | UDP 123 | Relógio |

Não existe e não deve existir comunicação Farol → switches/APs/routers. PostgreSQL não deve ser publicado no host.

