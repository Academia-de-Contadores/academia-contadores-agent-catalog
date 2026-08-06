# Catálogo canônico de agentes

Este catálogo indexa as fontes canônicas dos agentes personalizados da Academia de Contadores. Cada `agent.id` aponta para um único repositório canônico.

Aliases registram apenas nome, URL e relação com a fonte canônica; eles não carregam instruções e não recebem repositórios próprios.

## Validação

```bash
bash scripts/validate-catalog.sh
```

## Proteções no GitHub

O repositório remoto é privado. No plano atual da organização, a API do GitHub
não disponibiliza rulesets para este repositório privado (HTTP 403) nem secret
scanning/push protection (HTTP 422). A validação local do catálogo permanece
obrigatória antes de cada publicação. Consulte `reports/task-3-report.md` para
a evidência e os limites exatos.
