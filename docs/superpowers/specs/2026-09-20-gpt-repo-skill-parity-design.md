# Arquitetura de paridade GPT → repositório → skill

**Data:** 2026-09-20  
**Status:** proposta para validação humana  
**Abordagem aprovada:** uma skill por família canônica; cópias e variações viram perfis ou aliases, salvo quando houver capacidade materialmente independente.

## 1. Objetivo

Auditar todos os GPTs personalizados acessíveis, consolidá-los em famílias canônicas e fazer com que cada família tenha:

1. um repositório remoto que preserve instruções, arquivos de Knowledge, ações, ferramentas e proveniência;
2. uma skill versionada, instalável e portátil que reproduza a capacidade do GPT em um harness compatível;
3. testes de paridade estrutural e funcional;
4. evidência legível para validação humana;
5. no caso do agente RAG, validação ponta a ponta do retrieval e das fontes.

O resultado desejado não é uma cópia literal da interface do ChatGPT. É uma distribuição auditável da mesma capacidade, com as diferenças de plataforma explicitadas.

## 2. Evidência de partida

A auditoria autenticada dos editores online encontrou:

- 50 instâncias de GPTs personalizados;
- 28 corpos de instrução únicos;
- 18 combinações distintas de arquivos de Knowledge;
- 349 anexos previamente baixados e comparados por SHA-256, todos iguais entre origem e destino naquela migração;
- 12 repositórios de agentes no catálogo, todos sincronizados com `origin/main` e aprovados pelos validadores estruturais existentes;
- zero repositórios atualmente empacotados como skill (`SKILL.md` ausente em todos);
- um item chamado `asd`, cujo nome, descrição e instrução são apenas `asd`, sem Knowledge, classificado como rascunho/ruído e fora do conjunto canônico até que surja evidência contrária.

As instruções canônicas dos 12 repositórios correspondem byte a byte às instruções atualmente observadas nos GPTs escolhidos como referência, depois de remover apenas cabeçalhos de captura. A paridade de Knowledge é parcial: seis famílias estão completas e seis ainda têm lacunas.

## 3. Modelo de identidade

Quatro camadas evitam confundir cópias com capacidades independentes:

### 3.1 Família canônica

Unidade funcional durável, como Fiscal, Contábil ou RAG. Uma família possui um repositório canônico e uma skill distribuível.

### 3.2 Perfil

Variação intencional dentro da família: oficial, guia, legado, temporário, sala secreta ou compatibilidade. Um perfil pode alterar instruções, starters, ferramentas ou subconjunto de Knowledge sem exigir outra skill.

### 3.3 Instância online

Um GPT concreto identificado por seu ID `g-*`. Várias instâncias podem apontar para o mesmo perfil e diferir apenas em nome, descrição ou visibilidade.

### 3.4 Identidade de distribuição

O pacote instalável da skill, com versão e contrato público. Ele aponta para uma família canônica, oferece seleção explícita de perfil e não depende do nome editorial de uma instância online.

## 4. Topologia canônica proposta

O catálogo final terá 12 famílias ativas:

1. Captação de Clientes
2. Contábil
3. Departamento Pessoal
4. Entrada de Clientes
5. Estrategista de Conteúdo DAI
6. Fiscal
7. Guia de Operação
8. Processos do Escritório
9. Reforma Tributária RAG
10. Reforma Tributária sem Surto
11. Societário
12. Concierge

### Reforma Tributária

O GPT ativo “Agente da Reforma Tributária | Oficial” é a mesma capacidade do RAG legado: instruções idênticas, os mesmos oito documentos e a mesma Action, com diferenças apenas editoriais. Não há evidência de uma família ativa não-RAG separada.

Por isso:

- `ac.reforma-tributaria-rag` permanece como família canônica;
- `ac.reforma-tributaria` não será apagado: será preservado como repositório de compatibilidade/depreciação e encaminhará ao perfil legado da família RAG;
- o Concierge, que possui instruções próprias e 12 documentos únicos, ganha repositório e skill canônicos;
- o número de famílias ativas continua sendo 12.

## 5. Contrato de cada repositório/skill

Cada repositório canônico deverá conter somente o necessário para reproduzir, auditar e instalar a capacidade:

- `SKILL.md`: gatilhos, propósito, fluxo operacional, limites e seleção de perfil;
- `agents/openai.yaml`: metadados de apresentação e invocação, quando suportados pelo harness;
- manifesto do agente: identidade, versão, GPTs relacionados e perfil padrão;
- instruções normalizadas por perfil, preservando também o hash do texto bruto observado;
- Knowledge canônico, sem alterar silenciosamente os anexos originais;
- inventário com nome original, SHA-256, origem, data de obtenção, estado e perfil consumidor;
- definições de Actions e integrações, sem segredos;
- `references/` apenas para conteúdo de apoio que não deve ocupar o corpo principal da skill;
- `scripts/` apenas para validações determinísticas ou operações repetíveis que tragam valor real;
- testes e cenários de aceitação;
- relatório de paridade e lacunas conhecidas.

Arquivos duplicados não serão copiados entre perfis quando puderem ser referenciados com rastreabilidade. Credenciais, chaves e tokens nunca serão versionados.

## 6. Precedência das fontes de verdade

Quando houver divergência, a decisão seguirá esta ordem:

1. **GPT online autenticado:** verdade operacional da configuração atualmente publicada.
2. **Arquivo original obtido do GPT ou da fonte oficial:** verdade binária do Knowledge.
3. **Repositório remoto canônico:** verdade versionada que deve convergir para o estado aprovado.
4. **Cópia local:** área de trabalho, nunca evidência suficiente sozinha.
5. **Relatórios históricos:** evidência temporal, não substituem uma nova verificação.

Toda reconciliação registrará a direção da mudança. Nenhum arquivo online ou do repositório será sobrescrito sem um diff e uma decisão explícita.

## 7. Dimensões de paridade

A matriz por GPT/instância verificará:

- ID, nome, descrição e starters;
- instruções brutas e normalizadas, tamanho e SHA-256;
- lista, nome original, tamanho e SHA-256 de cada arquivo de Knowledge;
- ferramentas habilitadas;
- Actions: domínio, OpenAPI normalizado, operações e autenticação declarada;
- modelo e recursos de interface, quando o valor puder ser verificado de forma estável;
- perfil e família de destino;
- comportamento em cenários funcionais;
- versão do repositório e da skill que representam o estado observado;
- lacunas, exceções e decisão humana.

Os campos instáveis ou não exportáveis serão marcados como “não verificável”, e não como iguais.

## 8. Lacunas atuais de Knowledge

Há 11 arquivos presentes nos GPTs de referência e ausentes nos respectivos repositórios:

### Captação de Clientes — 5

- `00-INDICE-COMERCIAL.md`
- `09-PROSPECCAO-ATIVA-ICP-LISTAS-E-CADENCIAS.md`
- `10-DIAGNOSTICO-REUNIAO-SPIN-NEPQ.md`
- `11-CRM-PIPELINE-REVOPS-E-METRICAS.md`
- `12-HANDOFFS-ENTRE-AGENTES-E-BRIEFINGS.md`

### Contábil — 1

- `00-INDICE-CONTABIL.md`

### Entrada de Clientes — 1

- `00-INDICE-ONBOARDING.md`

### Estrategista de Conteúdo DAI — 2

- `00-INDICE-CONTEUDO-DAI.md`
- `09-BANCO-DE-ANGULOS-E-ROTEIROS.md`

### Fiscal — 1

- `00-INDICE-FISCAL.md`

### Societário — 1

- `00-INDICE-SOCIETARIO.md`

Os seis conjuntos já completos são DP (16/16), Guia de Operação (16/16), Processos (4/4), Reforma Tributária RAG (8/8), Reforma sem Surto (6/6) e Reforma compatibilidade (0/0). A igualdade binária conhecida é baseada no download de 2026-09-09; antes do fechamento deverá haver nova obtenção ou confirmação de hash para o estado corrente.

## 9. Caso especial: Reforma Tributária RAG

Essa família combina quatro elementos que precisam ser versionados separadamente:

1. instruções e perfis do agente;
2. oito anexos de Knowledge do GPT;
3. contrato OpenAPI da Action;
4. serviço de retrieval e seu corpus externo.

O serviço atual respondeu saudável com corpus `v2.3.0-20260801`, base `ac-staging`, coleção `day_rtc_v2_3_20260801` e modo `chroma_cloud_v2_3`.

Existe, porém, uma lacuna crítica: o schema OpenAPI atualmente configurado no GPT não é byte a byte igual a nenhuma das três versões armazenadas no repositório. O schema online declara versão `0.1.0`, expõe `/rag/search` e `/health` e exige na resposta `answer_summary`, `citations`, `retrieved_chunks`, `source_status` e `gaps`. Essa divergência deverá ser resolvida antes de declarar paridade.

A migração futura do corpus para RAGFlow é uma evolução de backend. Ela não muda o contrato público da skill sem versionamento, e deverá manter um perfil/adapter que permita comparar Chroma, RAGFlow e o GPT personalizado durante a transição.

## 10. Validação de retrieval

A validação não dependerá de uma posição exata no top 3, porque o ranking observado varia. Será usado um conjunto versionado de perguntas representativas, incluindo legislação, interpretação contábil, exceções, datas, cálculos, ausência de evidência e conflito entre fontes.

Para cada pergunta serão comparados quatro caminhos:

- GPT personalizado online;
- skill em harness limpo;
- serviço de retrieval diretamente;
- documentos originais citados.

Cada execução avaliará:

- presença das fontes esperadas e autoridade delas;
- cobertura dos pontos essenciais;
- correção das citações e capacidade de localizar o trecho;
- fidelidade temporal e normativa;
- tratamento de lacunas e incerteza;
- ausência de afirmações não suportadas;
- consistência entre resposta, chunks e documento original;
- latência e falhas operacionais como métricas auxiliares.

O relatório preservará resultados brutos e uma rubrica humana. Mudanças de ranking serão aceitas quando mantiverem fonte, cobertura e correção; regressões materiais bloquearão a versão.

## 11. Sequência de execução

### Fase 1 — Congelar a auditoria

Registrar a matriz das 50 instâncias, hashes, perfis, famílias e evidências, com data de observação e campos não verificáveis.

### Fase 2 — Reconciliar repositórios

Recuperar os 11 anexos faltantes, resolver divergências, criar o repositório do Concierge e transformar `ac.reforma-tributaria` em compatibilidade sem apagar histórico.

### Fase 3 — Piloto completo no RAG

Empacotar primeiro a skill RAG, capturar e versionar o schema online correto, testar a Action e executar a comparação de retrieval com fontes originais. O piloto define o padrão para as demais skills.

### Fase 4 — Converter as demais famílias

Aplicar o contrato aprovado a cada família, preservando os perfis necessários e eliminando duplicação apenas quando a equivalência tiver evidência.

### Fase 5 — Instalação limpa

Instalar cada skill em um harness sem dependências implícitas do computador de origem, executar validação estrutural e cenários funcionais e registrar incompatibilidades de plataforma.

### Fase 6 — Publicação e validação humana

Versionar releases, atualizar o catálogo, gerar relatório consolidado e submeter nomes, perfis, lacunas, resultados de retrieval e decisões de depreciação à aprovação humana.

## 12. Critérios de aceite

Uma família só será declarada pronta quando:

- todas as instâncias relacionadas estiverem mapeadas;
- instruções, Knowledge, ferramentas e Actions tiverem estado comprovado ou lacuna explícita;
- arquivos de Knowledge tiverem nome original e SHA-256;
- o repositório remoto estiver sincronizado com o estado aprovado;
- a skill passar pela validação estrutural oficial e por instalação limpa;
- os cenários funcionais mínimos passarem;
- diferenças inevitáveis entre ChatGPT e harness estiverem documentadas;
- nenhuma credencial estiver versionada;
- houver validação humana registrada.

Para o RAG, também é obrigatório:

- contrato OpenAPI online e versionado reconciliados;
- serviço saudável;
- conjunto de perguntas executado nos quatro caminhos;
- citações conferidas contra os documentos originais;
- regressões e diferenças de ranking analisadas;
- aprovação humana do relatório comparativo.

O objetivo global estará concluído quando as 12 famílias ativas atenderem esses critérios e o catálogo permitir rastrear, para qualquer skill, a instância GPT, o perfil, o commit, os arquivos e a evidência de validação correspondentes.

## 13. Fora de escopo

- manter 50 skills separadas apenas porque existem 50 instâncias;
- publicar chaves ou credenciais;
- tratar similaridade temática como prova de origem ou equivalência;
- reescrever o conteúdo dos anexos durante a preservação;
- prometer equivalência de recursos que o harness não oferece;
- apagar repositórios, histórico ou perfis legados antes de aprovação humana;
- considerar o item `asd` uma família canônica sem nova evidência.

