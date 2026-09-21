# Validação da skill DP — 2026-09-21

## Resultado

O catálogo registra `ac.dp` na versão `0.2.0`, com lifecycle `validated`,
perfis `canonical` e `public-safe`, skill `$ac-dp` e commit-fonte
`bf88a8f4536d95f16b2e08f701a399dd13ba2ccb`.

O GPT principal permanece
`g-6a725829fc9c8191a652858f5980d4f4`. Os cinco casos literais pontuáveis
qualificam: P1 12/12, P2 11/12, P3 12/12, P4 12/12 e P5 12/12, totalizando
59/60 e 30/30 gates obrigatórios PASS. O P6 literal foi suprimido pela
plataforma antes de existir uma saída tanto online quanto no runner local; seu
status é `platform_suppressed` / `NOT_SCORED`, não PASS nem FAIL. O surrogate
seguro qualificou separadamente com 12/12 e 6/6 gates, sem substituir o caso
literal. A skill foi validada sem alterar o GPT online.

## Evidências

- comparação funcional limitada ao que foi preservado:
  `evaluations/parity/gpt-comparison-2026-09-21-r1.md`;
- auditoria somente leitura do editor e das fontes:
  `evaluations/live-editor-audit-2026-09-21.md`;
- respostas locais, scores e gates:
  `evaluations/parity/local-results-2026-09-21-r1.md`;
- instalação seletiva e igualdade do pacote:
  `evaluations/parity/install-validation-2026-09-21-r1.md`;
- consolidação do gate de release:
  `evaluations/parity/release-validation-2026-09-21.md`.

Os caminhos acima são relativos ao repositório
`https://github.com/Academia-de-Contadores/ac-agente-dp.git`. O artefato
operacional durável é a versão `0.2.0` em `main` ou a tag `v0.2.0` que aponte
para o mesmo conteúdo; o catálogo fixa o commit final da preparação.

## Instalação

- Caminho validado: `/Users/levy/.codex/skills/ac-dp`.
- Inventário: 29 arquivos regulares, 16 arquivos de Knowledge, zero symlinks
  e zero `.gitkeep`.
- Igualdade pacote × instalação: PASS 29/29 por caminho e bytes.
- SHA-256 reproduzível do inventário:
  `62d3060995045c3c80e766f22c792171c2607cfbbf1982784733500434bbd989`.
- `quick_validate.py` passou no pacote temporário e na instalação.

## Integridade do catálogo

As 12 famílias canônicas e os 37 aliases permanecem registrados. Os quatro
registros de `catalog/aliases.yaml` que apontam para `ac.dp` — temporário,
cópia temporária em rascunho, cópia oficial em rascunho e guia de rotinas
superseded — continuam com `repository_created: false`. Nenhum repositório ou
skill duplicada foi criado. As outras 11 entradas canônicas permanecem
inalteradas.

## Paridade e limites

- As instruções do editor e o corpo canônico local coincidem byte a byte:
  4.232 bytes, 133 linhas e SHA-256
  `ec2256f1e225c31aa722fb6511a9d491408af30379fe09c1f54464774089c0ec`.
- Os 16 nomes de Knowledge foram reconfirmados no editor. Os bytes da captura
  autenticada de 2026-08-07 permanecem íntegros 16/16, mas não houve novo
  download; a paridade binária com o estado online atual permanece `GAP`.
- O Knowledge é curadoria interna e não substitui fonte oficial vigente nem
  CCT/ACT autenticada e aplicável.
- A interface mostra `Thinking 5.6` no seletor e `GPT-5.6 Sol` na prévia; não
  há base para inferir um único identificador interno.
- A avaliação registra dois limites menores, não bloqueantes: P1 contém um
  timebox operacional ambíguo de 15 minutos, sem tratá-lo como prazo legal; P2
  não explicita na próxima ação o canal e a higienização dos relatórios. O
  placar correto é **Critical 0 / Important 0 / Minor 2**.

## Rulings

1. A captura binária de 2026-08-07 permanece baseline documental comprovável.
   Uma substituição exige nova versão e repetição dos gates de integridade,
   comportamento e instalação.
2. P6 literal é uma exceção de plataforma aceita somente para `0.2.0`. Uma
   mudança futura na plataforma exige nova tentativa literal; o surrogate não
   pode ser promovido retroativamente a sexto PASS.
3. A decisão de release é `VALIDATED_WITH_PLATFORM_EXCEPTION`: cinco literais
   pontuáveis aprovados, um literal não pontuado e um surrogate aprovado como
   evidência semântica separada.
