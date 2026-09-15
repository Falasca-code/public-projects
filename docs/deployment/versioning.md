# Versionamento

Produção deve usar releases imutáveis (`v1.0.0`, `v1.1.0`) e imagens com tag explícita (`farol-backend:1.0.0`, `farol-frontend:1.0.0`). `latest` e `main` não são referências de produção. O rollback deve apontar para a tag anterior e restaurar o backup compatível, sem apagar volumes.

