# Modelo de testes e matriz inicial do Front Web

**Atividade:** [LLT-83](https://logviewer2026.atlassian.net/browse/LLT-83) · **Versão:** 8 · **Data:** 15/10/2026

Este documento reúne o modelo para copiar, um exemplo preenchido e a matriz inicial de cobertura do Front Web. O modelo descreve cada teste; a matriz relaciona os requisitos aos planos de Ocorrências, dashboards e login. A organização segue o [plano da LLT-86](https://docs.google.com/document/d/1W4dsdN3F6DSZo3ZSR_9TGUqEb7kDmHgO65C_Gd-EV6k/edit).

A matriz contém **16 requisitos de origem**. O exemplo contém **um cenário parametrizado com dois exemplos fictícios**. Esta entrega é de planejamento: não foram criados testes automatizados nem executados testes da aplicação.

## Como usar

As seções agrupam informações por assunto; não são etapas de um único fluxo. Cada cenário deve ter preparação própria e resultado verificável. No plano de cada módulo, numerar os cenários na ordem de leitura, sem saltos, e atualizar as referências quando a ordem mudar.

1. Leia as regras comuns e consulte a matriz para localizar o requisito e o plano do módulo.
2. Copie somente o conteúdo entre INÍCIO DO MODELO e FIM DO MODELO. Preserve o modelo original em branco.
3. Preencha os campos amarelos, escreva o cenário e informe a origem do resultado esperado.
4. Use `Esquema do Cenário` e `Exemplos` quando o comportamento se repetir com entradas diferentes. Cada linha representa uma execução independente. Para um único comportamento sem variações, use `Cenário` e retire a tabela.
5. No código do LhamaLog, escreva o teste e comprove Red por comportamento ausente; implemente para Green; avalie Refactor e confira os testes relevantes.
6. Registre o resultado e a evidência de cada cenário, exemplo e camada executados.

**Amarelo #ffff00 e PREENCHER** identificam onde preencher. Substitua a orientação pela resposta e retire o amarelo após conferir. Em OBS, registre a observação ou escreva Sem observações. Quando um campo não se aplicar, registre Não aplicável com justificativa.

Retirar o amarelo indica que o campo foi tratado. Marcar um checkbox indica que a ação foi realizada com evidência. Nenhuma dessas marcações, isoladamente, significa teste aprovado ou conclusão da tarefa.

**Markdown:** títulos, campos com nomes explícitos, tabelas e checkboxes preservam o significado sem a cor. O Docs pode acrescentar escapes de apresentação ao exportar. O Markdown de trabalho mantém os blocos Gherkin delimitados; a exportação nativa deve ser conferida antes de usá-la diretamente com Cucumber.

## Regras comuns e responsabilidades

- Os ADRs vigentes orientam as regras de backend e têm prioridade sobre referências conflitantes. O Figma orienta a interface dentro dessas regras.
- Cada caso informa ID, USID, tela ou componente, pré-condições, dados fictícios, ação, resultado observável, Cliente ou Empresa, Produto, estado do planejamento e referência do teste automatizado quando existir.
- Identifique se o resultado está documentado na fonte ou é hipótese. Uma hipótese não deve virar expectativa aprovada por dedução. O modelo oferece o campo de classificação; o exemplo abaixo usa somente o comportamento descrito no USID_002.
- Não fixar mensagens, limites, tecnologias ou permissões sem fonte. Nos cenários de contrato, usar a operação e a resposta realmente consumidas pelo Front.
- Utilizar somente dados fictícios. Evidências não devem conter logs identificáveis, senhas utilizáveis, tokens, credenciais, códigos ou sessões reais.
- A especificação BDD descreve comportamento; Data-Driven Testing organiza as variações na tabela de exemplos. Cucumber exige passos implementados para executar esses cenários.
- O ciclo TDD cobre o código sob responsabilidade do LhamaLog. Em verificações externas do provedor, registrar a evidência do contrato; Red e Refactor podem ser Não aplicável com justificativa.

### Camadas de teste

| Identificação | O que verifica | Evidência |
| --- | --- | --- |
| `@componente @front` | Estados e comportamento do componente ou adaptador do LhamaLog | Renderização isolada com dependências controladas |
| `@pagina @front` | Tela, navegação, validação local e resultado mostrado ao usuário | Página com estados e respostas controlados |
| `@front @contrato` | Tratamento de retornos conhecidos e inesperados | Simulação na fronteira consumida pelo SDK ou pela API |
| `@api` | Validação e efeitos do serviço real | Requisição direta em ambiente de teste, identificando Core ou provedor |
| `@integracao` | Funcionamento real entre Front e serviços | Fluxo com dados fictícios, ambiente e configuração registrados |

Escolha a camada apropriada para cada cenário. Uma resposta simulada comprova o tratamento do Front; não comprova a validação real no backend. Testes complementares de API devem ficar em anexo próprio no plano do módulo.

## 1 Modelo em branco para copiar

**INÍCIO DO MODELO**

### Identificação e preparação do cenário

- ID e título: PREENCHER Cenário 01 e comportamento verificado
- Plano ou tarefa: PREENCHER nome e link
- USID de origem: PREENCHER identificador, descrição e referência da fonte
- Regra de referência: PREENCHER ADR ou outro documento e trecho aplicável
- Tela ou componente: PREENCHER nome e referência visual
- Camada e responsabilidade: PREENCHER componente, página, contrato, API ou integração
- Cliente ou Empresa: PREENCHER contexto autorizado
- Produto: PREENCHER Produto autorizado ou Não aplicável com justificativa
- Pré-condições: PREENCHER identidade fictícia, sessão, permissões e estado inicial
- Dados fictícios: PREENCHER os registros e as entradas necessários
- Base do resultado esperado: PREENCHER Documentado com fonte ou Hipótese identificada
- Estado do planejamento: PREENCHER Pronto ou Pendente de decisão conforme a fonte, sem confundir com execução
- Responsável e data do preenchimento: PREENCHER
- OBS do planejamento: PREENCHER observação ou Sem observações

### Comportamento e exemplos do modelo

Substitua os campos PREENCHER, as tags e os valores entre sinais de menor e maior. O texto abaixo é um molde de escrita; não é um teste executável da aplicação.

```gherkin
# language: pt
@USID_PREENCHER @pagina @front
Funcionalidade: PREENCHER o assunto do teste

  Esquema do Cenário: 01 PREENCHER o comportamento - <exemplo>
    Dado que PREENCHER a preparação e o contexto autorizado
    E os dados fictícios são <entrada>
    Quando PREENCHER a ação do usuário
    Então devo observar <resultado>

    Exemplos:
      | exemplo | entrada | resultado |
      | PREENCHER identificação | PREENCHER dados fictícios | PREENCHER resultado observável |
```

### Acompanhamento TDD do modelo

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Registro de execução do modelo

Copie o registro para cada cenário, exemplo, camada e execução. O estado inicial é Não executado, com TDD não iniciado e checkboxes desmarcados.

- Cenário e exemplo: PREENCHER
- Camada e responsabilidade: PREENCHER
- Ambiente e perfil: PREENCHER
- Resposta simulada ou real: PREENCHER
- Navegador viewport zoom e tecnologia assistiva: PREENCHER ou Não aplicável com justificativa
- Etapa: PREENCHER Red, Green, Refactor ou verificação de contrato
- Teste automatizado: PREENCHER link ou caminho, ou Não existe
- Resultado: PREENCHER Não executado, Passou, Falhou ou Não aplicável com justificativa
- Evidência e contrato: PREENCHER referência sem segredos ou Não existe
- OBS: PREENCHER observação ou Sem observações

**FIM DO MODELO**

## 2 Exemplo preenchido para consulta

**EXEMPLO PREENCHIDO — CONSULTAR SEM ALTERAR O MODELO EM BRANCO**

Este exemplo mostra como preencher o modelo para a abertura de uma Ocorrência. Confere a correspondência entre o item selecionado e o detalhe exibido. Não especifica formato de data nem regras de mascaramento de dados.

### Identificação e preparação do exemplo

- ID e título: Cenário 01 Abrir o detalhe da Ocorrência selecionada
- Plano ou tarefa: [LLT-84 Testes de Ocorrências](https://logviewer2026.atlassian.net/browse/LLT-84), usando o modelo da LLT-83
- USID de origem: USID_002 Consultar Ocorrência, na [planilha de casos de uso](https://docs.google.com/spreadsheets/d/1JObvNfZAJvCPjG4urP4OZKHVhKFNyCeVq1w2w8agRb0/edit), linhas A12:B13 da aba correspondente
- Regra de referência: USID_002, seleção de uma Ocorrência e abertura de seu detalhe
- Tela ou componente: [Figma LhamaLog](https://www.figma.com/design/e88SaMez3hQZ0nmmC3uEtm/LhamaLog?node-id=3-114), página Completo, grupo Ocorrencia Reformulado com padrão, detalhe da Ocorrência
- Camada e responsabilidade: página Front com resposta controlada do Core
- Cliente ou Empresa: Empresa Exemplo A
- Produto: Produto Alfa, acessível à conta fictícia
- Pré-condições: Ana Exemplo com sessão ativa e acesso ao Produto Alfa; lista carregada com duas Ocorrências fictícias; consulta do detalhe preparada para cada item
- Dados fictícios: Ocorrência Exemplo 01 e Ocorrência Exemplo 02, pertencentes ao Produto Alfa; conteúdo de detalhe identificado pelo respectivo registro
- Base do resultado esperado: comportamento documentado no USID_002; fixture fictícia e escolha da camada definidas neste exemplo
- Estado do planejamento: Pronto para revisão deste recorte documentado; não significa teste realizado ou aprovação formal registrada
- Responsável e data do preenchimento: exemplo de documentação da LLT-83, 15/10/2026
- OBS do planejamento: Sem observações para este recorte de seleção e abertura

### Cenário 01 Abrir o detalhe da Ocorrência selecionada

```gherkin
# language: pt
@USID_002 @pagina @front
Funcionalidade: Consultar uma Ocorrência do Produto autorizado

  Esquema do Cenário: 01 Abrir o detalhe da Ocorrência selecionada - <exemplo>
    Dado que Ana Exemplo está conectada e pode acessar a Empresa Exemplo A e o Produto Alfa
    E a lista contém a Ocorrência fictícia <ocorrencia>
    E a consulta de detalhe está preparada para esse mesmo registro
    Quando seleciono <ocorrencia> na lista
    Então devo visualizar o detalhe correspondente a <ocorrencia>
    E o conteúdo apresentado não deve corresponder a outro registro da lista

    Exemplos:
      | exemplo | ocorrencia |
      | primeiro registro | Ocorrência Exemplo 01 |
      | segundo registro | Ocorrência Exemplo 02 |
```

### Acompanhamento TDD do exemplo

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Registro de execução do exemplo

- Cenário e exemplo: Cenário 01, executar separadamente cada uma das duas linhas de Exemplos
- Camada e responsabilidade: página Front
- Ambiente e perfil: Não executado
- Resposta simulada ou real: resposta controlada planejada; não executada
- Navegador viewport zoom e tecnologia assistiva: Não executado
- Etapa: TDD não iniciado
- Teste automatizado: Não existe
- Resultado: Não executado
- Evidência e contrato: Não existe evidência de execução; fonte do comportamento USID_002
- OBS: Não executado

**FIM DO EXEMPLO PREENCHIDO**

## 3 Matriz inicial de cobertura

A matriz organiza os 16 requisitos de origem e o destino do detalhamento. Cada linha representa cobertura de planejamento; não representa um teste executado nem substitui os cenários do módulo. Os rótulos de cobertura descrevem o recorte, sem aprovar detalhes de interface por dedução.

| Requisito de origem | Cobertura a detalhar | Plano e escopo |
| --- | --- | --- |
| USID_001 Visualizar Ocorrências | Lista, estados retornados, carregamento e ausência de registros | LLT-84 Ocorrências |
| USID_002 Consultar Ocorrência | Seleção, abertura do detalhe correspondente e retorno à consulta | LLT-84; exemplo preenchido neste documento |
| USID_003 Marcar Ocorrência | Ação permitida, cancelamento e tratamento de falha conforme contrato | LLT-84 Ocorrências |
| USID_004 Arquivar Ocorrência | Ações de arquivamento, confirmação e cancelamento previstas nas fontes | LLT-84 Ocorrências |
| USID_005 Filtrar Ocorrências | Aplicação e limpeza dos filtros, resultados e paginação conforme contrato | LLT-84 Ocorrências |
| USID_031 Visualizar dashboard | Seleção de Produto e apresentação de indicadores retornados | LLT-85 Dashboards e relatórios |
| USID_032 Filtrar dashboard | Aplicação de filtros e tratamento das entradas conforme contrato | LLT-85 Dashboards e relatórios |
| USID_033 Exportar relatório | Exportação com os filtros aplicados e comportamento de cancelamento previsto na fonte | LLT-85 Dashboards e relatórios |
| USID_034 Dashboard empresarial | Indicadores dos Produtos autorizados e tratamento de acesso negado | LLT-85 Dashboards e relatórios |
| USID_035 Relatório empresarial | Exportação dos dados autorizados e tratamento de recusa | LLT-85 Dashboards e relatórios |
| USID_036 Filtros empresariais | Aplicação, alteração e remoção de filtros; ausência de resultados | LLT-85 Dashboards e relatórios |
| USID_037 Ocorrências de vários Produtos | Consulta filtrada limitada aos Produtos autorizados | LLT-85 Dashboards e relatórios |
| USID_048 Manter usuário | Identidade e chegada à área inicial no recorte de login | LLT-86 cobre esse recorte; administração e checkout estão fora do plano de login |
| USID_049 Login Web | Componentes Clerk, entrada, MFA, sessão e recuperação de acesso | LLT-86, cenários 01 a 43; contratos complementares no anexo 44 a 47 |
| USID_050 Login Mobile | Referência de origem, sem dependência do Mobile no login Web | Fora da execução Mobile da LLT-86, conforme ADR_025 |
| USID_051 Segundo fator | Cadastro, desafio, backup e recuperação de MFA pela Clerk | LLT-86; MFA obrigatório conforme ADR_024 e perfil do ADR_123 |

Os planos de Ocorrências e dashboards devem vincular seus cenários às regras vigentes e às referências visuais aplicáveis. A LLT-83 entrega o modelo e o mapa inicial; o planejamento detalhado pertence às respectivas atividades.

## 4 Conferência da entrega de planejamento

Os checkboxes abaixo registram a conferência formal da entrega; não marcam execução dos cenários da aplicação.

### Checklist de revisão do documento

- [ ] Conferi o modelo, o exemplo preenchido e os 16 requisitos da matriz
- [ ] Conferi as fontes, o estado do resultado esperado e a separação das camadas
- [ ] Registrei a revisão do formato para uso no ciclo de testes antes do código
- [ ] Registrei a correspondência com as telas de referência aplicáveis

- Registro da revisão: PREENCHER data, responsável e referência
- OBS da revisão: PREENCHER observação ou Sem observações

## Referências

- [LLT-83 Modelo e matriz de cobertura](https://logviewer2026.atlassian.net/browse/LLT-83)
- [LLT-84 Plano de Ocorrências](https://logviewer2026.atlassian.net/browse/LLT-84)
- [LLT-85 Plano de dashboards e relatórios](https://logviewer2026.atlassian.net/browse/LLT-85)
- [LLT-86 Plano de login e acesso Web](https://docs.google.com/document/d/1W4dsdN3F6DSZo3ZSR_9TGUqEb7kDmHgO65C_Gd-EV6k/edit)
- [Casos de uso do LhamaLog](https://docs.google.com/spreadsheets/d/1JObvNfZAJvCPjG4urP4OZKHVhKFNyCeVq1w2w8agRb0/edit)
- [Figma LhamaLog](https://www.figma.com/design/e88SaMez3hQZ0nmmC3uEtm/LhamaLog?node-id=3-114), página Completo e versões com padrão
- [Pasta da entrega no Drive](https://drive.google.com/drive/u/0/folders/1_1bz9VEWib4hEzZGeC4Y2RP5ekIBnSZq)
- [Pasta oficial dos ADRs](https://drive.google.com/drive/folders/1SsRGM7_f7WD8L0O4GnozbosImt8zReTs)
- [ADR_024 MFA obrigatório](https://docs.google.com/document/d/14pbDhYPqqaljM0Lb_92sseTxFWwGTtbCtn_jG2hYd6Q/edit)
- [ADR_025 Mobile em standby](https://docs.google.com/document/d/1OMX1A9bp_loIrNCdkeYdsmYjKCQaCuM6Y5vnxqbin2A/edit)
- [ADR_123 Clerk Student e papéis](https://docs.google.com/document/d/1C3ukxyHxFyL8H5qGMTYJgBFaz8TWTEYEPkDaTbn5Xdg/edit)
