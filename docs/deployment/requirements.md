# Requisitos iniciais

Linux 64-bit (preferência Debian estável ou Ubuntu Server LTS), Docker Engine e Docker Compose v2.

| Perfil | CPU | RAM | Disco livre |
|---|---:|---:|---:|
| Mínimo inicial | 2 vCPU | 4 GB | 20 GB |
| Recomendado inicial | 4 vCPU | 8 GB | 50 GB |

O sizing final depende de hosts, items, frequência de sincronização, volume de histórico consultado e complexidade da topologia. Não há benchmark para afirmar capacidade máxima.

## Checklist

- [ ] Servidor Linux provisionado
- [ ] Docker e Compose v2 instalados
- [ ] DNS e TLS definidos
- [ ] Firewall validado
- [ ] URL e token read-only do Zabbix disponíveis
- [ ] Comunicação Farol → Zabbix validada
- [ ] NTP funcionando
- [ ] Backup definido

