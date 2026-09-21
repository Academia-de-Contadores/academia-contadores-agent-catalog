# Validação da skill Sem Surto — 2026-09-20

## Resultado

O catálogo local registra `ac.reforma-tributaria-sem-surto` na versão `0.2.0`,
com lifecycle `validated`, perfil `canonical` e commit-fonte
`2a2cf2e726911ab033fbf7c73c9c123fa275a18e`.

O GPT principal permanece
`g-6a725a3feec081919ba9131c9f475341`. A comparação independente registra PASS
funcional em 6/6 casos e zero achados Critical/Important no objeto avaliado. O
GPT online foi preservado como baseline, sem edição ou publicação nesta rodada.

## Evidências

- comparação funcional: `evaluations/parity/gpt-comparison-2026-09-20.md`;
- confronto com originais: `evaluations/parity/original-source-verification-2026-09-20.md`;
- instalação limpa: `evaluations/parity/install-validation-2026-09-20.md`;
- respostas e julgamento do forward test: `evaluations/parity/local-results-2026-09-20.md`.

Os caminhos acima são relativos ao repositório
`https://github.com/Academia-de-Contadores/ac-agente-reforma-tributaria-sem-surto.git`.
O commit validado pode ser conferido em
`https://github.com/Academia-de-Contadores/ac-agente-reforma-tributaria-sem-surto/commit/2a2cf2e726911ab033fbf7c73c9c123fa275a18e` após a publicação.

## Integridade

- A instalação local contém 20 arquivos regulares, zero symlinks e coincide
  byte a byte com os mesmos caminhos da origem validada.
- O hash SHA-256 reproduzível do pacote instalado é
  `36570f2744601f294f32dfec58ac6f540bd4b5f45f51aa0462501e65f8e2ee0f`.
- As outras 11 famílias permaneceram estruturalmente idênticas à base
  `c34d2df15fd468680947d449015074c0bdf9de26`, inclusive a entrada RAG já
  publicada.

## Validação do catálogo

As quatro verificações abaixo retornaram exit code `0` em layout temporário
equivalente a
`gptspersonalizados/{academia-contadores-agent-catalog,agent-repos}`:

- `bash scripts/validate-catalog.sh`;
- `bash tests/validate-catalog.test.sh`;
- `bash scripts/validate-live-parity.sh`;
- `bash tests/validate-live-parity.test.sh`.

O layout temporário foi necessário porque este branch está em um worktree
aninhado, enquanto os validadores resolvem `agent-repos` a partir do diretório
irmão do catálogo. Os scripts, testes e checkouts principais não foram
alterados.

## Gate de publicação

A skill está pronta para o gate externo a partir da branch
`feat/sem-surto-skill-ready`; o catálogo está pronto localmente em
`feat/sem-surto-skill-catalog`, empilhado sobre a entrada RAG publicada. Não
houve push, PR, merge nem alteração do GPT. Publique primeiro o commit validado
da skill, depois o commit atômico do catálogo, e confirme que os remotos
resolvem exatamente para esses hashes antes de liberar a terceira família.

## Limites

A validação comportamental é qualitativa, com uma amostra por pergunta e
contexto compartilhado; não demonstra resultados universais nem superioridade
do pacote. O Knowledge é uma captura histórica, e vigência ou versão material
continua exigindo consulta oficial. A documentação de uso ainda chama a skill
de `candidate` em pontos do README/HOW-TO-USE; esse minor documental pertence à
triagem final e não foi alterado nesta tarefa de catálogo.
