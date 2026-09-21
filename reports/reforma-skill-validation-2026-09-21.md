# Validação da skill Reforma Tributária — 2026-09-21

## Resultado

O catálogo local registra `ac.reforma-tributaria` na versão `0.2.0`, com
lifecycle `validated`, perfis `current-closed`, `restored-technical` e
`legacy-action` e commit-fonte
`7f8e48683c5168bee4b22c91f54c6e7ed9626232`.

O GPT principal permanece
`g-6a7259cd04a48191a3bb1c2833b0ca2f`. O perfil de paridade do GPT online é
`current-closed`; os perfis locais `restored-technical` e `legacy-action`
restauram orientação técnica com fontes e fallback local explícito. A comparação
independente registra PASS funcional em 7/7 casos: Gate A 2/2 para reprodução do
encerramento e Gate B 5/5 para restauração técnica intencional. Não houve mudança
no GPT online.

## Evidências

- comparação funcional: `evaluations/parity/gpt-comparison-2026-09-21.md`;
- confronto com originais: `evaluations/parity/original-source-verification-2026-09-21.md`;
- instalação: `evaluations/parity/install-validation-2026-09-21.md`;
- respostas e julgamento do forward test: `evaluations/parity/local-results-2026-09-21.md`.

Os caminhos acima são relativos ao repositório
`https://github.com/Academia-de-Contadores/ac-agente-reforma-tributaria.git`.
O commit validado poderá ser conferido no remoto após a publicação da branch;
esta atualização não faz push, PR ou merge.

## Integridade

- A instalação local contém 53 arquivos regulares e coincide byte a byte com os
  mesmos caminhos da origem validada.
- O inventário pós-review mantém 53/53 arquivos e tem SHA-256
  `653c6ea8b23c4497b557059454c9b387e9b92b5672e6552f2b5a11e7bed857af`;
  o README histórico do conector tem SHA-256
  `11fe985e121209e2bb4442cf6c9a5eda2d762cb62e930db8bd7cfac1d572ef7a`
  na origem e na instalação.
- O manifesto da origem e da instalação registra `0.2.0`, lifecycle
  `validated` e os três perfis na mesma versão.
- As outras 11 famílias permanecem estruturalmente idênticas à base
  `c62b32750a394efb5f88c35e8a63c43bfcbe81db`, inclusive as entradas RAG e Sem
  Surto já validadas; `catalog/aliases.yaml` não foi alterado.

## Validação do catálogo

As quatro verificações abaixo retornaram exit code `0` em layout temporário
equivalente a
`gptspersonalizados/{academia-contadores-agent-catalog,agent-repos}`:

- `bash scripts/validate-catalog.sh`;
- `bash tests/validate-catalog.test.sh`;
- `bash scripts/validate-live-parity.sh`;
- `bash tests/validate-live-parity.test.sh`.

As rejeições dos fixtures negativos nas duas suítes são esperadas e fazem parte
do resultado aprovado quando o processo completo termina com exit code `0`. O
layout temporário é necessário porque a branch está em um worktree aninhado,
enquanto os validadores resolvem `agent-repos` a partir do diretório irmão do
catálogo. Os scripts, testes e checkouts principais não foram alterados.

## Gate de publicação

A skill está pronta no commit validado da branch
`feat/reforma-tributaria-skill-ready`; o catálogo está pronto localmente em
`feat/reforma-skill-catalog`, empilhado sobre RAG e Sem Surto. Esta task termina
antes do gate externo: não houve push, abertura de PR, merge nem confirmação de
hash remoto.

## Limites

A validação comportamental usa sete casos e não certifica vigência normativa ou
resultados universais. O perfil `legacy-action` não teve health/retrieval remoto
bem-sucedido; quando a integração histórica não pode ser verificada, ele usa o
fallback `restored-technical`. O minor final de rastreabilidade do conector foi
resolvido: `connectors/rag/README.md` agora aponta para
`evaluations/regression/C1.md` e `references/retrieval-contract.md`, distingue os
dois schemas preservados e explicita que avaliações não são runtime. Não restam
pendências da revisão final; push, pull request e merge continuam fora deste gate.
