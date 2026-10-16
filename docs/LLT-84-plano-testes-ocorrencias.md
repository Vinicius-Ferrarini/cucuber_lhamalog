# Plano de testes de Ocorrências do Front Web

**Atividade:** [LLT-84](https://logviewer2026.atlassian.net/browse/LLT-84) · **Versão:** 1 · **Data:** 16/10/2026

Plano BDD com exemplos orientados por dados para visualizar, consultar, marcar, arquivar e filtrar Ocorrências antes da implementação do Front Web. Usa o modelo da LLT-83 e a organização da LLT-86. São **41 cenários**, com 27 esquemas parametrizados e 14 cenários simples, totalizando **89 execuções especificadas**. O corpo principal reúne os cenários 01 a 38; o anexo contém as verificações complementares de backend 39 a 41.

Todos os testes começam **não executados**, sem automação criada e com TDD desmarcado. Planejamento escrito não comprova teste aprovado, revisão formal ou conclusão da LLT-84. Esta atividade produz o plano; não implementa a aplicação.

## Como usar

As seções agrupam testes por assunto. Cada cenário é independente, com preparação própria. A numeração segue a ordem de leitura sem saltos, incluindo o anexo.

1. Leia as regras e prepare o contexto fictício de Empresa e Produto.
2. Escolha o cenário completo com USID, fonte, camada, pré-condições e exemplos.
3. Execute cada linha de Exemplos como um teste independente.
4. Escreva o teste do código do LhamaLog e comprove Red por comportamento ausente; falha de configuração não conta como Red.
5. Implemente o necessário para Green e confira os testes relevantes.
6. Avalie Refactor, registre a alteração ou Nenhuma alteração necessária e confirme os testes novamente.
7. Registre resultado, camada, ambiente, referência do teste e evidência de cada execução.

Amarelo **#ffff00** e **PREENCHER** indicam campos a tratar. Substitua a orientação pela resposta e retire o amarelo após conferir. Em OBS, escreva a observação ou Sem observações. Checkboxes só devem ser marcados após a ação comprovada. A ausência de amarelo não significa que o teste passou.

BDD descreve o comportamento; a tabela de Exemplos aplica Data-Driven Testing. Cucumber exige passos implementados para executar o Gherkin. Os blocos deste plano não são automação já criada. O Markdown de trabalho mantém os blocos delimitados; conferir a exportação nativa do Docs antes de usá-la diretamente em Cucumber, pois ela pode acrescentar escapes e alterar a apresentação dos blocos.

## Regras vigentes e preparação comum

### Fontes e limites do resultado esperado

- USID_001–005 definem listagem, consulta, marcação, arquivamento, filtros e paginação. Exemplos de mensagens, quantidades e status apresentados na planilha não viram regras finais por dedução.
- Os ADRs vigentes têm prioridade sobre a planilha e o Figma em regras de backend. O Figma consultado é Completo, v02, Ocorrencia Reformulado com padrão. A tela orienta apresentação e navegação; não altera enums ou permissões.
- ADR_035 e ADR_062: cada Ocorrência é um registro concreto de erro ou warning; o resumo de Arquivo é outro agrupador. SPAM não gera Ocorrência. O Front recebe a gravidade do serviço, sem calcular a matriz de criticidade.
- ADR_063 e ADR_074: recorrência é atributo booleano, independente de tipo e estado; a verificação de semelhança e a janela por Produto pertencem ao backend. Não exigir um tipo RECORRENTE nem limiar de 3 ou 4 repetições na UI.
- ADR_082: estados de ciclo de vida ABERTA, EM_ANALISE e FECHADA; transições ABERTA para EM_ANALISE ou FECHADA, EM_ANALISE para FECHADA, FECHADA para ABERTA. Os testes de mudança manual usam contexto sem recurso de IA, conforme a decisão. Não ampliar por dedução a disponibilidade dessa ação em outros perfis.
- ADR_089: pedir ou enfileirar Sugestão não muda o estado; Sugestão DISPONIVEL leva de ABERTA a EM_ANALISE. Fechar Sugestão não fecha Ocorrência; fechar Ocorrência exige Sugestões válidas finalizadas. ADR_090: falha de Sugestão manual não aparece na lista nem bloqueia fechamento.
- USID_004: arquivar oculta o registro da lista ativa após confirmação e autorização. Arquivamento é distinto de estado e de exclusão definitiva. Usar a operação do contrato sem inventar rota, flag, estado ARQUIVADA, restauração ou regra de atomicidade do lote.
- ADR_121, ADR_122 e ADR_126: tenant é Empresa; DONO e ADMIN veem os Produtos da própria Empresa, MEMBRO precisa de AcessoProduto. Negação simples retorna à área inicial mantendo a sessão. Não confundir com o 403 de revogação da ADR_032. Não fixar papéis autorizados a marcar ou arquivar sem contrato da operação.
- ADR_141: chamadas de negócio do navegador vão ao Core. O Front não consulta banco, Finder, Varredura ou serviço de Ocorrência diretamente.
- ADR_101 permite consultas por Produto, lote e arquivo. O plano verifica a navegação por lote ou arquivo quando esse recorte está exposto na interface; não cria uma tela nova por dedução.
- Mensagens são verificadas pelo significado, sem texto literal novo, exceto Você foi deslogado da ADR_032. Rotas, códigos de erro, formatos de data, paginação e campos são os do contrato real. Não criar um prazo, tamanho máximo de busca ou lista final de gravidades neste plano.
- Os cenários com `@criterio_front` são critérios de qualidade definidos neste plano, e não decisões de backend atribuídas aos ADRs. Tamanhos de viewport, zoom e quantidades da fixture são amostras de teste, sem definir breakpoints ou opções obrigatórias do produto.

### Camadas e evidência

| Tag | Responsabilidade | Como comprovar |
| --- | --- | --- |
| @componente @front | Componente ou adaptador do LhamaLog | Renderização isolada com dependências controladas |
| @pagina @front | Tela, navegação e estado apresentado | Página com respostas controladas do Core |
| @front @contrato | Tratamento de retorno conhecido ou inesperado | Simulação na fronteira realmente consumida |
| @integracao | Front e Core reais no ambiente de teste | Fluxo real e releitura dos dados |
| @api @core | Regra e autorização no backend | Requisição direta sem depender do formulário |

Uma simulação comprova o comportamento do Front; não comprova persistência, validação ou isolamento do serviço real. Em integração, registrar operação, versão e configuração do contrato. Testes de API são complementares e não transferem a implementação de backend para a LLT-84.

### Fixtures e pré-condições

| Fixture | Preparação fictícia |
| --- | --- |
| Ana Exemplo | ana.ocorrencias@example.com, sessão Clerk ativa com MFA concluído; MEMBRO da Empresa Exemplo A e acesso ao Produto Alfa; variante com acesso ao Gama para troca de contexto |
| Administração | Variante DONO ou ADMIN da Empresa Exemplo A; acesso aos Produtos dessa Empresa sem concessão automática a outra Empresa |
| Contextos negativos | Empresa Exemplo B e Produto Beta; conta sem vínculo ou MEMBRO sem AcessoProduto |
| Registros | Ocorrências Exemplo 01, 02 e 03 do Produto Alfa; tipos ERRO e WARNING; estados e flag recorrente preparados por cenário |
| Dados técnicos | Data fictícia 16/10/2026, endpoint /exemplo/consulta, stack FalhaExemplo e payload de erro simulado; nenhum log identificável nem código executável real |
| Busca e filtros | Registros que atendem e não atendem aos critérios; total conhecido; conjunto com várias páginas; respostas atrasadas controladas |
| Mutações | Permissão real da operação e assinatura compatível; mudança manual sem IA; variantes de Sugestões abertas, fechadas e falha manual |
| Arquivamento | Lista ativa com três registros; seleções individuais e de dois itens; contrato preparado para confirmar ou recusar o resultado |

Usar ambiente isolado e dados fictícios. Cada cenário restaura sua fixture, sem depender de outro teste. Não incluir tokens, sessões utilizáveis, credenciais, códigos reais ou logs identificáveis nas evidências. Textos de exemplo no Figma não são dados a copiar para a execução.

## Matriz de cobertura dos requisitos

| Origem | Cenários principais | Resultado observado |
| --- | --- | --- |
| USID_001 Visualizar processados | 01–05, 23, 30–35, 36 | Listagem, vazio, atributos, contexto, proteção e apresentação |
| USID_002 Consultar Ocorrência | 06–11, 19, 30–36 | Pesquisa, detalhe do registro e retorno à consulta |
| USID_003 Marcar Ocorrência | 20–24, 29, 32, 37; API 39–40 | Mudança permitida, cancelamento, recusa e persistência |
| USID_004 Arquivar Ocorrência | 25–29, 32–35, 38; API 39 | Confirmação, cancelamento, lote e remoção da lista ativa |
| USID_005 Filtrar Ocorrência | 12–19, 32–36; API 41 | Critérios combinados, vazio, limpeza e paginação |

Os cenários de contrato deixam explícita a fronteira entre renderizar um resultado controlado e validar a operação real. O recorte de dados técnicos confere o conteúdo retornado; o arquivamento confere o efeito documentado, sem definir sua representação interna. Upload, cálculo da taxonomia/gravidade/semelhança, execução de IA, dashboards e administração de acesso têm seus próprios planos.

## 1 Listagem de Ocorrências

```gherkin
# language: pt
Funcionalidade: 1 Listagem de Ocorrências

  @USID_001 @pagina @front @criterio_front
  Cenário: 01 Mostrar carregamento sem antecipar resultado
    Dado que Ana Exemplo abriu as Ocorrências do Produto Alfa autorizado
    Quando a consulta ao Core ainda não terminou
    Então devo perceber que a lista está carregando
    E não devo visualizar um estado vazio ou uma confirmação de sucesso antes da resposta
    E dados do Produto anteriormente selecionado não devem aparecer como dados do Produto Alfa


  @USID_001 @pagina @front @ADR_035 @ADR_062 @ADR_063
  Esquema do Cenário: 02 Apresentar os registros e atributos retornados - <exemplo>
    Dado que o Core retorna uma Ocorrência fictícia do Produto Alfa com <tipo> e recorrente <recorrente>
    E a resposta inclui a gravidade já calculada pelo serviço de Ocorrência
    Quando a listagem termina de carregar
    Então devo visualizar o registro com seu tipo e os atributos disponibilizados pelo contrato
    E recorrência deve permanecer um atributo independente do tipo e do estado
    E o Front não deve recalcular a gravidade nem criar Ocorrência para SPAM

    Exemplos:
      | exemplo | tipo | recorrente |
      | erro novo | ERRO | false |
      | erro recorrente | ERRO | true |
      | warning novo | WARNING | false |
      | warning recorrente | WARNING | true |


  @USID_001 @pagina @front @criterio_front
  Cenário: 03 Mostrar lista vazia do Produto autorizado
    Dado que Ana Exemplo pode acessar o Produto Alfa
    Quando o Core retorna uma consulta bem-sucedida sem Ocorrências
    Então devo visualizar uma indicação compreensível de ausência de registros
    E não devo visualizar registros fictícios de preenchimento como se fossem reais
    E não devo poder avançar para uma página de resultados inexistente


  @USID_001 @pagina @front @contrato @criterio_front
  Esquema do Cenário: 04 Recuperar a listagem após falha - <exemplo>
    Dado que a consulta da listagem está em andamento
    Quando ocorre <falha>
    Então devo visualizar que não foi possível carregar os dados e ter uma forma de tentar novamente
    E a interface não deve confundir a falha com ausência de registros
    E o carregamento não deve permanecer indefinido

    Exemplos:
      | exemplo | falha |
      | rede | falha de conexão |
      | serviço | erro do Core sem resposta útil |


  @USID_001 @pagina @front @criterio_front
  Cenário: 05 Ignorar resposta atrasada de outro Produto
    Dado que a consulta ao Produto Alfa ainda está em andamento
    E Ana Exemplo possui acesso também ao Produto Gama da mesma Empresa
    Quando seleciono o Produto Gama e a resposta do Alfa chega por último
    Então devo continuar vendo somente o contexto e os dados do Produto Gama
    E a resposta atrasada não deve repor dados ou contadores do Produto Alfa


```

## 2 Busca e detalhe

```gherkin
# language: pt
Funcionalidade: 2 Busca e detalhe

  @USID_002 @pagina @front
  Esquema do Cenário: 06 Buscar Ocorrência por parâmetro suportado - <exemplo>
    Dado que a lista do Produto Alfa está carregada
    E a fixture de consulta associa <entrada> à Ocorrência Exemplo 01
    Quando informo <entrada> na pesquisa e aciono a busca
    Então devo visualizar o resultado correspondente retornado pelo Core
    E a pesquisa deve permanecer limitada ao Produto e à Empresa autorizados

    Exemplos:
      | exemplo | entrada |
      | identificador | identificador fictício OC-EX-01 |
      | texto | termo fictício FalhaExemplo |


  @USID_002 @pagina @front
  Cenário: 07 Informar consulta sem correspondência
    Dado que pesquiso um termo fictício inexistente no contexto autorizado
    Quando o Core retorna sucesso sem correspondência
    Então devo entender que nenhuma Ocorrência foi encontrada para a consulta
    E devo poder alterar ou limpar o termo para pesquisar novamente
    E a interface não deve mostrar esse resultado como erro de comunicação


  @USID_002 @pagina @front @ADR_035
  Esquema do Cenário: 08 Abrir o detalhe do registro selecionado - <exemplo>
    Dado que a listagem contém <ocorrencia> do Produto Alfa
    E a resposta controlada do detalhe pertence a esse mesmo registro
    Quando seleciono <ocorrencia>
    Então devo visualizar o detalhe correspondente ao identificador selecionado
    E não devo receber o detalhe de outra Ocorrência nem um resumo de Arquivo como substituto

    Exemplos:
      | exemplo | ocorrencia |
      | primeiro registro | Ocorrência Exemplo 01 |
      | segundo registro | Ocorrência Exemplo 02 |


  @USID_002 @pagina @front
  Esquema do Cenário: 09 Consultar as abas de dados técnicos - <exemplo>
    Dado que o detalhe da Ocorrência Exemplo 01 foi carregado com dados fictícios
    Quando abro a aba <aba>
    Então devo visualizar <conteudo> do registro selecionado conforme o contrato
    E a troca de aba não deve misturar dados de outra Ocorrência
    E o texto técnico deve ser apresentado como dado sem executar HTML ou script contido na fixture

    Exemplos:
      | exemplo | aba | conteudo |
      | resumo | Visão geral | data e hora e endpoint retornados |
      | pilha | Stack trace | stack trace fictício |
      | corpo | Payload | payload fictício |


  @USID_002 @USID_005 @pagina @front
  Cenário: 10 Voltar ao estado anterior da consulta
    Dado que abri um detalhe a partir de uma pesquisa com filtros e página definidos
    Quando encerro a visualização do detalhe
    Então devo retornar à consulta com o termo os filtros e a página anteriores
    E os registros devem continuar pertencendo ao mesmo contexto autorizado


  @USID_002 @pagina @front @contrato @criterio_front
  Esquema do Cenário: 11 Tratar detalhe indisponível sem mostrar outro registro - <exemplo>
    Dado que solicitei um detalhe autorizado
    Quando o Core informa <resposta>
    Então devo visualizar uma orientação compatível com essa resposta sem dados de outro registro
    E devo poder retornar à consulta
    E não devo reutilizar um detalhe anterior como se fosse o solicitado

    Exemplos:
      | exemplo | resposta |
      | não localizado | registro não encontrado conforme contrato |
      | falha | falha de carregamento do detalhe |


```

## 3 Filtros e paginação

```gherkin
# language: pt
Funcionalidade: 3 Filtros e paginação

  @USID_005 @pagina @front
  Esquema do Cenário: 12 Aplicar um filtro suportado - <exemplo>
    Dado que estou na listagem do Produto Alfa
    E a fixture contém registros que atendem e que não atendem ao filtro <filtro>
    Quando aplico <filtro>
    Então devo visualizar somente os resultados devolvidos para esse critério
    E a consulta deve começar na primeira página com total e navegação coerentes com a resposta

    Exemplos:
      | exemplo | filtro |
      | período | intervalo fictício de datas suportado |
      | tipo | tipo ERRO |
      | estado | estado ABERTA |
      | aplicação | nome ou aplicação admitido no contrato |


  @USID_005 @pagina @front
  Esquema do Cenário: 13 Combinar filtros na mesma consulta - <exemplo>
    Dado que a fixture contém registros que atendem apenas parte dos critérios
    Quando aplico a combinação <combinacao>
    Então a consulta deve transmitir conjuntamente os critérios ao Core
    E devo visualizar apenas os resultados que a resposta identifica para essa combinação
    E o contexto autorizado de Empresa e Produto deve ser preservado

    Exemplos:
      | exemplo | combinacao |
      | data e tipo | período fictício e ERRO |
      | tipo e estado | WARNING e ABERTA |
      | três critérios | período fictício ERRO e EM_ANALISE |


  @USID_005 @pagina @front
  Cenário: 14 Mostrar ausência de resultados filtrados
    Dado que apliquei filtros válidos no Produto Alfa
    Quando o Core informa total zero
    Então devo visualizar que não há Ocorrências para os filtros aplicados
    E os filtros devem continuar disponíveis para correção ou limpeza
    E os controles para avançar em resultados inexistentes devem estar ocultos ou indisponíveis


  @USID_005 @pagina @front
  Cenário: 15 Limpar filtros e retornar à primeira página
    Dado que estou em outra página com uma pesquisa e filtros ativos
    Quando aciono a limpeza dos filtros
    Então os critérios devem ser removidos e a lista sem filtros deve ser consultada na primeira página
    E a Empresa e o Produto autorizados devem permanecer selecionados
    E totais e navegação devem corresponder à nova resposta


  @USID_005 @pagina @front
  Esquema do Cenário: 16 Navegar mantendo os filtros ativos - <exemplo>
    Dado que há várias páginas de resultados com filtros ativos
    Quando aciono <controle>
    Então a requisição da página solicitada deve manter os mesmos critérios e contexto autorizado
    E devo visualizar os itens e a indicação de página retornados sem misturar páginas

    Exemplos:
      | exemplo | controle |
      | avançar | próxima página |
      | voltar | página anterior |
      | escolher | número de página disponível |


  @USID_005 @pagina @front
  Esquema do Cenário: 17 Alterar a quantidade por página sem perder filtros - <exemplo>
    Dado que a fixture do contrato disponibiliza as opções de quantidade 10 e 50
    E estou em uma página posterior com filtros ativos
    Quando escolho a quantidade <quantidade>
    Então a consulta deve retornar à primeira página usando essa quantidade e os filtros ativos
    E o total de páginas e o intervalo exibido devem refletir a resposta

    Exemplos:
      | exemplo | quantidade |
      | menor quantidade | 10 |
      | maior quantidade | 50 |


  @USID_005 @componente @front @criterio_front
  Esquema do Cenário: 18 Impedir envio normal de filtro inválido - <exemplo>
    Dado que o formulário recebe <entrada> inválida segundo o contrato da operação
    Quando tento aplicar os filtros
    Então devo visualizar uma orientação associada ao campo
    E a consulta inválida não deve ser enviada pelo caminho normal da interface
    E devo poder corrigir o valor sem perder o contexto autorizado

    Exemplos:
      | exemplo | entrada |
      | intervalo invertido | data inicial posterior à final |
      | formato inválido | valor que não representa uma data válida |


  @USID_002 @USID_005 @pagina @front @criterio_front
  Cenário: 19 Manter o resultado da última consulta solicitada
    Dado que solicitei uma busca e depois alterei o termo ou os filtros
    Quando a resposta da consulta mais antiga chega após a resposta mais recente
    Então devo continuar vendo os critérios e resultados da última consulta solicitada
    E totais e paginação antigos não devem sobrescrever o estado atual


```

No cenário 17, 10 e 50 são valores controlados da fixture, não opções aprovadas por este plano. Usar as opções efetivamente suportadas pelo componente e pelo contrato ao implementar. O cenário 18 se aplica à validação local dos parâmetros documentados; a proteção real da API está no cenário 41.

## 4 Marcação do estado

```gherkin
# language: pt
Funcionalidade: 4 Marcação do estado

  @USID_003 @pagina @front @ADR_082
  Esquema do Cenário: 20 Confirmar transição manual permitida - <exemplo>
    Dado que o contexto de teste não possui recurso de IA e autoriza a mudança manual
    E a Ocorrência está em <origem>
    Quando seleciono <destino> e confirmo a alteração
    Então devo enviar a mudança do registro selecionado ao Core
    E após confirmação de sucesso devo visualizar <destino> e uma indicação de conclusão
    E a interface não deve mudar a recorrência como consequência da marcação

    Exemplos:
      | exemplo | origem | destino |
      | iniciar análise | ABERTA | EM_ANALISE |
      | fechar aberta | ABERTA | FECHADA |
      | concluir análise | EM_ANALISE | FECHADA |
      | reabrir | FECHADA | ABERTA |


  @USID_003 @pagina @front
  Cenário: 21 Cancelar mudança sem alterar a Ocorrência
    Dado que abri a seleção de estado para uma Ocorrência
    Quando desisto da alteração antes de confirmar
    Então o estado original deve permanecer na interface
    E nenhuma requisição de mudança deve ser enviada
    E devo continuar podendo consultar a Ocorrência


  @USID_003 @pagina @front @contrato @ADR_089
  Cenário: 22 Tratar recusa de fechamento com Sugestão não finalizada
    Dado que a Ocorrência está EM_ANALISE com uma Sugestão válida não FECHADA
    Quando o Core recusa a tentativa de fechamento por essa regra
    Então devo visualizar que a alteração não foi concluída
    E o estado EM_ANALISE deve permanecer sem confirmação falsa de fechamento
    E devo poder continuar consultando a Ocorrência e suas Sugestões


  @USID_001 @USID_002 @pagina @front @ADR_089 @ADR_090
  Esquema do Cenário: 23 Refletir o estado recebido no fluxo de Sugestão - <exemplo>
    Dado que consultei uma Ocorrência ABERTA no fluxo <fluxo>
    Quando o Core devolve <situacao> e o estado <estado>
    Então devo visualizar <estado> sem antecipar transição por conta própria
    E uma Sugestão manual em FALHA não deve ser exibida como item de Sugestão nem bloquear fechamento

    Exemplos:
      | exemplo | fluxo | situacao | estado |
      | solicitação | manual | Sugestão somente solicitada ou enfileirada | ABERTA |
      | disponível | manual ou automático | Sugestão concluída e visível como DISPONIVEL | EM_ANALISE |
      | falha manual | manual | Sugestão com falha | ABERTA |


  @USID_003 @pagina @front @contrato
  Esquema do Cenário: 24 Não confirmar gravação após falha ou timeout - <exemplo>
    Dado que confirmei uma mudança de estado
    Quando ocorre <falha> sem confirmação de gravação
    Então não devo visualizar sucesso nem assumir o novo estado como confirmado
    E devo receber orientação para recuperar a consulta ou tentar novamente
    E uma nova leitura deve reconciliar o estado com o Core antes de tratá-lo como definitivo

    Exemplos:
      | exemplo | falha |
      | rede | falha de conexão |
      | timeout | tempo de espera excedido |


```

Uma falha de comunicação não prova que a gravação não ocorreu: reconciliar por nova leitura no cenário 24. O cenário 23 testa o estado devolvido e o filtro da lista de Sugestões manuais; não testa a execução do algoritmo de IA. Não ampliar para o fluxo automático a regra de exclusão de FALHA que a ADR_090 qualificou como inferida.

## 5 Arquivamento

```gherkin
# language: pt
Funcionalidade: 5 Arquivamento

  @USID_004 @pagina @front
  Esquema do Cenário: 25 Confirmar arquivamento individual - <exemplo>
    Dado que uma Ocorrência autorizada está acessível em <origem>
    Quando aciono Arquivar
    Então devo visualizar uma confirmação que identifica a Ocorrência antes de enviar a mudança
    Quando confirmo e o Core confirma o arquivamento
    Então a Ocorrência não deve permanecer na lista ativa
    E devo perceber a conclusão sem excluir definitivamente o registro nem criar um estado de ciclo de vida ARQUIVADA

    Exemplos:
      | exemplo | origem |
      | pela lista | listagem |
      | pelo detalhe | detalhe |


  @USID_004 @pagina @front
  Esquema do Cenário: 26 Cancelar arquivamento individual ou em lote - <exemplo>
    Dado que a confirmação de arquivamento está aberta para <alvo>
    Quando aciono Cancelar
    Então a confirmação deve fechar sem enviar a alteração
    E os registros devem permanecer inalterados na lista ativa

    Exemplos:
      | exemplo | alvo |
      | individual | Ocorrência Exemplo 01 |
      | lote | Ocorrências Exemplo 01 e 02 selecionadas |


  @USID_004 @pagina @front
  Cenário: 27 Arquivar somente os registros selecionados
    Dado que selecionei Ocorrências Exemplo 01 e 02 e deixei Exemplo 03 sem seleção
    Quando aciono Arquivar Selecionadas
    Então devo visualizar confirmação para os dois registros selecionados
    Quando confirmo e o Core confirma os dois resultados
    Então somente Exemplo 01 e 02 devem sair da lista ativa
    E Exemplo 03 deve permanecer sem alteração
    E o total e a página devem ser reconciliados com uma nova consulta válida


  @USID_004 @pagina @front @contrato @criterio_front
  Esquema do Cenário: 28 Tratar falha de arquivamento sem ocultar sucesso inexistente - <exemplo>
    Dado que confirmei o arquivamento de <alvo>
    Quando o Core recusa a operação ou não confirma sua conclusão
    Então não devo anunciar arquivamento concluído nem remover definitivamente os registros da interface
    E devo poder atualizar a consulta para conhecer o estado efetivo
    E resultados por item só devem ser usados se forem fornecidos pelo contrato real

    Exemplos:
      | exemplo | alvo |
      | individual | um registro |
      | lote | dois registros selecionados |


  @USID_003 @USID_004 @pagina @front @criterio_front
  Esquema do Cenário: 29 Evitar confirmação duplicada de mutação - <exemplo>
    Dado que uma solicitação de <operacao> aguarda resposta
    Quando aciono novamente a confirmação na interface
    Então o Front não deve disparar outra solicitação simultânea idêntica pelo mesmo controle
    E devo perceber o processamento e conseguir recuperar a interface após a resposta

    Exemplos:
      | exemplo | operacao |
      | marcação | mudança de estado |
      | arquivamento | arquivamento |


```

O plano não exige que o backend tenha lote atômico ou resultado parcial. No cenário 28, mostrar e reconciliar somente o que o contrato comprovar. Se o contrato trouxer confirmação por item, não anunciar sucesso total quando houver recusa individual.

## 6 Acesso e tratamento de respostas

```gherkin
# language: pt
Funcionalidade: 6 Acesso e tratamento de respostas

  @USID_001 @USID_002 @pagina @front @contrato @ADR_121 @ADR_122 @ADR_126
  Esquema do Cenário: 30 Voltar à área inicial em negação simples - <exemplo>
    Dado que Ana Exemplo possui sessão válida
    Quando o Core informa negação simples porque <motivo>
    Então devo voltar à tela inicial e continuar logada
    E nenhum dado ou contador do contexto recusado deve permanecer visível
    E não devo aplicar o logout global da ADR_032 por essa negação

    Exemplos:
      | exemplo | motivo |
      | outra Empresa | não é membro da Empresa solicitada |
      | Produto trocado | o Produto da URL pertence a outro tenant |
      | sem acesso | MEMBRO não tem AcessoProduto |


  @USID_001 @USID_002 @pagina @front @contrato @ADR_032
  Cenário: 31 Encerrar acesso local diante de 401 do Core
    Dado que a tela de Ocorrências está aberta
    Quando uma consulta ou mutação recebe HTTP 401 do Core
    Então devo visualizar Você foi deslogado e retornar ao SignIn
    E o conteúdo protegido da tela deve deixar de ficar acessível
    E o tratamento não deve depender de uma mensagem no corpo da resposta


  @USID_001 @USID_002 @USID_003 @USID_004 @USID_005 @pagina @front @contrato @criterio_front
  Esquema do Cenário: 32 Continuar utilizável diante de retorno inesperado - <exemplo>
    Dado que uma operação da tela aguarda resposta do Core
    Quando a fronteira consumida devolve <resposta> fora do contrato
    Então devo visualizar orientação geral sem travar nem mostrar null ou undefined
    E não devo mostrar dados ou confirmar alterações sem comprovação válida
    E devo poder recuperar a consulta ou corrigir a tentativa

    Exemplos:
      | exemplo | resposta |
      | nulo | null |
      | vazio | corpo vazio quando o contrato exige conteúdo |
      | inválido | JSON inválido ou HTML inesperado |
      | erro sem causa | erro sem código ou causa reconhecida |
      | sucesso incompleto | HTTP 200 sem dados obrigatórios de confirmação |


```

## 7 Qualidade da interface

```gherkin
# language: pt
Funcionalidade: 7 Qualidade da interface

  @USID_001 @USID_002 @USID_004 @USID_005 @pagina @front @criterio_front
  Esquema do Cenário: 33 Operar ações essenciais pelo teclado - <exemplo>
    Dado que utilizo a tela somente pelo teclado
    Quando percorro os controles e realizo <acao>
    Então devo conseguir executar a ação sem mouse com foco visível e ordem compreensível
    E uma confirmação modal deve manter foco útil e devolvê-lo ao controle de origem ao cancelar
    E nenhum foco deve permanecer preso em elemento oculto ou removido

    Exemplos:
      | exemplo | acao |
      | consulta | pesquisar e abrir o detalhe |
      | filtros | aplicar filtros e navegar entre páginas |
      | confirmação | abrir e cancelar o arquivamento |


  @USID_002 @USID_004 @USID_005 @componente @front @criterio_front
  Esquema do Cenário: 34 Identificar campos e ações por tecnologia assistiva - <exemplo>
    Dado que verifico <controle> no componente do LhamaLog
    Quando consulto os nomes acessíveis e a associação de estado ou erro
    Então devo entender <informacao> sem depender somente de cor ícone ou placeholder
    E a verificação deve ser confirmada na página real com tecnologia assistiva

    Exemplos:
      | exemplo | controle | informacao |
      | pesquisa | campo de busca | sua finalidade |
      | data inválida | campo de data com erro | a causa e o campo a corrigir |
      | seleção | checkbox de uma Ocorrência | qual registro está selecionado |


  @USID_001 @USID_002 @USID_004 @pagina @front @criterio_front
  Esquema do Cenário: 35 Manter a tela operável com largura reduzida e zoom - <exemplo>
    Dado que abro <tela> nas condições <condicoes>
    Quando consulto os dados ou navego pelos controles
    Então textos campos botões e foco devem permanecer legíveis e alcançáveis
    E detalhes técnicos extensos podem rolar em sua própria área sem encobrir as ações
    E nenhuma ação necessária deve ficar cortada ou coberta

    Exemplos:
      | exemplo | tela | condicoes |
      | lista estreita | listagem | viewport 360 por 800 e zoom 100 por cento |
      | detalhe ampliado | detalhe | viewport 1280 por 800 e zoom 200 por cento |
      | confirmação ampliada | modal de arquivamento | viewport 1280 por 800 e zoom 200 por cento |


```

## 8 Integração real do Front

```gherkin
# language: pt
Funcionalidade: 8 Integração real do Front

  @USID_001 @USID_002 @USID_005 @integracao @ADR_101 @ADR_141
  Esquema do Cenário: 36 Consultar o Core com contexto e filtros reais - <exemplo>
    Dado que o ambiente real de teste contém Ocorrências fictícias no Produto Alfa autorizado
    Quando consulto <recorte> pela interface Web
    Então as chamadas de negócio devem ir ao Core com a sessão e o contexto corretos
    E a lista e o detalhe devem corresponder aos registros reais de teste e aos filtros aplicados
    E nenhum serviço interno nem banco deve ser acessado diretamente pelo navegador

    Exemplos:
      | exemplo | recorte |
      | Produto | Ocorrências do Produto |
      | lote | Ocorrências de um lote quando a navegação oferece esse recorte |
      | arquivo | Ocorrências de um arquivo quando a navegação oferece esse recorte |


  @USID_003 @integracao @ADR_082 @ADR_089
  Cenário: 37 Persistir e reler uma mudança de estado válida
    Dado que o ambiente autoriza a mudança manual e a Ocorrência ABERTA não tem Sugestões que impeçam fechamento
    Quando altero para FECHADA pela interface e o Core confirma
    E recarrego o detalhe por uma nova consulta
    Então devo visualizar FECHADA persistida no mesmo registro
    E a evidência deve comprovar a gravação real sem usar a resposta simulada do teste de página


  @USID_004 @integracao
  Cenário: 38 Arquivar e reler a lista ativa real
    Dado que a operação real de arquivamento está disponibilizada pelo contrato do Core no ambiente de teste
    E existem registros fictícios autorizados que podem ser arquivados
    Quando confirmo o arquivamento pela tela e consulto novamente a lista ativa
    Então os registros confirmados como arquivados não devem integrar essa lista
    E registros não selecionados devem permanecer conforme a consulta
    E o teste não deve deduzir a representação interna do arquivamento


```

## Anexo Verificações complementares de backend

Estas verificações usam o Core real e dados de teste. Respostas simuladas do Front não substituem essa evidência. A API deve seguir seu contrato publicado; nenhum endpoint ou código novo é definido aqui.

```gherkin
# language: pt
Funcionalidade: Anexo Verificações complementares de backend

  @USID_001 @USID_002 @USID_003 @USID_004 @api @core @ADR_121 @ADR_122 @ADR_126
  Esquema do Cenário: 39 Recusar consulta ou mutação fora do contexto autorizado - <exemplo>
    Dado que uso uma sessão real de teste sem autorização para o alvo
    Quando envio diretamente uma operação de <operacao> com identificador de outra Empresa ou Produto sem acesso
    Então o Core deve recusar sem devolver dados nem modificar registros
    E a recusa deve seguir o contrato de negação simples sem revogar a sessão por esse motivo

    Exemplos:
      | exemplo | operacao |
      | consulta | consulta de lista ou detalhe |
      | marcação | mudança de estado |
      | arquivo | arquivamento |


  @USID_003 @api @core @ADR_082 @ADR_089 @ADR_090
  Esquema do Cenário: 40 Validar restrições de transição sem depender do formulário - <exemplo>
    Dado que a fixture real prepara <situacao>
    Quando envio diretamente a mudança <transicao> ao Core
    Então devo observar <resultado> ao consultar novamente o registro
    E o formulário não deve ser a única proteção da regra

    Exemplos:
      | exemplo | situacao | transicao | resultado |
      | transição não permitida | Ocorrência FECHADA | FECHADA para EM_ANALISE | recusa sem alterar o estado |
      | Sugestão aberta | Ocorrência EM_ANALISE com Sugestão válida não FECHADA | EM_ANALISE para FECHADA | recusa sem alterar o estado |
      | falha manual excluída | Ocorrência ABERTA com somente Sugestão manual em FALHA | ABERTA para FECHADA | fechamento permitido sem tratar a falha como dependência |


  @USID_005 @api @core @criterio_front
  Esquema do Cenário: 41 Validar parâmetros de consulta diretamente na API - <exemplo>
    Dado que identifiquei a operação real de consulta e seus parâmetros documentados
    Quando envio diretamente <entrada> fora desse contrato sem passar pelo formulário
    Então o Core deve recusar conforme o contrato sem produzir consulta irrestrita ou dados de outro contexto
    E o resultado deve ser verificado na resposta real do serviço

    Exemplos:
      | exemplo | entrada |
      | período | intervalo inicial posterior ao final |
      | paginação | tipo inválido no parâmetro de paginação exigido |
      | tipo | valor de filtro fora do conjunto aceito pela operação |


```

## Acompanhamento de implementação

Marque somente após obter a evidência. Cada cenário tem suas próprias caixas. O registro detalha cada linha de Exemplos separadamente; marcar o grupo pressupõe conferir as variações aplicáveis. Em verificação de serviço externo, justificar etapas TDD não aplicáveis sem marcá-las como executadas.

### Cenário 01 — Mostrar carregamento sem antecipar resultado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 02 — Apresentar os registros e atributos retornados

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 03 — Mostrar lista vazia do Produto autorizado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 04 — Recuperar a listagem após falha

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 05 — Ignorar resposta atrasada de outro Produto

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 06 — Buscar Ocorrência por parâmetro suportado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 07 — Informar consulta sem correspondência

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 08 — Abrir o detalhe do registro selecionado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 09 — Consultar as abas de dados técnicos

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 10 — Voltar ao estado anterior da consulta

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 11 — Tratar detalhe indisponível sem mostrar outro registro

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 12 — Aplicar um filtro suportado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 13 — Combinar filtros na mesma consulta

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 14 — Mostrar ausência de resultados filtrados

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 15 — Limpar filtros e retornar à primeira página

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 16 — Navegar mantendo os filtros ativos

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 17 — Alterar a quantidade por página sem perder filtros

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 18 — Impedir envio normal de filtro inválido

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 19 — Manter o resultado da última consulta solicitada

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 20 — Confirmar transição manual permitida

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 21 — Cancelar mudança sem alterar a Ocorrência

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 22 — Tratar recusa de fechamento com Sugestão não finalizada

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 23 — Refletir o estado recebido no fluxo de Sugestão

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 24 — Não confirmar gravação após falha ou timeout

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 25 — Confirmar arquivamento individual

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 26 — Cancelar arquivamento individual ou em lote

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 27 — Arquivar somente os registros selecionados

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 28 — Tratar falha de arquivamento sem ocultar sucesso inexistente

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 29 — Evitar confirmação duplicada de mutação

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 30 — Voltar à área inicial em negação simples

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 31 — Encerrar acesso local diante de 401 do Core

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 32 — Continuar utilizável diante de retorno inesperado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 33 — Operar ações essenciais pelo teclado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 34 — Identificar campos e ações por tecnologia assistiva

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 35 — Manter a tela operável com largura reduzida e zoom

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 36 — Consultar o Core com contexto e filtros reais

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 37 — Persistir e reler uma mudança de estado válida

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 38 — Arquivar e reler a lista ativa real

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 39 — Recusar consulta ou mutação fora do contexto autorizado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 40 — Validar restrições de transição sem depender do formulário

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 41 — Validar parâmetros de consulta diretamente na API

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Registro de execução e evidências

Copie este registro para cada cenário, exemplo, camada e execução. Os resultados são Não executado, Passou, Falhou ou Não aplicável com justificativa. Evidência simulada e real não se substituem.

- Cenário e exemplo: PREENCHER
- USID e fonte: PREENCHER
- Camada e responsabilidade: PREENCHER componente, página, contrato, API ou integração
- Cliente ou Empresa e Produto: PREENCHER contexto fictício
- Ambiente e perfil: PREENCHER
- Operação contrato e resposta simulada ou real: PREENCHER
- Navegador viewport zoom e tecnologia assistiva: PREENCHER ou Não aplicável com justificativa
- Etapa: PREENCHER Red, Green, Refactor ou verificação de contrato
- Teste automatizado: PREENCHER link ou caminho, ou Não existe
- Resultado: PREENCHER após executar
- Evidência: PREENCHER referência sem segredos ou Não existe
- OBS: PREENCHER observação ou Sem observações

### Critérios de aceite do planejamento

- [ ] Conferi a cobertura dos cinco USIDs e os limites descritos no plano
- [ ] Conferi preparação fictícia, ação e resultado observável dos cenários
- [ ] Conferi as regras de estado, recorrência, arquivamento e autorização com as fontes
- [ ] Registrei a revisão da correspondência com as telas da LLT-46 exigida na atividade

- Registro da revisão: PREENCHER data, responsável e referência
- OBS da revisão: PREENCHER observação ou Sem observações

As caixas de revisão permanecem desmarcadas até existir registro da conferência. Este plano não comprova aprovação formal nem conclusão da atividade no Jira.

## Referências

- [LLT-84 Planejar testes de Ocorrências](https://logviewer2026.atlassian.net/browse/LLT-84)
- [LLT-83 Modelo e matriz](https://docs.google.com/document/d/1ViQWy2JQV8QrvdRj3Iz3gRgJnkq9XBBOQD2tkvrthRY/edit)
- [LLT-86 Padrão do plano de login Web](https://docs.google.com/document/d/1W4dsdN3F6DSZo3ZSR_9TGUqEb7kDmHgO65C_Gd-EV6k/edit)
- [USID_001–005 Casos de uso](https://docs.google.com/spreadsheets/d/1JObvNfZAJvCPjG4urP4OZKHVhKFNyCeVq1w2w8agRb0/edit)
- [LLT-46 Referências de telas Web](https://logviewer2026.atlassian.net/browse/LLT-46)
- [Figma Completo Ocorrencia Reformulado com padrão](https://www.figma.com/design/e88SaMez3hQZ0nmmC3uEtm/LhamaLog?node-id=422-9958)
- [Figma Detalhe Visão Geral](https://www.figma.com/design/e88SaMez3hQZ0nmmC3uEtm/LhamaLog?node-id=422-6592)
- [Pasta oficial dos ADRs](https://drive.google.com/drive/folders/1SsRGM7_f7WD8L0O4GnozbosImt8zReTs)

### ADRs aplicáveis

- [ADR_019](https://docs.google.com/document/d/1khyVL7Xgj8xJcnP9YYu2p-4UyVNAqEatPV4ph87PXSg/edit) — Enum Tipo da classificação: ERRO, WARNING e SPAM
- [ADR_032](https://docs.google.com/document/d/1m_5y0BqS_KPWIwkMs9-AThB1wTRNr1-F1u7BnWt7jNg/edit) — Tratamento de erros 401/403 e renovação da sessão
- [ADR_035](https://docs.google.com/document/d/1VHD4bazA8HDPH5feZ4NK8KUQYIBXa77eMYjtm2Ea0V8/edit) — Ocorrência concreta e vínculo de 1 Ocorrência para N Sugestões
- [ADR_062](https://docs.google.com/document/d/16XOz3bMdXwRTDHIkY0zuGx6faDSi8COtD84e-zecpR8/edit) — Finder emite só AchadoAnalise e ResumoAnalise; Ocorrências e gravidade pertencem ao Módulo Ocorrência
- [ADR_063](https://docs.google.com/document/d/1zHBgNKh_Mt5mALSsz4zK87_XUghdKgRqGaV3vo2K7NU/edit) — Recorrência no Finder: flag recorrente no AchadoAnalise e janela dos últimos 500 arquivos no BancoVetorial
- [ADR_074](https://docs.google.com/document/d/1sjdF_QaxJV68JrDz5IWPxev-8nt2kNYYiXWeOED7IGo/edit) — BancoVetorial isolado por Produto
- [ADR_082](https://docs.google.com/document/d/1KjmX9KxpmYw5nDChPHfs1DSwW0rvvq98rdsXty2jhXM/edit) — Status da Ocorrência e endpoint de mudança manual
- [ADR_089](https://docs.google.com/document/d/1ia8AqK6_qEfzTFrXseJ-STIt4cId4O2UsGme16XM7jY/edit) — Fechamento da Sugestão e status da Ocorrência (complementa a ADR_082)
- [ADR_090](https://docs.google.com/document/d/1FyBLSgQGyhO5lG4TfPz5PmwHlRezerzeUSnHQHNoipU/edit) — Sugestão com falha fica fora da lista da Ocorrência e não bloqueia o fechamento
- [ADR_101](https://docs.google.com/document/d/1ipZkz9zwoaOgcJOC4otTt_JsB_Vh6OeB_zBfYFBZOp8/edit) — Ocorrências em três níveis (Produto, lote, arquivo)
- [ADR_121](https://docs.google.com/document/d/1D-M3nCYKSf2tgtKqEW6MrCZIqKT-fj7PPBf23nkpyzM/edit) — Modelo multi-tenant SaaS pool com tenant = empresa cliente (substitui a ADR_105)
- [ADR_122](https://docs.google.com/document/d/1eVI3Yt_6dfXpv1c8ntY2MDRQc_kF2S4dr8TktO6cR2E/edit) — Coleções do modelo multi-tenant
- [ADR_126](https://docs.google.com/document/d/1QRk3uGaZZTc_tM64PkaFodcEAQ7ruIr_9Oz4Htq8srk/edit) — Negação simples para não-membro ou Produto errado na URL
- [ADR_141](https://docs.google.com/document/d/1tsFBbpdq8JqGasM8EcNN6oIXaAAVOXlxa3nJkanQIks/edit) — Segmentação de rede dos módulos
