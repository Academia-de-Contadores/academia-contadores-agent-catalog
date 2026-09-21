# Validação da skill RAG — 2026-09-20

## Resultado

O catálogo local registra `ac.reforma-tributaria-rag` na versão `0.2.0`,
com lifecycle `validated`, perfis `current` e `legacy` e commit-fonte
`c9c0e559d417fa7fd5d07a5af6a5ff04d3e2ab8e`.

O GPT principal continua sendo
`g-6a1b93a521b4819189fda957bcf00115`. A comparação independente registra
PASS funcional em 5/5 casos e informa que o GPT online permaneceu intacto
como baseline. O confronto adicional das afirmações/citações com os artefatos
originais também passou em 5/5, tratando P5 explicitamente como fallback sem
fonte recuperada e sem validação factual corrente.

## Evidências

- comparação funcional: `evaluations/parity/gpt-comparison-2026-09-20-r2.md`;
- confronto com originais: `evaluations/parity/original-source-verification-2026-09-20.md`;
- instalação limpa: `evaluations/parity/install-validation-2026-09-20.md`;
- evidência da rodada r2: `evaluations/parity/task-5-fix1-evidence-2026-09-20/README.md`.

Os caminhos acima são relativos ao repositório
`https://github.com/Academia-de-Contadores/ac-agente-reforma-tributaria-rag.git`.

## Validação do catálogo

- `bash scripts/validate-catalog.sh`: exit code 0;
- `bash scripts/validate-live-parity.sh`: exit code 0 no layout temporário
  equivalente a `gptspersonalizados/{academia-contadores-agent-catalog,agent-repos}`.

O layout temporário foi necessário porque este branch está em um worktree
aninhado, enquanto o validador resolve `agent-repos` a partir do diretório-pai
do catálogo. O script e os checkouts principais não foram alterados.

## Próximo gate

A família está tecnicamente pronta no catálogo local. O início de
`ac-reforma-tributaria-sem-surto` continua condicionado ao push dos commits da
skill e do catálogo e à confirmação de que os remotos apontam para esses mesmos
commits.
