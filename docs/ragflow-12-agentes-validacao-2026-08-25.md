# RAGFlow — 12 GPTs canônicos e validação humana

Data: 2026-08-25  
Status: **EM FINALIZAÇÃO — corpus ampliado do RTC ainda processando**

## Resultado do MVP

- 12 GPTs canônicos identificados no snapshot validado do Builder.
- 12 datasets canônicos no RAGFlow, exatamente um por agente.
- 12 Agents no RAGFlow, exatamente um por agente, usando `gpt-5.6-terra`.
- Fluxo padrão: `Pergunta → Retrieval no dataset próprio → Terra → resposta citada`; no Agent cujo pack está vazio, o resultado esperado é abstinência sem citação.
- Nenhum Agent usa Retrieval como tool; o retrieval é um nó explícito antes do modelo.
- 115 anexos ativos do Builder presentes nos datasets corretos.
- O bloco canônico das instruções dos 12 GPTs foi preservado no respectivo Agent e recebeu um complemento separado de aterramento e citação. No RTC, a mecânica `Action Chroma` foi explicitamente substituída pelo nó Retrieval RAGFlow; identidade, escopo e guardrails permanecem.
- 12/12 controles mínimos de retrieval aprovados: 11/11 positivos com fonte-alvo no top 5 e 1/1 negativo com retorno vazio.
- 12/12 Agents executados end-to-end com `gpt-5.6-terra`; nos 11 corpora positivos houve resposta e citação do dataset próprio, e no Agent sem anexos não houve orientação tributária inventada.
- O RTC é um único agente e um único dataset. Seu dataset reúne 8 arquivos do GPT, 84 documentos canônicos e 45 arquivos físicos de evidência — 44 elegíveis a retrieval e 1 shell provenance-only. O shell SPA sem texto está desabilitado e não participa do retrieval.

## Mapa GPT → knowledge pack → dataset → Agent

| GPT canônico | Repositório / knowledge pack | Arquivos ativos | Dataset RAGFlow | Agent RAGFlow |
|---|---|---:|---|---|
| Agente de Captação de Clientes CEO \| Oficial (copy) | `ac-agente-captacao-clientes` · `knowledge/live-2026-08-22` | 14 | [AC — Captação de Clientes](https://ragflow.alltius.dev/dataset/files/6cef942ea09811f1824f5df01a9a1972) | [Abrir Agent](https://ragflow.alltius.dev/agent/f14a1ee8a0a611f1824f5df01a9a1972) |
| Agente Contábil — Contadora CEO \| Oficial (copy) | `ac-agente-contabil` · `knowledge/live-2026-08-22` | 10 | [AC — Contábil](https://ragflow.alltius.dev/dataset/files/513e814c9e2011f193041d6729b8d591) | [Abrir Agent](https://ragflow.alltius.dev/agent/e3bbfc50a0a711f1824f5df01a9a1972) |
| Agente DP — Contadora CEO \| Oficial (copy) | `ac-agente-dp` · `knowledge/original` | 16 | [AC — Departamento Pessoal](https://ragflow.alltius.dev/dataset/files/a251d780a09811f1824f5df01a9a1972) | [Abrir Agent](https://ragflow.alltius.dev/agent/e94fc638a0a711f1824f5df01a9a1972) |
| Agente de Entrada de Clientes CEO \| Oficial (copy) | `ac-agente-entrada-clientes` · `knowledge/live-2026-08-22` | 10 | [AC — Entrada de Clientes](https://ragflow.alltius.dev/dataset/files/a3bed8a2a09811f1824f5df01a9a1972) | [Abrir Agent](https://ragflow.alltius.dev/agent/e9b6b1d6a0a711f1824f5df01a9a1972) |
| Agente Estrategista de Conteúdo D.A.I. \| Oficial (copy) | `ac-agente-estrategista-conteudo-dai` · `knowledge/live-2026-08-22` | 11 | [AC — Estrategista de Conteúdo D.A.I.](https://ragflow.alltius.dev/dataset/files/a51422aca09811f1824f5df01a9a1972) | [Abrir Agent](https://ragflow.alltius.dev/agent/ea0c1090a0a711f1824f5df01a9a1972) |
| Agente Fiscal — Contadora CEO \| Oficial (copy) | `ac-agente-fiscal` · `knowledge/live-2026-08-22` | 10 | [AC — Fiscal](https://ragflow.alltius.dev/dataset/files/a676cf50a09811f1824f5df01a9a1972) | [Abrir Agent](https://ragflow.alltius.dev/agent/ea4e8736a0a711f1824f5df01a9a1972) |
| Agente Guia da Operação CEO \| Oficial (copy) | `ac-agente-guia-operacao` · `knowledge/original` | 16 | [AC — Guia da Operação](https://ragflow.alltius.dev/dataset/files/516cdff69e2011f193041d6729b8d591) | [Abrir Agent](https://ragflow.alltius.dev/agent/ea981e8ca0a711f1824f5df01a9a1972) |
| Agente de Processos do Escritório Autogerenciável (copy) | `ac-agente-processos-escritorio` · `knowledge/original` | 4 | [AC — Processos do Escritório](https://ragflow.alltius.dev/dataset/files/a7f42f26a09811f1824f5df01a9a1972) | [Abrir Agent](https://ragflow.alltius.dev/agent/eafdeaaaa0a711f1824f5df01a9a1972) |
| Agente Reforma Tributária Day - Consulta RAG | `ac-agente-reforma-tributaria-rag` · `knowledge/live-2026-08-22` + corpus RTC suplementar | 8 | [AC — Reforma Tributária Day — Consulta RAG](https://ragflow.alltius.dev/dataset/files/51ab3fd09e2011f193041d6729b8d591) | [Abrir Agent](https://ragflow.alltius.dev/agent/04944ca8a02511f1824f5df01a9a1972) |
| Day Agente da Reforma Tributária Sem Surto (copy) | `ac-agente-reforma-tributaria-sem-surto` · `knowledge/original` | 6 | [AC — Reforma Tributária Sem Surto](https://ragflow.alltius.dev/dataset/files/a96a5e7aa09811f1824f5df01a9a1972) | [Abrir Agent](https://ragflow.alltius.dev/agent/eb491af2a0a711f1824f5df01a9a1972) |
| Agente Reforma — Sala Secreta (até 07/08) | `ac-agente-reforma-tributaria` · `knowledge/live-2026-08-22` · pack ativo vazio | 0 | [AC — Reforma Tributária — Oficial](https://ragflow.alltius.dev/dataset/files/7074c442a0a311f1824f5df01a9a1972) | [Abrir Agent](https://ragflow.alltius.dev/agent/eb920924a0a711f1824f5df01a9a1972) |
| Agente Societário — Contadora CEO \| Oficial (copy) | `ac-agente-societario` · `knowledge/live-2026-08-22` | 10 | [AC — Societário](https://ragflow.alltius.dev/dataset/files/aadcf844a09811f1824f5df01a9a1972) | [Abrir Agent](https://ragflow.alltius.dev/agent/ebd03424a0a711f1824f5df01a9a1972) |

## Provas automáticas já concluídas

| Controle | Resultado |
|---|---:|
| Snapshot Builder x repositórios locais | 12/12 validados; 61 históricos idênticos + 54 deltas versionados, todos com `hash_matches_live=true` |
| Bloco de instrução do repositório contido no Agent RAGFlow | 12/12 |
| Anexos ativos presentes no dataset correto | 115/115 |
| Datasets canônicos ligados ao Agent correto | 12/12 |
| Agents usando `gpt-5.6-terra` | 12/12 |
| Agents sem Retrieval-as-tool | 12/12 |
| Retrieval positivo com fonte-alvo no top 5 | 11/11 |
| Controle negativo no dataset sem anexos | 1/1 retorno vazio |
| Agent executado end-to-end | 12/12 |

### Retrieval mínimo

Parâmetros: `similarity_threshold=0,2`, peso vetorial `0,3`, `top_k=1024`, até dez resultados, sem reranker. Esta é uma bateria de encanamento; seis consultas encontram primeiro um arquivo de perguntas esperadas. A validação end-to-end complementou o teste e citou também os documentos operacionais. Scores não devem ser comparados entre corpora diferentes.

| Dataset | Primeira fonte | Score | Esperada no top 5 |
|---|---|---:|---|
| Captação | `05-PERGUNTAS-TESTE-E-RESPOSTAS-ESPERADAS.md` | 0,3226 | sim |
| Contábil | `05-PERGUNTAS-TESTE-E-RESPOSTAS-ESPERADAS.md` | 0,3720 | sim |
| Departamento Pessoal | `05-PERGUNTAS-TESTE-E-RESPOSTAS-ESPERADAS.md` | 0,4650 | sim |
| Entrada de Clientes | `05-PERGUNTAS-TESTE-E-RESPOSTAS-ESPERADAS.md` | 0,3795 | sim |
| Estrategista de Conteúdo D.A.I. | `09-BANCO-DE-ANGULOS-E-ROTEIROS.md` | 0,3561 | sim |
| Fiscal | `05-PERGUNTAS-TESTE-E-RESPOSTAS-ESPERADAS.md` | 0,4185 | sim |
| Guia da Operação | `27-EXEMPLOS-RESPOSTAS-GUIA-V2.md` | 0,4080 | sim |
| Processos do Escritório | `01-METODO-PROCESSO-EXECUTAVEL.md` | 0,5119 | sim |
| Reforma Day — Consulta RAG | `04-dfe-erp-classificacao.md` | 0,3233 | sim |
| Reforma Tributária Sem Surto | `06-GAPS-E-LIMITES-DA-IA.md` | 0,2894 | sim |
| Reforma Tributária — Oficial | nenhum resultado | — | `PASS_NEGATIVO`; o GPT não possui anexos ativos |
| Societário | `05-PERGUNTAS-TESTE-E-RESPOSTAS-ESPERADAS.md` | 0,4422 | sim |

## Readback e comparação funcional

O readback sanitizado, com IDs, modelo, canvas `4 nós / 3 arestas`, dataset ligado, tools, Memory, status dos documentos, hashes dos prompts runtime, perguntas e top 5, está em [`ragflow-12-agentes-readback-2026-08-25.json`](./ragflow-12-agentes-readback-2026-08-25.json).

O mesmo artefato registra os 12 smoke tests end-to-end com pergunta, resultado, comportamento observado e principais arquivos citados. As execuções ocorreram na janela de 25/08/2026, 14:11–14:33, horário de São Paulo.

O RTC anterior tinha 16 nós, 15 arestas e três baselines. O readback atual confirma 4 nós, 3 arestas, zero tools, zero Memory e somente o dataset `51ab3fd09e2011f193041d6729b8d591`.

### GPT personalizado × RAGFlow — canário RTC

Pergunta pareada: “Quais campos devo fornecer para revisar uma NF-e e a classificação no ERP sem fechar uma decisão final?”

| Controle | GPT personalizado + Chroma | Agent RAGFlow |
|---|---|---|
| Retrieval | Action `search_day_rag_corpus...` | nó Retrieval no dataset RTC próprio |
| Conceitos centrais | XML, ERP/versão, CST, cClassTrib, IndOp, NCM, operação e revisão | os mesmos conceitos; acrescentou NBS, origem/destino, data e evidências de erro |
| Limite | não fechou classificação; pediu validação oficial e profissional | não fechou classificação; pediu tabela vigente e validação profissional |
| Fontes | citou URL oficial limpa e metadados do Chroma | citou `04-dfe-erp-classificacao.md`, canônicos e o PDF oficial do Manual CBS |
| Estilo | mais detalhado, em seis grupos | mais conciso e orientado a checklist |

Resultado: ambos atenderam ao objetivo e aos guardrails, mas isso é uma comparação funcional entre arquiteturas diferentes, não prova de equivalência de modelo, prompt ou orquestração. A conversa do GPT ficou registrada em [Revisar NF e Classificação ERP](https://chatgpt.com/g/g-6a1b93a521b4819189fda957bcf00115-agente-reforma-tributaria-day-consulta-rag/c/6a8dcf26-ab60-83e9-8747-b955fda7a8df).

### Diferenças de capacidade ainda existentes

- O RTC online usa uma Action Chroma. No RAGFlow, ela foi substituída pelo retrieval nativo no corpus migrado.
- GPTs que tinham Busca na Web continuam sem Web no MVP RAGFlow. Logo, há paridade de corpus, identidade adaptada e comportamento básico, não paridade funcional completa de todas as capacidades do Builder.
- Nenhum Agent foi publicado; todos permanecem internos para validação.

## Validação humana recomendada

1. Abra o Agent de cada linha e clique em **Run**.
2. Faça uma pergunta claramente pertencente ao agente e confirme que as citações exibidas são somente do dataset daquela linha.
3. Faça uma pergunta que pertence a outro agente. O Agent deve declarar falta de base, não buscar no dataset de outro GPT.
4. Nos 11 GPTs com anexos, confira dois nomes de arquivos citados contra a tela **Files** e contra o repositório indicado.
5. No GPT `Reforma Tributária — Oficial`, confirme que o retrieval retorna vazio; isso reproduz o estado online atual, que tem zero anexos ativos.
6. No RTC, valide uma pergunta de classificação de DF-e e uma pergunta que exija fonte oficial. O arquivo `ART-1F8BD0D7E74A__source.bin.html` deve continuar desabilitado e nunca aparecer como citação.
7. Compare a mesma pergunta no GPT personalizado e no Agent RAGFlow. Julgue separadamente: fonte recuperada, aderência às instruções, limites/abstenção e utilidade da resposta.
8. Não publique os Agents nem apague os sete datasets experimentais/antigos antes dessa assinatura humana.

## Objetos mantidos fora do MVP operacional

- Os datasets `STG RTC 2.3 — EXP ...` e os três baselines RTC antigos permanecem apenas como histórico/experimento até a validação humana. Eles não estão ligados aos 12 Agents canônicos.
- O Agent `STG — RASCUNHO — Captação — NÃO USAR` está isolado e não deve ser usado. Sua remoção exige confirmação explícita.
- RAPTOR e GraphRAG permanecem congelados; não foram ativados sem evidência de ganho.
- Memory não foi conectada aos Agents; conteúdo normativo não é gravado como memória de conversa.
- Os Agents foram salvos internamente, mas não publicados.
