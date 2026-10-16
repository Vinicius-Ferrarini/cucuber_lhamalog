# Plano de testes de dashboards e relatórios do Front Web

**Atividade:** [LLT-85](https://logviewer2026.atlassian.net/browse/LLT-85) · **Versão:** 1 · **Data:** 16/10/2026

Plano BDD com exemplos orientados por dados para dashboards por Produto e empresarial, filtros, consulta de Ocorrências de múltiplos Produtos e exportação de relatórios. Segue o modelo da LLT-83 e a organização dos planos LLT-84 e LLT-86.

São **42 cenários**, com 28 esquemas parametrizados e 14 cenários simples, totalizando **87 linhas de execução especificadas**. Os cenários 01 a 39 cobrem o Front e sua integração; 40 a 42 estão no anexo de backend. Nos cenários de exportação, repetir as linhas aplicáveis para cada formato efetivamente disponibilizado pela operação. O total final de execuções depende dessa lista do ambiente.

Todos os testes começam **não executados**, sem automação criada e com TDD desmarcado. Este documento planeja o comportamento antes do código; não implementa a aplicação, executa testes ou comprova aprovação formal da atividade.

## Como usar

As seções agrupam testes por assunto; não são etapas de um único fluxo. Cada cenário tem preparação própria. A numeração segue a ordem de leitura sem saltos, incluindo o anexo.

1. Leia as regras e prepare as fixtures de Empresa, Produtos, permissões e dados fictícios.
2. Escolha o cenário completo com USID, camada, pré-condições e exemplos.
3. Execute cada linha de Exemplos separadamente e repita as variações de exportação para os formatos suportados pelo contrato do ambiente.
4. No código do LhamaLog, escreva o teste e comprove Red por comportamento ausente; falha de configuração não comprova Red.
5. Implemente o necessário para Green e confira os testes relevantes.
6. Avalie Refactor e confirme os testes novamente; registre a alteração ou Nenhuma alteração necessária.
7. Registre contexto, formato, filtros, resposta simulada ou real, resultado e evidência de cada execução.

Amarelo **#ffff00** e **PREENCHER** indicam campos a tratar. Substitua a orientação pela resposta e retire o amarelo após conferir. Em OBS, registre a observação ou Sem observações. Checkboxes só recebem marcação após a ação comprovada. Retirar o amarelo não significa teste aprovado.

BDD descreve comportamento e Data-Driven Testing organiza variações. Cucumber exige passos implementados para executar o Gherkin; a especificação escrita não é automação criada. O Markdown de trabalho mantém os blocos delimitados. Conferir a exportação nativa do Docs antes de utilizá-la diretamente com Cucumber, pois ela pode acrescentar escapes e alterar a apresentação dos blocos.

## Regras vigentes e preparação comum

### Fontes e limites da especificação

- USID_031–037 definem as ações de dashboard por Produto, filtros, relatórios, visão empresarial e Ocorrências de múltiplos Produtos. Os ADRs vigentes prevalecem nas regras de backend.
- O Front mostra as métricas, unidades e resultados devolvidos pelo Core para o recorte autorizado. Valores da fixture comprovam renderização; não aprovam fórmula, agregação, arredondamento, fuso, periodicidade de atualização ou limite de volume. Não somar percentuais ou calcular taxas no navegador por dedução.
- PDF e CSV são exemplos na planilha. A exportação deve usar os formatos disponibilizados no contrato ou configuração validada do ambiente, sem tornar esses exemplos uma lista final. O plano não escolhe colunas, ordem, separador, layout de impressão, nome de arquivo ou codificação sem fonte da operação.
- A comparação entre tela e arquivo verifica identidade do recorte e significado dos dados conforme o contrato. O relatório pode ter nível de detalhe diferente dos indicadores; não exigir igualdade visual, mesma quantidade de linhas ou soma de valores sem definição correspondente.
- O recorte da exportação é o aplicado com sucesso no momento da confirmação. Campo editado sem aplicar não altera esse recorte. Depois de uma troca de Produto ou filtros, não entregar uma resposta de outra solicitação como se fosse a atual. Uma exportação já iniciada mantém a identificação do recorte da sua solicitação.
- USID_033 prevê cancelamento em andamento no relatório por Produto. Para o empresarial, USID_035 tem um fluxo alternativo que menciona cancelamento na ação e recusa de permissão no resultado. O cenário 27 trata a capacidade efetivamente documentada da operação; cancelamento empresarial não é presumido como regra aprovada por essa linha. Recusa de acesso é tratada separadamente no cenário 14.
- Cancelamento de geração precisa de confirmação do serviço; cancelar antes de iniciar não envia geração. Não prometer interromper bytes já transferidos, desfazer um download concluído ou parar o backend apenas porque o usuário fechou a janela. Falha de comunicação não prova que uma tarefa não foi criada: reconciliar pelo mecanismo real do contrato antes de repetir.
- ADR_121 e ADR_122: tenant é a Empresa cliente. DONO e ADMIN veem os Produtos da própria Empresa; MEMBRO usa AcessoProduto. A permissão empresarial e a permissão de exportar vêm do contrato, sem criar um novo papel nem conceder acesso automaticamente por ter o papel MEMBRO.
- ADR_126: negação simples de Empresa ou Produto retorna à área inicial mantendo a sessão. O 401 e o 403 sujeitos à revogação seguem ADR_032 e retornam ao SignIn com Você foi deslogado. O status isolado não substitui o contrato da operação.
- ADR_141: o navegador usa o Core para consultas e relatórios de negócio; não acessa bancos ou serviços internos diretamente. Uma referência de arquivo entregue pelo Core segue o mecanismo de download contratado, sem inventar provedor de armazenamento.
- ADR_131 diferencia Dashboard Básico, Padrão e Personalizado por plano; o plano de testes não define quais cards pertencem a cada categoria. A preparação usa as capacidades que a Assinatura e a operação efetivamente disponibilizam. Limites são lidos da Assinatura conforme ADR_124; não inventar funcionalidades pagas ou totais máximos.
- O Figma consultado é Completo, v02, versões com padrão. O quadro 01-Produtos-Lista-Filtros 1 apresenta seleção/contexto de Produtos e indicadores laterais; o grupo Empresa consultado é de configuração. Essas referências não comprovam uma tela final de relatório ou todas as telas empresariais. Os casos descrevem comportamento funcional; a correspondência visual tem registro próprio de revisão.
- Os cenários com `@criterio_front` são critérios de qualidade definidos neste plano. Não são decisões de backend atribuídas aos ADRs. Viewports e zoom são amostras de teste, sem fixar novos breakpoints do produto.

### Camadas e responsabilidade

| Tag | Comprova | Evidência |
| --- | --- | --- |
| @componente @front | Estado e apresentação do componente ou adaptador do LhamaLog | Renderização isolada com dependências controladas |
| @pagina @front | Tela, filtros, navegação e tratamento visual | Página com respostas controladas do Core |
| @front @contrato | Interpretação de erro e retorno inesperado | Simulação na fronteira realmente consumida |
| @integracao | Consulta, geração e download reais | Front e Core de teste, com análise do conteúdo do arquivo |
| @api @core | Validação e isolamento reais do serviço | Requisição direta sem depender do formulário |

Evidência simulada não comprova regra do backend, geração ou cancelamento real. Nas integrações, registrar operação, versão, capacidades e formato utilizados. Verificações de backend são complementares e não transferem sua implementação para a LLT-85.

### Fixtures e pré-condições

| Fixture | Preparação fictícia |
| --- | --- |
| Ana Exemplo | ana.dashboard@example.com, sessão Clerk ativa com MFA concluído, Empresa Exemplo A; variantes DONO, ADMIN e MEMBRO com acesso específico |
| Contexto permitido | Produto Alfa e Produto Gama da Empresa Exemplo A; autorização empresarial e de exportação informadas pelo contrato |
| Contexto recusado | Produto Beta da Empresa Exemplo B; Bruno Exemplo sem acesso ao relatório de Ana; variante MEMBRO sem AcessoProduto |
| Indicadores | Respostas controladas com nomes e unidades do contrato, quantidade 12, quantidade zero e indisponibilidade admitida; não são fórmulas do produto |
| Filtros | Período fictício de 01/10/2026 a 16/10/2026, tipos de alerta suportados e seleção de Produtos; respostas com dados, vazias e atrasadas |
| Relatórios | Contrato com formatos efetivamente disponíveis, referência dos dados do recorte, arquivo válido e variantes inválidas de resposta; tarefa em andamento para testar cancelamento |
| Assinatura | Plano de teste com capacidades habilitadas e limites obtidos da Assinatura; sem inventar permissões de exportação por nome de plano |
| Dados | Registros de teste com identificadores fictícios de Produto; nenhum log identificável, token, credencial, sessão utilizável ou dado pessoal real no arquivo |

Usar ambiente isolado. Cada cenário restaura sua fixture e não depende de outro teste. Não compartilhar arquivos com dados reais. Para verificar um formato, inspecionar seu conteúdo usando ferramenta apropriada ao tipo; uma extensão de nome ou resposta HTTP bem-sucedida não comprova um relatório válido.

## Matriz de cobertura

| Origem | Cenários | Comportamento observado |
| --- | --- | --- |
| USID_031 Dashboard por Produto | 01–06, 32–37 | Seleção autorizada, indicadores, vazio, carregamento e falha |
| USID_032 Filtros do dashboard | 07–11, 34–35, 37; API 41 | Aplicação, validação, alteração, limpeza e coerência dos dados |
| USID_033 Relatório por Produto | 22–26, 28–31, 34–36, 38–39; API 40–42 | Formato disponível, filtros, geração, download e cancelamento |
| USID_034 Dashboard empresarial | 12–15, 32–33, 36–37; API 40 | Consolidação autorizada, detalhe e recusa de acesso |
| USID_035 Relatório empresarial | 14, 22–25, 27–31, 38–39; API 40–42 | Arquivo autorizado, recorte, falhas e capacidade de cancelamento conforme contrato |
| USID_036 Filtros empresariais | 07–11, 16–17, 33–34, 37; API 41 | Seleção de Produtos, critérios persistidos na navegação, alteração e remoção |
| USID_037 Ocorrências empresariais | 18–21, 34; API 40 | Consulta de múltiplos Produtos, vazio e mudança dos critérios |

Este recorte não valida fórmulas não especificadas, não implementa novas telas do Figma e não executa checkout, cálculo de preços ou gestão de assinatura. O plano LLT-84 detalha a consulta interna da Ocorrência individual; a LLT-85 cobre o conjunto empresarial e a preservação do contexto.

## 1 Dashboard por Produto

```gherkin
# language: pt
Funcionalidade: 1 Dashboard por Produto

  @USID_031 @pagina @front @criterio_front
  Cenário: 01 Aguardar carregamento sem antecipar indicadores
    Dado que abri o dashboard do Produto Alfa autorizado
    Quando a consulta ao Core está em andamento
    Então devo perceber que os indicadores estão carregando
    E a interface não deve apresentar ausência de dados ou zero como resultado confirmado
    E métricas do Produto anterior não devem ser identificadas como métricas do Alfa


  @USID_031 @pagina @front @ADR_121 @ADR_122
  Esquema do Cenário: 02 Selecionar somente um Produto autorizado - <exemplo>
    Dado que a conta de teste possui papel <papel> na Empresa Exemplo A
    E o Core retorna os Produtos permitidos para essa conta
    Quando seleciono o Produto Alfa na interface
    Então a consulta e os indicadores devem usar a Empresa Exemplo A e o Produto Alfa
    E o seletor não deve oferecer como permitido o Produto Beta de outra Empresa

    Exemplos:
      | exemplo | papel |
      | proprietário | DONO |
      | administrador | ADMIN |
      | membro com acesso | MEMBRO com AcessoProduto para Alfa |


  @USID_031 @componente @front @criterio_front
  Esquema do Cenário: 03 Representar valores recebidos sem inventar métricas - <exemplo>
    Dado que o contrato identifica um indicador e sua unidade
    Quando a resposta controlada contém <valor>
    Então devo visualizar <resultado> associado ao indicador correto
    E o componente não deve recalcular fórmula nem confundir dado ausente com zero
    E o nome e a unidade devem permanecer coerentes com o contrato

    Exemplos:
      | exemplo | valor | resultado |
      | positivo | quantidade válida 12 | a quantidade 12 |
      | zero real | quantidade válida 0 | zero como valor válido |
      | não disponível | ausência permitida pelo contrato | indicação de indisponibilidade sem fabricar zero |


  @USID_031 @pagina @front @criterio_front
  Cenário: 04 Apresentar ausência de dados coletados
    Dado que o Produto Alfa está autorizado mas não possui dados no recorte consultado
    Quando o Core retorna sucesso indicando ausência de dados
    Então devo visualizar que não há dados para esse recorte
    E o Produto e o período devem permanecer identificáveis
    E a interface não deve mostrar dados de demonstração nem erro de rede para essa condição


  @USID_031 @pagina @front @criterio_front
  Cenário: 05 Ignorar métricas atrasadas de outro Produto
    Dado que solicitei o dashboard do Alfa e depois selecionei o Produto Gama autorizado
    Quando a resposta do Alfa chega após a resposta do Gama
    Então devo continuar vendo apenas o contexto e os indicadores do Gama
    E títulos gráficos totais e opções de exportação não devem ser repostos para Alfa


  @USID_031 @pagina @front @contrato @criterio_front
  Esquema do Cenário: 06 Recuperar o dashboard após falha de carregamento - <exemplo>
    Dado que uma consulta de indicadores está em andamento
    Quando ocorre <falha>
    Então devo visualizar uma orientação de falha e poder tentar novamente
    E o carregamento não deve continuar indefinido
    E a falha não deve ser apresentada como ausência de dados

    Exemplos:
      | exemplo | falha |
      | conexão | interrupção de rede |
      | serviço | erro do Core sem dados úteis |


```

## 2 Filtros de dashboards

```gherkin
# language: pt
Funcionalidade: 2 Filtros de dashboards

  @USID_032 @USID_036 @pagina @front
  Esquema do Cenário: 07 Aplicar critérios suportados pelo contrato - <exemplo>
    Dado que estou no dashboard <escopo> com dados fictícios e autorização
    Quando aplico <criterios>
    Então a consulta deve transmitir os critérios juntos ao Core
    E indicadores e gráficos devem refletir a resposta desse mesmo recorte
    E os critérios aplicados devem permanecer visíveis

    Exemplos:
      | exemplo | escopo | criterios |
      | período do Produto | do Produto Alfa | período fictício suportado |
      | tipo no Produto | do Produto Alfa | tipo de alerta aceito pela operação |
      | combinação empresarial | empresarial | período e Produtos Alfa e Gama autorizados |


  @USID_032 @USID_036 @componente @front
  Esquema do Cenário: 08 Impedir aplicação normal de filtro inválido - <exemplo>
    Dado que o filtro recebe <entrada> inválida conforme o contrato
    Quando tento aplicá-lo
    Então devo visualizar orientação associada ao campo
    E o Front não deve enviar a consulta inválida pelo fluxo normal
    E os últimos critérios aplicados com sucesso não devem ser substituídos por valores inválidos

    Exemplos:
      | exemplo | entrada |
      | datas invertidas | data inicial posterior à final |
      | data inválida | texto que não representa data válida |


  @USID_032 @USID_036 @pagina @front
  Esquema do Cenário: 09 Alterar ou remover filtros e atualizar os dados - <exemplo>
    Dado que o dashboard possui filtros aplicados
    Quando realizo <alteracao>
    Então a consulta deve refletir os critérios restantes e o contexto autorizado
    E a tela deve substituir os indicadores pelos da nova resposta
    E o comando de exportar deve usar o recorte aplicado com sucesso

    Exemplos:
      | exemplo | alteracao |
      | alterar | troca de período |
      | remover um | remoção de um filtro |
      | limpar | limpeza dos filtros opcionais |


  @USID_032 @USID_036 @pagina @front
  Cenário: 10 Distinguir resultado filtrado vazio de erro
    Dado que apliquei uma combinação válida de filtros
    Quando o Core informa ausência de resultados para essa combinação
    Então devo visualizar uma indicação de ausência de dados filtrados
    E devo poder alterar ou remover os filtros
    E nenhuma métrica anterior deve aparecer como resultado do novo recorte


  @USID_032 @USID_036 @pagina @front @criterio_front
  Cenário: 11 Manter somente a última consulta aplicada
    Dado que solicitei dois recortes de filtros em sequência
    Quando a resposta do primeiro chega depois da resposta do segundo
    Então os filtros indicadores e gráficos devem continuar correspondendo ao segundo recorte
    E a exportação não deve usar critérios de uma resposta atrasada


```

## 3 Dashboard empresarial

```gherkin
# language: pt
Funcionalidade: 3 Dashboard empresarial

  @USID_034 @pagina @front @ADR_121 @ADR_122
  Esquema do Cenário: 12 Mostrar consolidação autorizada da Empresa - <exemplo>
    Dado que a conta possui papel <papel> na Empresa Exemplo A e acesso empresarial confirmado pelo Core
    Quando abro o dashboard empresarial
    Então devo visualizar a consolidação e os detalhamentos por Produto que o Core devolveu para essa Empresa
    E nenhum dado ou contribuição da Empresa Exemplo B deve ser exibido
    E o Front não deve criar uma fórmula de agregação própria

    Exemplos:
      | exemplo | papel |
      | dono | DONO |
      | admin | ADMIN |


  @USID_034 @USID_036 @pagina @front @ADR_122
  Cenário: 13 Restringir a consolidação aos Produtos permitidos
    Dado que Ana Exemplo é MEMBRO e tem AcessoProduto somente ao Alfa
    E o contrato autoriza sua visualização empresarial limitada ao Alfa
    Quando o Core devolve o dashboard desse recorte
    Então devo visualizar somente dados e opções de Produto permitidos na resposta
    E totais gráficos e exportação não devem incluir Gama nem Produto de outra Empresa
    E o teste não deve conceder permissão empresarial apenas por ser MEMBRO


  @USID_034 @USID_035 @pagina @front @contrato @ADR_126
  Esquema do Cenário: 14 Tratar negação simples de acesso empresarial - <exemplo>
    Dado que a sessão é válida mas o Core não autoriza o contexto solicitado
    Quando a operação retorna negação simples por <motivo>
    Então devo voltar à área inicial e continuar logada
    E nenhum indicador detalhe ou arquivo do contexto recusado deve ficar disponível
    E não devo aplicar o logout global da ADR_032 por essa negação

    Exemplos:
      | exemplo | motivo |
      | Empresa | ausência de vínculo com a Empresa |
      | Produto | Produto de outro tenant ou sem AcessoProduto |


  @USID_034 @pagina @front
  Cenário: 15 Abrir detalhamento do Produto selecionado
    Dado que o dashboard empresarial mostra Alfa e Gama autorizados
    Quando seleciono o detalhamento do Gama
    Então devo visualizar os dados do Gama retornados pelo Core
    E o contexto de Empresa deve permanecer Exemplo A
    E voltar à visão consolidada deve manter os filtros aplicados


  @USID_036 @pagina @front @ADR_121 @ADR_122
  Esquema do Cenário: 16 Selecionar vários Produtos sem ampliar a autorização - <exemplo>
    Dado que o contrato disponibiliza seleção de Produtos permitidos na Empresa Exemplo A
    Quando aplico a seleção <selecao> com o período fictício
    Então a consulta deve usar somente os identificadores selecionados e autorizados
    E indicadores e legenda devem corresponder à resposta desse conjunto
    E selecionar todos significa somente os Produtos permitidos desse contexto

    Exemplos:
      | exemplo | selecao |
      | um Produto | Alfa |
      | dois Produtos | Alfa e Gama |
      | todos permitidos | todos os Produtos autorizados da Empresa Exemplo A |


  @USID_036 @pagina @front
  Cenário: 17 Preservar filtros empresariais até alteração ou remoção
    Dado que apliquei período e seleção de Produtos no dashboard empresarial
    Quando consulto seus indicadores e detalhamentos sem alterar os filtros
    Então os critérios devem continuar identificáveis e ativos nessa navegação
    E uma consulta seguinte do mesmo estado deve usar esses critérios
    E o teste não deve exigir persistência entre dispositivos ou após logout


```

## 4 Ocorrências empresariais

```gherkin
# language: pt
Funcionalidade: 4 Ocorrências empresariais

  @USID_037 @pagina @front @ADR_121 @ADR_122
  Esquema do Cenário: 18 Filtrar Ocorrências de múltiplos Produtos - <exemplo>
    Dado que a conta possui acesso ao módulo empresarial e aos Produtos <produtos>
    Quando aplico os filtros de Ocorrências para <produtos>
    Então devo visualizar somente as Ocorrências correspondentes retornadas pelo Core
    E cada registro deve manter a identificação do Produto correto
    E o termo empresarial não deve misturar Empresas diferentes

    Exemplos:
      | exemplo | produtos |
      | único | Alfa |
      | múltiplos | Alfa e Gama |


  @USID_037 @pagina @front
  Cenário: 19 Mostrar consulta de Ocorrências sem correspondência
    Dado que apliquei filtros válidos nas Ocorrências empresariais
    Quando o Core retorna sucesso sem correspondência
    Então devo visualizar que não há Ocorrências para os critérios aplicados
    E os filtros devem permanecer disponíveis para alteração ou remoção
    E a interface não deve reapresentar registros anteriores como resultado atual


  @USID_037 @pagina @front
  Esquema do Cenário: 20 Alterar e remover critérios da consulta empresarial - <exemplo>
    Dado que a consulta de Ocorrências empresariais possui filtros ativos
    Quando realizo <acao>
    Então devo observar uma nova consulta com os critérios atualizados
    E os registros e as identificações de Produto devem corresponder à nova resposta
    E o contexto autorizado de Empresa deve ser mantido

    Exemplos:
      | exemplo | acao |
      | alterar | alteração de um critério |
      | remover | remoção de um filtro |
      | limpar | limpeza dos filtros opcionais |


  @USID_037 @pagina @front @criterio_front
  Cenário: 21 Abrir detalhe preservando Empresa e Produto da Ocorrência
    Dado que a lista empresarial contém uma Ocorrência do Gama autorizada
    E a interface oferece navegação ao detalhe
    Quando abro esse registro
    Então a consulta deve usar o identificador da Ocorrência e o Produto Gama na Empresa Exemplo A
    E não deve reutilizar o Produto anteriormente consultado por engano
    E o comportamento interno do detalhe segue o plano LLT-84


```

## 5 Exportação de relatórios

```gherkin
# language: pt
Funcionalidade: 5 Exportação de relatórios

  @USID_033 @USID_035 @pagina @front
  Esquema do Cenário: 22 Oferecer somente formatos disponibilizados para a operação - <exemplo>
    Dado que abro a exportação do dashboard <escopo>
    E o contrato ou configuração validada do ambiente informa os formatos disponíveis
    Quando visualizo as opções
    Então devo poder selecionar os formatos efetivamente oferecidos por essa operação
    E não devo visualizar um formato inventado apenas porque é exemplo na planilha
    E escolher um formato não deve iniciar geração antes da confirmação

    Exemplos:
      | exemplo | escopo |
      | Produto | do Produto Alfa |
      | Empresa | empresarial |


  @USID_033 @USID_035 @pagina @front
  Esquema do Cenário: 23 Capturar o recorte aplicado ao confirmar a exportação - <exemplo>
    Dado que o dashboard <escopo> tem período tipo e Produtos autorizados aplicados com sucesso
    Quando escolho um formato disponível e confirmo a exportação
    Então a solicitação deve identificar o mesmo recorte aplicado no dashboard
    E alterações ainda não aplicadas no formulário não devem ser enviadas como filtros confirmados
    E a interface deve indicar que a exportação foi iniciada sem anunciar arquivo pronto

    Exemplos:
      | exemplo | escopo |
      | Produto | do Produto Alfa |
      | Empresa | empresarial de Alfa e Gama |


  @USID_033 @USID_035 @pagina @front
  Esquema do Cenário: 24 Disponibilizar o arquivo concluído para download - <exemplo>
    Dado que confirmei uma exportação <escopo> em um formato disponível
    Quando o Core confirma conclusão e disponibiliza o arquivo conforme o contrato
    Então devo conseguir iniciar o download do arquivo correspondente à solicitação
    E devo distinguir geração em andamento de arquivo pronto
    E o arquivo deve manter formato e recorte associados àquela solicitação

    Exemplos:
      | exemplo | escopo |
      | Produto | do Produto Alfa |
      | Empresa | empresarial de Alfa e Gama |


  @USID_033 @USID_035 @pagina @front @criterio_front
  Esquema do Cenário: 25 Desistir antes de iniciar a geração - <exemplo>
    Dado que abri a configuração de exportação <escopo> sem confirmar
    Quando cancelo essa configuração
    Então devo retornar ao dashboard com seus filtros preservados
    E nenhuma solicitação de geração deve ser enviada
    E a interface não deve registrar essa desistência como exportação concluída

    Exemplos:
      | exemplo | escopo |
      | Produto | por Produto |
      | Empresa | empresarial |


  @USID_033 @pagina @front @contrato
  Cenário: 26 Cancelar geração em andamento do Produto
    Dado que a geração do relatório do Produto Alfa está em andamento
    Quando aciono o cancelamento e o serviço confirma a interrupção conforme o contrato
    Então devo voltar ao dashboard com o recorte preservado e indicação de cancelamento
    E a resposta posterior da tarefa cancelada não deve iniciar download automático
    E fechar uma janela sem confirmação do serviço não deve ser tratado como cancelamento efetivo


  @USID_035 @pagina @front @contrato @criterio_front
  Esquema do Cenário: 27 Usar cancelamento empresarial somente quando suportado - <exemplo>
    Dado que a operação empresarial <suporte>
    Quando consulto a possibilidade de cancelar a geração em andamento
    Então devo observar <resultado>
    E uma recusa de permissão não deve ser interpretada como confirmação de cancelamento

    Exemplos:
      | exemplo | suporte | resultado |
      | suportado | oferece cancelamento documentado e o confirma quando solicitado | ação de cancelamento com retorno ao dashboard após confirmação |
      | sem operação | não oferece cancelamento documentado | ausência de promessa de interrupção do serviço ao fechar a interface |


  @USID_033 @USID_035 @pagina @front @contrato @criterio_front
  Esquema do Cenário: 28 Recuperar a interface após falha de exportação - <exemplo>
    Dado que uma exportação autorizada está em <etapa>
    Quando ocorre <falha>
    Então devo visualizar que essa etapa não foi concluída e poder recuperar a operação
    E não devo mostrar confirmação de arquivo baixado sem comprovação
    E Produto Empresa e filtros do dashboard devem permanecer recuperáveis

    Exemplos:
      | exemplo | etapa | falha |
      | início | solicitação de geração | erro de comunicação sem confirmação de criação |
      | geração | geração confirmada | erro de processamento informado pelo Core |
      | download | arquivo disponibilizado | falha de obtenção do arquivo |


  @USID_033 @USID_035 @pagina @front @criterio_front
  Cenário: 29 Evitar solicitações repetidas pelo mesmo controle
    Dado que confirmei uma exportação e o controle aguarda a resposta
    Quando aciono novamente a confirmação
    Então o Front não deve enviar duas solicitações simultâneas idênticas pelo mesmo controle
    E devo perceber o andamento e conseguir recuperar o controle após a resposta
    E o teste não deve inventar uma garantia de idempotência do serviço


  @USID_033 @USID_035 @pagina @front @contrato @criterio_front
  Esquema do Cenário: 30 Rejeitar retorno de arquivo incompatível com o contrato - <exemplo>
    Dado que uma exportação aguarda um arquivo válido
    Quando a fronteira de download retorna <resposta>
    Então a interface não deve anunciar download concluído de um relatório válido
    E devo visualizar orientação de falha sem executar conteúdo inesperado
    E o tratamento deve usar os campos e sinais realmente disponíveis no contrato de download

    Exemplos:
      | exemplo | resposta |
      | erro HTML | página HTML de erro no lugar do arquivo solicitado |
      | referência ausente | retorno sem arquivo ou referência obrigatória |
      | formato divergente | arquivo identificado com formato diferente do confirmado |
      | conteúdo inválido | resposta inválida segundo as verificações previstas no contrato |


  @USID_033 @USID_035 @pagina @front @contrato @ADR_126
  Cenário: 31 Interromper entrega quando o acesso for recusado
    Dado que uma exportação foi solicitada com autorização
    Quando a obtenção do arquivo retorna negação simples por perda de acesso ao Produto ou à Empresa
    Então nenhum arquivo ou conteúdo recusado deve ser entregue pela interface
    E devo retornar à área inicial mantendo a sessão conforme a ADR_126
    E a autorização obtida no início não deve ser tratada como permissão permanente de download


```

Nos cenários 22 a 31, usar cada formato documentado disponível. No cenário 30, não exigir que o Front decodifique qualquer arquivo arbitrário: simular os sinais de erro que sua fronteira permite reconhecer. A análise integral do conteúdo ocorre no cenário 38. Cancelamento empresarial nos cenários 27 e 39 é verificado somente quando suportado pelo contrato, sem transformar a redação inconsistente do USID_035 em uma regra nova.

## 6 Proteção e qualidade da interface

```gherkin
# language: pt
Funcionalidade: 6 Proteção e qualidade da interface

  @USID_031 @USID_034 @pagina @front @contrato @ADR_032
  Esquema do Cenário: 32 Tratar sessão inválida e revogação conforme a operação - <exemplo>
    Dado que uma consulta ou exportação está em andamento
    Quando a operação retorna <retorno>
    Então devo visualizar Você foi deslogado e retornar ao SignIn sem manter conteúdo protegido
    E o tratamento não deve depender de uma mensagem no corpo
    E esse caso não deve ser confundido com a negação simples da ADR_126

    Exemplos:
      | exemplo | retorno |
      | sessão inválida | 401 do Core |
      | revogação aplicável | 403 classificado pelo contrato como revogação da ADR_032 |


  @USID_031 @USID_034 @USID_036 @pagina @front @contrato @criterio_front
  Esquema do Cenário: 33 Tratar resposta inesperada sem fabricar indicadores - <exemplo>
    Dado que uma consulta de dashboard aguarda resposta
    Quando a fronteira consumida retorna <resposta> fora do contrato
    Então devo visualizar orientação geral de falha sem travar nem mostrar null ou undefined
    E não devo apresentar indicadores antigos como atuais nem fabricar zero para preencher dados ausentes
    E devo poder recuperar a consulta sem perder a identificação do contexto autorizado

    Exemplos:
      | exemplo | resposta |
      | nulo | null |
      | vazio | corpo vazio quando é exigido conteúdo |
      | estrutura inválida | JSON inválido ou HTML inesperado |
      | sucesso incompleto | HTTP 200 sem os campos exigidos do dashboard |
      | erro desconhecido | erro sem causa reconhecida pelo contrato |


  @USID_031 @USID_032 @USID_033 @USID_036 @USID_037 @pagina @front @criterio_front
  Esquema do Cenário: 34 Operar ações essenciais somente pelo teclado - <exemplo>
    Dado que utilizo a interface somente pelo teclado
    Quando realizo <acao>
    Então os controles necessários devem ser alcançáveis com foco visível e ordem compreensível
    E uma janela de exportação deve manter foco útil e devolvê-lo ao controle de origem ao fechar
    E a ação não deve depender do mouse

    Exemplos:
      | exemplo | acao |
      | filtros | selecionar Produto e aplicar critérios |
      | exportação | escolher formato e confirmar ou desistir |
      | consulta empresarial | alterar seleção de Produtos e consultar resultados |


  @USID_031 @USID_032 @USID_033 @componente @front @criterio_front
  Esquema do Cenário: 35 Identificar indicadores controles e erros de forma acessível - <exemplo>
    Dado que verifico <elemento> no componente do LhamaLog
    Quando consulto o nome acessível e a leitura assistiva
    Então devo compreender <informacao> sem depender somente de cor ícone ou placeholder
    E os resultados devem ser confirmados na página real com tecnologia assistiva

    Exemplos:
      | exemplo | elemento | informacao |
      | indicador | card ou representação do gráfico | nome unidade e valor ou alternativa textual equivalente |
      | filtro | campo de data com erro | qual campo corrigir e por quê |
      | exportação | controle de geração | ação disponível e estado de processamento |


  @USID_031 @USID_033 @USID_034 @pagina @front @criterio_front
  Esquema do Cenário: 36 Manter dashboard e exportação operáveis com zoom - <exemplo>
    Dado que abro <tela> nas condições <condicoes>
    Quando consulto dados e percorro os controles
    Então rótulos valores filtros botões e foco devem permanecer legíveis e alcançáveis
    E nenhum controle necessário deve ficar cortado ou sobreposto
    E gráficos devem ter acesso aos seus dados sem exigir somente precisão de ponteiro

    Exemplos:
      | exemplo | tela | condicoes |
      | estreita | dashboard por Produto | viewport 360 por 800 e zoom 100 por cento |
      | ampliada | dashboard empresarial | viewport 1280 por 800 e zoom 200 por cento |
      | modal | configuração de exportação | viewport 1280 por 800 e zoom 200 por cento |


```

## 7 Integração real

```gherkin
# language: pt
Funcionalidade: 7 Integração real

  @USID_031 @USID_032 @USID_034 @USID_036 @integracao @ADR_141
  Esquema do Cenário: 37 Consultar dados reais de teste pelo Core - <exemplo>
    Dado que o Core real de teste contém dados fictícios do recorte <escopo>
    Quando aplico critérios válidos pela interface Web
    Então as chamadas de negócio devem ir ao Core com sessão Empresa e Produtos corretos
    E indicadores e gráficos devem corresponder aos valores e unidades devolvidos para essa consulta
    E a evidência deve identificar o contrato usado sem declarar validada uma fórmula de agregação não especificada

    Exemplos:
      | exemplo | escopo |
      | Produto | Produto Alfa |
      | Empresa | Empresa Exemplo A com Alfa e Gama autorizados |


  @USID_033 @USID_035 @integracao @ADR_121 @ADR_122
  Esquema do Cenário: 38 Conferir o conteúdo do relatório gerado - <exemplo>
    Dado que a operação real oferece um formato de exportação documentado para <escopo>
    E registrei os filtros confirmados e os dados fictícios de referência desse recorte
    Quando confirmo e obtenho o arquivo real gerado
    Então o arquivo deve corresponder ao formato e aos filtros da solicitação
    E seus dados devem pertencer apenas à Empresa e aos Produtos autorizados no recorte
    E devo conferir o conteúdo do arquivo e não somente sua extensão ou presença de um link
    E a geração deve ter o registro de exportação previsto na fonte comprovado em evidência do serviço

    Exemplos:
      | exemplo | escopo |
      | Produto | Produto Alfa |
      | Empresa | Empresa Exemplo A com Alfa e Gama |


  @USID_033 @USID_035 @integracao
  Esquema do Cenário: 39 Comprovar o cancelamento real da geração - <exemplo>
    Dado que a operação de <escopo> oferece cancelamento documentado no ambiente de teste
    E uma tarefa de geração fictícia está em andamento
    Quando solicito o cancelamento pela interface
    Então o serviço deve confirmar a interrupção conforme seu contrato e a tela deve retornar ao dashboard
    E a evidência deve demonstrar o resultado da tarefa sem usar apenas o fechamento da janela como prova

    Exemplos:
      | exemplo | escopo |
      | Produto | relatório do Produto Alfa |
      | Empresa quando suportado | relatório empresarial |


```

## Anexo Verificações complementares de backend

Usar operações reais e contrato documentado do ambiente. A validação da interface não substitui a proteção da API ou a autorização do arquivo.

```gherkin
# language: pt
Funcionalidade: Anexo Verificações complementares de backend

  @USID_031 @USID_033 @USID_034 @USID_035 @USID_037 @api @core @ADR_121 @ADR_122 @ADR_126
  Esquema do Cenário: 40 Recusar operações fora do escopo autorizado - <exemplo>
    Dado que a sessão fictícia não tem acesso ao contexto solicitado
    Quando chamo diretamente <operacao> com identificador de outra Empresa ou Produto sem permissão
    Então o Core deve recusar sem devolver dados indicadores contribuição agregada ou arquivo desse contexto
    E a recusa deve seguir o contrato de negação simples sem revogar a sessão por esse motivo

    Exemplos:
      | exemplo | operacao |
      | dados | consulta de dashboard ou Ocorrências empresariais |
      | geração | solicitação de relatório |
      | obtenção | obtenção do arquivo de relatório |


  @USID_032 @USID_033 @USID_035 @USID_036 @api @core @criterio_front
  Esquema do Cenário: 41 Validar critérios e formato sem depender do formulário - <exemplo>
    Dado que identifiquei a operação real e seus parâmetros documentados
    Quando envio diretamente <entrada> incompatível com esse contrato
    Então o Core deve recusar conforme o contrato sem consultar ou exportar um escopo irrestrito por omissão
    E a proteção não deve depender da validação feita pelo navegador

    Exemplos:
      | exemplo | entrada |
      | período | intervalo inicial posterior ao final |
      | tipo de dado | tipo inválido no parâmetro de filtro exigido |
      | formato | formato não suportado pela operação de exportação |


  @USID_033 @USID_035 @api @core @ADR_121 @ADR_122
  Cenário: 42 Proteger a referência de download contra outra identidade
    Dado que Ana Exemplo gerou um relatório autorizado no ambiente de teste
    E Bruno Exemplo não tem acesso ao contexto desse relatório
    Quando Bruno tenta usar diretamente a referência de obtenção do arquivo pelo mecanismo previsto no contrato
    Então o serviço deve impedir a obtenção dos dados sem autorização
    E o teste deve verificar o mecanismo efetivo de autorização da entrega sem inventar prazo ou tecnologia de URL


```

## Acompanhamento de implementação

Marcar somente após obter a evidência. Para concluir o grupo de um cenário parametrizado, conferir as variações aplicáveis. No caso dos relatórios, registrar também o formato. Não marcar Red ou Refactor como realizados para código interno de provedor; justificar Não aplicável quando necessário.

### Cenário 01 — Aguardar carregamento sem antecipar indicadores

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 02 — Selecionar somente um Produto autorizado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 03 — Representar valores recebidos sem inventar métricas

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 04 — Apresentar ausência de dados coletados

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 05 — Ignorar métricas atrasadas de outro Produto

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 06 — Recuperar o dashboard após falha de carregamento

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 07 — Aplicar critérios suportados pelo contrato

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 08 — Impedir aplicação normal de filtro inválido

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 09 — Alterar ou remover filtros e atualizar os dados

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 10 — Distinguir resultado filtrado vazio de erro

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 11 — Manter somente a última consulta aplicada

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 12 — Mostrar consolidação autorizada da Empresa

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 13 — Restringir a consolidação aos Produtos permitidos

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 14 — Tratar negação simples de acesso empresarial

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 15 — Abrir detalhamento do Produto selecionado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 16 — Selecionar vários Produtos sem ampliar a autorização

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 17 — Preservar filtros empresariais até alteração ou remoção

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 18 — Filtrar Ocorrências de múltiplos Produtos

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 19 — Mostrar consulta de Ocorrências sem correspondência

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 20 — Alterar e remover critérios da consulta empresarial

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 21 — Abrir detalhe preservando Empresa e Produto da Ocorrência

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 22 — Oferecer somente formatos disponibilizados para a operação

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 23 — Capturar o recorte aplicado ao confirmar a exportação

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 24 — Disponibilizar o arquivo concluído para download

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 25 — Desistir antes de iniciar a geração

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 26 — Cancelar geração em andamento do Produto

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 27 — Usar cancelamento empresarial somente quando suportado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 28 — Recuperar a interface após falha de exportação

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 29 — Evitar solicitações repetidas pelo mesmo controle

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 30 — Rejeitar retorno de arquivo incompatível com o contrato

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 31 — Interromper entrega quando o acesso for recusado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 32 — Tratar sessão inválida e revogação conforme a operação

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 33 — Tratar resposta inesperada sem fabricar indicadores

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 34 — Operar ações essenciais somente pelo teclado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 35 — Identificar indicadores controles e erros de forma acessível

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 36 — Manter dashboard e exportação operáveis com zoom

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 37 — Consultar dados reais de teste pelo Core

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 38 — Conferir o conteúdo do relatório gerado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 39 — Comprovar o cancelamento real da geração

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 40 — Recusar operações fora do escopo autorizado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 41 — Validar critérios e formato sem depender do formulário

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 42 — Proteger a referência de download contra outra identidade

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Registro de execução e evidências

Copie para cada cenário, exemplo, formato, camada e execução. Os resultados possíveis são Não executado, Passou, Falhou ou Não aplicável com justificativa.

- Cenário e exemplo: PREENCHER
- USID e fonte: PREENCHER
- Camada e responsabilidade: PREENCHER componente, página, API ou integração
- Cliente ou Empresa e Produtos: PREENCHER contexto fictício
- Ambiente assinatura e capacidades: PREENCHER
- Operação contrato e resposta simulada ou real: PREENCHER
- Filtros aplicados e recorte da solicitação: PREENCHER
- Formato e referência do arquivo fictício: PREENCHER ou Não aplicável com justificativa
- Navegador viewport zoom e tecnologia assistiva: PREENCHER ou Não aplicável com justificativa
- Etapa: PREENCHER Red, Green, Refactor ou verificação de contrato
- Teste automatizado: PREENCHER link ou caminho, ou Não existe
- Resultado: PREENCHER após executar
- Evidência: PREENCHER referência sem segredos ou Não existe
- OBS: PREENCHER observação ou Sem observações

### Critérios de aceite do planejamento

- [ ] Conferi a cobertura de USID_031–037 e os limites descritos neste plano
- [ ] Conferi pré-condições fictícias, ação e resultado observável por cenário
- [ ] Conferi os contratos de métricas, formatos, autorização e cancelamento efetivamente utilizados
- [ ] Registrei a revisão de correspondência com o design da LLT-46 exigida na atividade

- Registro da revisão: PREENCHER data, responsável e referência
- OBS da revisão: PREENCHER observação ou Sem observações

A revisão permanece desmarcada até existir evidência. Este plano não comprova aprovação formal, definição final de fórmulas ou formatos, execução dos testes nem conclusão da LLT-85 no Jira.

## Referências

- [LLT-85 Planejar testes de dashboards e relatórios](https://logviewer2026.atlassian.net/browse/LLT-85)
- [LLT-83 Modelo e matriz](https://docs.google.com/document/d/1ViQWy2JQV8QrvdRj3Iz3gRgJnkq9XBBOQD2tkvrthRY/edit)
- [LLT-84 Plano de Ocorrências](https://docs.google.com/document/d/1tvxbaPxY3Ujjk7fkeWjikjmOuR7lsyoe45LafI_BoFc/edit)
- [LLT-86 Plano de login Web](https://docs.google.com/document/d/1W4dsdN3F6DSZo3ZSR_9TGUqEb7kDmHgO65C_Gd-EV6k/edit)
- [USID_031–037 Casos de uso](https://docs.google.com/spreadsheets/d/1JObvNfZAJvCPjG4urP4OZKHVhKFNyCeVq1w2w8agRb0/edit)
- [LLT-46 Referências de design Web](https://logviewer2026.atlassian.net/browse/LLT-46)
- [Figma Produtos com padrão](https://www.figma.com/design/e88SaMez3hQZ0nmmC3uEtm/LhamaLog?node-id=422-9959)
- [Figma Lista e filtros de Produtos](https://www.figma.com/design/e88SaMez3hQZ0nmmC3uEtm/LhamaLog?node-id=422-8140)
- [Figma Contexto de Empresa com padrão](https://www.figma.com/design/e88SaMez3hQZ0nmmC3uEtm/LhamaLog?node-id=422-9960)
- [Pasta oficial dos ADRs](https://drive.google.com/drive/folders/1SsRGM7_f7WD8L0O4GnozbosImt8zReTs)

### ADRs aplicáveis

- [ADR_032](https://docs.google.com/document/d/1m_5y0BqS_KPWIwkMs9-AThB1wTRNr1-F1u7BnWt7jNg/edit) — Tratamento de erros 401/403 e renovação da sessão
- [ADR_121](https://docs.google.com/document/d/1D-M3nCYKSf2tgtKqEW6MrCZIqKT-fj7PPBf23nkpyzM/edit) — Modelo multi-tenant SaaS pool com tenant = empresa cliente (substitui a ADR_105)
- [ADR_122](https://docs.google.com/document/d/1eVI3Yt_6dfXpv1c8ntY2MDRQc_kF2S4dr8TktO6cR2E/edit) — Coleções do modelo multi-tenant
- [ADR_124](https://docs.google.com/document/d/1XdxDJwToqR9oCEw2hMD5oM6wytJKZ0awQzyej91SUZs/edit) — Downgrade altera só a Assinatura
- [ADR_126](https://docs.google.com/document/d/1QRk3uGaZZTc_tM64PkaFodcEAQ7ruIr_9Oz4Htq8srk/edit) — Negação simples para não-membro ou Produto errado na URL
- [ADR_131](https://docs.google.com/document/d/1lGdz1U9ei53EdjwnV7Ut2b0dIXsQ3gAnEWPmhyjbyf0/edit) — TabelaPrecificacao com base no Plano de Monetização
- [ADR_141](https://docs.google.com/document/d/1tsFBbpdq8JqGasM8EcNN6oIXaAAVOXlxa3nJkanQIks/edit) — Segmentação de rede dos módulos
