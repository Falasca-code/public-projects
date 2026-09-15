# Integração com Zabbix

O Zabbix é a única fonte de dados da V1. O backend consulta hosts, grupos, templates, interfaces, items, latest values, triggers, tags, inventário e dados LLDP/CDP/MAC/VLAN somente quando já coletados e expostos pela API.

O token deve ter permissões mínimas de leitura. O Farol não cria, altera ou descobre hosts; não executa SNMP, SSH, Telnet, scans, polling ou comandos em equipamentos.

LLDP/CDP deve ser normalizado por nome/key/tags/template/vendor/valor/interface/host, sem depender de uma item key única. Quando o dado não existir, a UI reporta indisponibilidade e mantém a topologia parcial; nunca tenta uma fonte direta.

Compatibilidade Huawei, Cisco, Aruba, Juniper e outros vendors deve ser testada com amostras reais antes de prometer cobertura.

