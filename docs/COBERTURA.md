# Cobertura convertida

130 cenários e 303 linhas de execução. Implementação e resultado devem ser conferidos no inventário e nos relatórios.

| ID | Cenário | Exemplos | Arquivo |
| --- | --- | --- | --- |
| LLT84_C01 | 01 Mostrar carregamento sem antecipar resultado | 1 | [01-1-listagem-de-ocorrencias.feature](../tests/features/ocorrencias/01-1-listagem-de-ocorrencias.feature) |
| LLT84_C02 | 02 Apresentar os registros e atributos retornados - <exemplo> | 4 | [01-1-listagem-de-ocorrencias.feature](../tests/features/ocorrencias/01-1-listagem-de-ocorrencias.feature) |
| LLT84_C03 | 03 Mostrar lista vazia do Produto autorizado | 1 | [01-1-listagem-de-ocorrencias.feature](../tests/features/ocorrencias/01-1-listagem-de-ocorrencias.feature) |
| LLT84_C04 | 04 Recuperar a listagem após falha - <exemplo> | 2 | [01-1-listagem-de-ocorrencias.feature](../tests/features/ocorrencias/01-1-listagem-de-ocorrencias.feature) |
| LLT84_C05 | 05 Ignorar resposta atrasada de outro Produto | 1 | [01-1-listagem-de-ocorrencias.feature](../tests/features/ocorrencias/01-1-listagem-de-ocorrencias.feature) |
| LLT84_C06 | 06 Buscar Ocorrência por parâmetro suportado - <exemplo> | 2 | [02-2-busca-e-detalhe.feature](../tests/features/ocorrencias/02-2-busca-e-detalhe.feature) |
| LLT84_C07 | 07 Informar consulta sem correspondência | 1 | [02-2-busca-e-detalhe.feature](../tests/features/ocorrencias/02-2-busca-e-detalhe.feature) |
| LLT84_C08 | 08 Abrir o detalhe do registro selecionado - <exemplo> | 2 | [02-2-busca-e-detalhe.feature](../tests/features/ocorrencias/02-2-busca-e-detalhe.feature) |
| LLT84_C09 | 09 Consultar as abas de dados técnicos - <exemplo> | 3 | [02-2-busca-e-detalhe.feature](../tests/features/ocorrencias/02-2-busca-e-detalhe.feature) |
| LLT84_C10 | 10 Voltar ao estado anterior da consulta | 1 | [02-2-busca-e-detalhe.feature](../tests/features/ocorrencias/02-2-busca-e-detalhe.feature) |
| LLT84_C11 | 11 Tratar detalhe indisponível sem mostrar outro registro - <exemplo> | 2 | [02-2-busca-e-detalhe.feature](../tests/features/ocorrencias/02-2-busca-e-detalhe.feature) |
| LLT84_C12 | 12 Aplicar um filtro suportado - <exemplo> | 4 | [03-3-filtros-e-paginacao.feature](../tests/features/ocorrencias/03-3-filtros-e-paginacao.feature) |
| LLT84_C13 | 13 Combinar filtros na mesma consulta - <exemplo> | 3 | [03-3-filtros-e-paginacao.feature](../tests/features/ocorrencias/03-3-filtros-e-paginacao.feature) |
| LLT84_C14 | 14 Mostrar ausência de resultados filtrados | 1 | [03-3-filtros-e-paginacao.feature](../tests/features/ocorrencias/03-3-filtros-e-paginacao.feature) |
| LLT84_C15 | 15 Limpar filtros e retornar à primeira página | 1 | [03-3-filtros-e-paginacao.feature](../tests/features/ocorrencias/03-3-filtros-e-paginacao.feature) |
| LLT84_C16 | 16 Navegar mantendo os filtros ativos - <exemplo> | 3 | [03-3-filtros-e-paginacao.feature](../tests/features/ocorrencias/03-3-filtros-e-paginacao.feature) |
| LLT84_C17 | 17 Alterar a quantidade por página sem perder filtros - <exemplo> | 2 | [03-3-filtros-e-paginacao.feature](../tests/features/ocorrencias/03-3-filtros-e-paginacao.feature) |
| LLT84_C18 | 18 Impedir envio normal de filtro inválido - <exemplo> | 2 | [03-3-filtros-e-paginacao.feature](../tests/features/ocorrencias/03-3-filtros-e-paginacao.feature) |
| LLT84_C19 | 19 Manter o resultado da última consulta solicitada | 1 | [03-3-filtros-e-paginacao.feature](../tests/features/ocorrencias/03-3-filtros-e-paginacao.feature) |
| LLT84_C20 | 20 Confirmar transição manual permitida - <exemplo> | 4 | [04-4-marcacao-do-estado.feature](../tests/features/ocorrencias/04-4-marcacao-do-estado.feature) |
| LLT84_C21 | 21 Cancelar mudança sem alterar a Ocorrência | 1 | [04-4-marcacao-do-estado.feature](../tests/features/ocorrencias/04-4-marcacao-do-estado.feature) |
| LLT84_C22 | 22 Tratar recusa de fechamento com Sugestão não finalizada | 1 | [04-4-marcacao-do-estado.feature](../tests/features/ocorrencias/04-4-marcacao-do-estado.feature) |
| LLT84_C23 | 23 Refletir o estado recebido no fluxo de Sugestão - <exemplo> | 3 | [04-4-marcacao-do-estado.feature](../tests/features/ocorrencias/04-4-marcacao-do-estado.feature) |
| LLT84_C24 | 24 Não confirmar gravação após falha ou timeout - <exemplo> | 2 | [04-4-marcacao-do-estado.feature](../tests/features/ocorrencias/04-4-marcacao-do-estado.feature) |
| LLT84_C25 | 25 Confirmar arquivamento individual - <exemplo> | 2 | [05-5-arquivamento.feature](../tests/features/ocorrencias/05-5-arquivamento.feature) |
| LLT84_C26 | 26 Cancelar arquivamento individual ou em lote - <exemplo> | 2 | [05-5-arquivamento.feature](../tests/features/ocorrencias/05-5-arquivamento.feature) |
| LLT84_C27 | 27 Arquivar somente os registros selecionados | 1 | [05-5-arquivamento.feature](../tests/features/ocorrencias/05-5-arquivamento.feature) |
| LLT84_C28 | 28 Tratar falha de arquivamento sem ocultar sucesso inexistente - <exemplo> | 2 | [05-5-arquivamento.feature](../tests/features/ocorrencias/05-5-arquivamento.feature) |
| LLT84_C29 | 29 Evitar confirmação duplicada de mutação - <exemplo> | 2 | [05-5-arquivamento.feature](../tests/features/ocorrencias/05-5-arquivamento.feature) |
| LLT84_C30 | 30 Voltar à área inicial em negação simples - <exemplo> | 3 | [06-6-acesso-e-tratamento-de-respostas.feature](../tests/features/ocorrencias/06-6-acesso-e-tratamento-de-respostas.feature) |
| LLT84_C31 | 31 Encerrar acesso local diante de 401 do Core | 1 | [06-6-acesso-e-tratamento-de-respostas.feature](../tests/features/ocorrencias/06-6-acesso-e-tratamento-de-respostas.feature) |
| LLT84_C32 | 32 Continuar utilizável diante de retorno inesperado - <exemplo> | 5 | [06-6-acesso-e-tratamento-de-respostas.feature](../tests/features/ocorrencias/06-6-acesso-e-tratamento-de-respostas.feature) |
| LLT84_C33 | 33 Operar ações essenciais pelo teclado - <exemplo> | 3 | [07-7-qualidade-da-interface.feature](../tests/features/ocorrencias/07-7-qualidade-da-interface.feature) |
| LLT84_C34 | 34 Identificar campos e ações por tecnologia assistiva - <exemplo> | 3 | [07-7-qualidade-da-interface.feature](../tests/features/ocorrencias/07-7-qualidade-da-interface.feature) |
| LLT84_C35 | 35 Manter a tela operável com largura reduzida e zoom - <exemplo> | 3 | [07-7-qualidade-da-interface.feature](../tests/features/ocorrencias/07-7-qualidade-da-interface.feature) |
| LLT84_C36 | 36 Consultar o Core com contexto e filtros reais - <exemplo> | 3 | [08-8-integracao-real-do-front.feature](../tests/features/ocorrencias/08-8-integracao-real-do-front.feature) |
| LLT84_C37 | 37 Persistir e reler uma mudança de estado válida | 1 | [08-8-integracao-real-do-front.feature](../tests/features/ocorrencias/08-8-integracao-real-do-front.feature) |
| LLT84_C38 | 38 Arquivar e reler a lista ativa real | 1 | [08-8-integracao-real-do-front.feature](../tests/features/ocorrencias/08-8-integracao-real-do-front.feature) |
| LLT84_C39 | 39 Recusar consulta ou mutação fora do contexto autorizado - <exemplo> | 3 | [09-anexo-verificacoes-complementares-de-backend.feature](../tests/features/ocorrencias/09-anexo-verificacoes-complementares-de-backend.feature) |
| LLT84_C40 | 40 Validar restrições de transição sem depender do formulário - <exemplo> | 3 | [09-anexo-verificacoes-complementares-de-backend.feature](../tests/features/ocorrencias/09-anexo-verificacoes-complementares-de-backend.feature) |
| LLT84_C41 | 41 Validar parâmetros de consulta diretamente na API - <exemplo> | 3 | [09-anexo-verificacoes-complementares-de-backend.feature](../tests/features/ocorrencias/09-anexo-verificacoes-complementares-de-backend.feature) |
| LLT85_C01 | 01 Aguardar carregamento sem antecipar indicadores | 1 | [01-1-dashboard-por-produto.feature](../tests/features/dashboards-relatorios/01-1-dashboard-por-produto.feature) |
| LLT85_C02 | 02 Selecionar somente um Produto autorizado - <exemplo> | 3 | [01-1-dashboard-por-produto.feature](../tests/features/dashboards-relatorios/01-1-dashboard-por-produto.feature) |
| LLT85_C03 | 03 Representar valores recebidos sem inventar métricas - <exemplo> | 3 | [01-1-dashboard-por-produto.feature](../tests/features/dashboards-relatorios/01-1-dashboard-por-produto.feature) |
| LLT85_C04 | 04 Apresentar ausência de dados coletados | 1 | [01-1-dashboard-por-produto.feature](../tests/features/dashboards-relatorios/01-1-dashboard-por-produto.feature) |
| LLT85_C05 | 05 Ignorar métricas atrasadas de outro Produto | 1 | [01-1-dashboard-por-produto.feature](../tests/features/dashboards-relatorios/01-1-dashboard-por-produto.feature) |
| LLT85_C06 | 06 Recuperar o dashboard após falha de carregamento - <exemplo> | 2 | [01-1-dashboard-por-produto.feature](../tests/features/dashboards-relatorios/01-1-dashboard-por-produto.feature) |
| LLT85_C07 | 07 Aplicar critérios suportados pelo contrato - <exemplo> | 3 | [02-2-filtros-de-dashboards.feature](../tests/features/dashboards-relatorios/02-2-filtros-de-dashboards.feature) |
| LLT85_C08 | 08 Impedir aplicação normal de filtro inválido - <exemplo> | 2 | [02-2-filtros-de-dashboards.feature](../tests/features/dashboards-relatorios/02-2-filtros-de-dashboards.feature) |
| LLT85_C09 | 09 Alterar ou remover filtros e atualizar os dados - <exemplo> | 3 | [02-2-filtros-de-dashboards.feature](../tests/features/dashboards-relatorios/02-2-filtros-de-dashboards.feature) |
| LLT85_C10 | 10 Distinguir resultado filtrado vazio de erro | 1 | [02-2-filtros-de-dashboards.feature](../tests/features/dashboards-relatorios/02-2-filtros-de-dashboards.feature) |
| LLT85_C11 | 11 Manter somente a última consulta aplicada | 1 | [02-2-filtros-de-dashboards.feature](../tests/features/dashboards-relatorios/02-2-filtros-de-dashboards.feature) |
| LLT85_C12 | 12 Mostrar consolidação autorizada da Empresa - <exemplo> | 2 | [03-3-dashboard-empresarial.feature](../tests/features/dashboards-relatorios/03-3-dashboard-empresarial.feature) |
| LLT85_C13 | 13 Restringir a consolidação aos Produtos permitidos | 1 | [03-3-dashboard-empresarial.feature](../tests/features/dashboards-relatorios/03-3-dashboard-empresarial.feature) |
| LLT85_C14 | 14 Tratar negação simples de acesso empresarial - <exemplo> | 2 | [03-3-dashboard-empresarial.feature](../tests/features/dashboards-relatorios/03-3-dashboard-empresarial.feature) |
| LLT85_C15 | 15 Abrir detalhamento do Produto selecionado | 1 | [03-3-dashboard-empresarial.feature](../tests/features/dashboards-relatorios/03-3-dashboard-empresarial.feature) |
| LLT85_C16 | 16 Selecionar vários Produtos sem ampliar a autorização - <exemplo> | 3 | [03-3-dashboard-empresarial.feature](../tests/features/dashboards-relatorios/03-3-dashboard-empresarial.feature) |
| LLT85_C17 | 17 Preservar filtros empresariais até alteração ou remoção | 1 | [03-3-dashboard-empresarial.feature](../tests/features/dashboards-relatorios/03-3-dashboard-empresarial.feature) |
| LLT85_C18 | 18 Filtrar Ocorrências de múltiplos Produtos - <exemplo> | 2 | [04-4-ocorrencias-empresariais.feature](../tests/features/dashboards-relatorios/04-4-ocorrencias-empresariais.feature) |
| LLT85_C19 | 19 Mostrar consulta de Ocorrências sem correspondência | 1 | [04-4-ocorrencias-empresariais.feature](../tests/features/dashboards-relatorios/04-4-ocorrencias-empresariais.feature) |
| LLT85_C20 | 20 Alterar e remover critérios da consulta empresarial - <exemplo> | 3 | [04-4-ocorrencias-empresariais.feature](../tests/features/dashboards-relatorios/04-4-ocorrencias-empresariais.feature) |
| LLT85_C21 | 21 Abrir detalhe preservando Empresa e Produto da Ocorrência | 1 | [04-4-ocorrencias-empresariais.feature](../tests/features/dashboards-relatorios/04-4-ocorrencias-empresariais.feature) |
| LLT85_C22 | 22 Oferecer somente formatos disponibilizados para a operação - <exemplo> | 2 | [05-5-exportacao-de-relatorios.feature](../tests/features/dashboards-relatorios/05-5-exportacao-de-relatorios.feature) |
| LLT85_C23 | 23 Capturar o recorte aplicado ao confirmar a exportação - <exemplo> | 2 | [05-5-exportacao-de-relatorios.feature](../tests/features/dashboards-relatorios/05-5-exportacao-de-relatorios.feature) |
| LLT85_C24 | 24 Disponibilizar o arquivo concluído para download - <exemplo> | 2 | [05-5-exportacao-de-relatorios.feature](../tests/features/dashboards-relatorios/05-5-exportacao-de-relatorios.feature) |
| LLT85_C25 | 25 Desistir antes de iniciar a geração - <exemplo> | 2 | [05-5-exportacao-de-relatorios.feature](../tests/features/dashboards-relatorios/05-5-exportacao-de-relatorios.feature) |
| LLT85_C26 | 26 Cancelar geração em andamento do Produto | 1 | [05-5-exportacao-de-relatorios.feature](../tests/features/dashboards-relatorios/05-5-exportacao-de-relatorios.feature) |
| LLT85_C27 | 27 Usar cancelamento empresarial somente quando suportado - <exemplo> | 2 | [05-5-exportacao-de-relatorios.feature](../tests/features/dashboards-relatorios/05-5-exportacao-de-relatorios.feature) |
| LLT85_C28 | 28 Recuperar a interface após falha de exportação - <exemplo> | 3 | [05-5-exportacao-de-relatorios.feature](../tests/features/dashboards-relatorios/05-5-exportacao-de-relatorios.feature) |
| LLT85_C29 | 29 Evitar solicitações repetidas pelo mesmo controle | 1 | [05-5-exportacao-de-relatorios.feature](../tests/features/dashboards-relatorios/05-5-exportacao-de-relatorios.feature) |
| LLT85_C30 | 30 Rejeitar retorno de arquivo incompatível com o contrato - <exemplo> | 4 | [05-5-exportacao-de-relatorios.feature](../tests/features/dashboards-relatorios/05-5-exportacao-de-relatorios.feature) |
| LLT85_C31 | 31 Interromper entrega quando o acesso for recusado | 1 | [05-5-exportacao-de-relatorios.feature](../tests/features/dashboards-relatorios/05-5-exportacao-de-relatorios.feature) |
| LLT85_C32 | 32 Tratar sessão inválida e revogação conforme a operação - <exemplo> | 2 | [06-6-protecao-e-qualidade-da-interface.feature](../tests/features/dashboards-relatorios/06-6-protecao-e-qualidade-da-interface.feature) |
| LLT85_C33 | 33 Tratar resposta inesperada sem fabricar indicadores - <exemplo> | 5 | [06-6-protecao-e-qualidade-da-interface.feature](../tests/features/dashboards-relatorios/06-6-protecao-e-qualidade-da-interface.feature) |
| LLT85_C34 | 34 Operar ações essenciais somente pelo teclado - <exemplo> | 3 | [06-6-protecao-e-qualidade-da-interface.feature](../tests/features/dashboards-relatorios/06-6-protecao-e-qualidade-da-interface.feature) |
| LLT85_C35 | 35 Identificar indicadores controles e erros de forma acessível - <exemplo> | 3 | [06-6-protecao-e-qualidade-da-interface.feature](../tests/features/dashboards-relatorios/06-6-protecao-e-qualidade-da-interface.feature) |
| LLT85_C36 | 36 Manter dashboard e exportação operáveis com zoom - <exemplo> | 3 | [06-6-protecao-e-qualidade-da-interface.feature](../tests/features/dashboards-relatorios/06-6-protecao-e-qualidade-da-interface.feature) |
| LLT85_C37 | 37 Consultar dados reais de teste pelo Core - <exemplo> | 2 | [07-7-integracao-real.feature](../tests/features/dashboards-relatorios/07-7-integracao-real.feature) |
| LLT85_C38 | 38 Conferir o conteúdo do relatório gerado - <exemplo> | 2 | [07-7-integracao-real.feature](../tests/features/dashboards-relatorios/07-7-integracao-real.feature) |
| LLT85_C39 | 39 Comprovar o cancelamento real da geração - <exemplo> | 2 | [07-7-integracao-real.feature](../tests/features/dashboards-relatorios/07-7-integracao-real.feature) |
| LLT85_C40 | 40 Recusar operações fora do escopo autorizado - <exemplo> | 3 | [08-anexo-verificacoes-complementares-de-backend.feature](../tests/features/dashboards-relatorios/08-anexo-verificacoes-complementares-de-backend.feature) |
| LLT85_C41 | 41 Validar critérios e formato sem depender do formulário - <exemplo> | 3 | [08-anexo-verificacoes-complementares-de-backend.feature](../tests/features/dashboards-relatorios/08-anexo-verificacoes-complementares-de-backend.feature) |
| LLT85_C42 | 42 Proteger a referência de download contra outra identidade | 1 | [08-anexo-verificacoes-complementares-de-backend.feature](../tests/features/dashboards-relatorios/08-anexo-verificacoes-complementares-de-backend.feature) |
| LLT86_C01 | 01 Encaminhar após a primeira etapa - <exemplo> | 4 | [01-1-entrada-no-login.feature](../tests/features/login/01-1-entrada-no-login.feature) |
| LLT86_C02 | 02 Recusar senha incorreta no SignIn | 1 | [01-1-entrada-no-login.feature](../tests/features/login/01-1-entrada-no-login.feature) |
| LLT86_C03 | 03 Validar campos antes do envio normal - <exemplo> | 4 | [01-1-entrada-no-login.feature](../tests/features/login/01-1-entrada-no-login.feature) |
| LLT86_C04 | 04 Cancelar entrada pelo Google | 1 | [01-1-entrada-no-login.feature](../tests/features/login/01-1-entrada-no-login.feature) |
| LLT86_C05 | 05 Tratar falha da autenticação externa - <exemplo> | 3 | [01-1-entrada-no-login.feature](../tests/features/login/01-1-entrada-no-login.feature) |
| LLT86_C06 | 06 Aceitar um fator disponível no perfil atual - <exemplo> | 4 | [02-2-mfa-obrigatorio-e-codigos-de-backup.feature](../tests/features/login/02-2-mfa-obrigatorio-e-codigos-de-backup.feature) |
| LLT86_C07 | 07 Recusar verificação inválida - <exemplo> | 6 | [02-2-mfa-obrigatorio-e-codigos-de-backup.feature](../tests/features/login/02-2-mfa-obrigatorio-e-codigos-de-backup.feature) |
| LLT86_C08 | 08 Cancelar a verificação obrigatória | 1 | [03-3-processamento-e-protecao-da-sessao.feature](../tests/features/login/03-3-processamento-e-protecao-da-sessao.feature) |
| LLT86_C09 | 09 Evitar envio repetido na interface - <exemplo> | 2 | [03-3-processamento-e-protecao-da-sessao.feature](../tests/features/login/03-3-processamento-e-protecao-da-sessao.feature) |
| LLT86_C10 | 10 Recuperar a interface após falha de conexão - <exemplo> | 2 | [03-3-processamento-e-protecao-da-sessao.feature](../tests/features/login/03-3-processamento-e-protecao-da-sessao.feature) |
| LLT86_C11 | 11 Bloquear navegação antes de concluir autenticação - <exemplo> | 4 | [03-3-processamento-e-protecao-da-sessao.feature](../tests/features/login/03-3-processamento-e-protecao-da-sessao.feature) |
| LLT86_C12 | 12 Recarregar com sessão ativa | 1 | [03-3-processamento-e-protecao-da-sessao.feature](../tests/features/login/03-3-processamento-e-protecao-da-sessao.feature) |
| LLT86_C13 | 13 Interromper navegação após sessão inválida - <exemplo> | 2 | [03-3-processamento-e-protecao-da-sessao.feature](../tests/features/login/03-3-processamento-e-protecao-da-sessao.feature) |
| LLT86_C14 | 14 Não restaurar sessão depois de sair - <exemplo> | 2 | [03-3-processamento-e-protecao-da-sessao.feature](../tests/features/login/03-3-processamento-e-protecao-da-sessao.feature) |
| LLT86_C15 | 15 Mostrar somente os recursos retornados para a conta - <exemplo> | 3 | [04-4-area-inicial-e-identidade.feature](../tests/features/login/04-4-area-inicial-e-identidade.feature) |
| LLT86_C16 | 16 Não exigir tela própria de convite no login | 1 | [04-4-area-inicial-e-identidade.feature](../tests/features/login/04-4-area-inicial-e-identidade.feature) |
| LLT86_C17 | 17 Preservar a identidade resolvida pela Clerk | 1 | [04-4-area-inicial-e-identidade.feature](../tests/features/login/04-4-area-inicial-e-identidade.feature) |
| LLT86_C18 | 18 Usar a recuperação disponível no componente | 1 | [05-5-recuperacao-de-senha-e-de-mfa.feature](../tests/features/login/05-5-recuperacao-de-senha-e-de-mfa.feature) |
| LLT86_C19 | 19 Recuperar senha sem remover o MFA | 1 | [05-5-recuperacao-de-senha-e-de-mfa.feature](../tests/features/login/05-5-recuperacao-de-senha-e-de-mfa.feature) |
| LLT86_C20 | 20 Não enviar recuperação a um destino arbitrário | 1 | [05-5-recuperacao-de-senha-e-de-mfa.feature](../tests/features/login/05-5-recuperacao-de-senha-e-de-mfa.feature) |
| LLT86_C21 | 21 Recusar comprovação inválida na recuperação - <exemplo> | 2 | [05-5-recuperacao-de-senha-e-de-mfa.feature](../tests/features/login/05-5-recuperacao-de-senha-e-de-mfa.feature) |
| LLT86_C22 | 22 Exigir novo cadastro de MFA após reset autorizado | 1 | [05-5-recuperacao-de-senha-e-de-mfa.feature](../tests/features/login/05-5-recuperacao-de-senha-e-de-mfa.feature) |
| LLT86_C23 | 23 Não oferecer reset autônomo de MFA sem fator | 1 | [05-5-recuperacao-de-senha-e-de-mfa.feature](../tests/features/login/05-5-recuperacao-de-senha-e-de-mfa.feature) |
| LLT86_C24 | 24 Cadastrar fator exigido e disponibilizar backup | 1 | [06-6-configuracao-do-mfa-pela-clerk.feature](../tests/features/login/06-6-configuracao-do-mfa-pela-clerk.feature) |
| LLT86_C25 | 25 Cancelar setup sem liberar acesso | 1 | [06-6-configuracao-do-mfa-pela-clerk.feature](../tests/features/login/06-6-configuracao-do-mfa-pela-clerk.feature) |
| LLT86_C26 | 26 Manter fatores usando UserProfile | 1 | [06-6-configuracao-do-mfa-pela-clerk.feature](../tests/features/login/06-6-configuracao-do-mfa-pela-clerk.feature) |
| LLT86_C27 | 27 Não anunciar alteração de fator não concluída - <exemplo> | 2 | [06-6-configuracao-do-mfa-pela-clerk.feature](../tests/features/login/06-6-configuracao-do-mfa-pela-clerk.feature) |
| LLT86_C28 | 28 Apresentar erro reconhecido da Clerk - <exemplo> | 3 | [07-7-respostas-e-protecao-do-front.feature](../tests/features/login/07-7-respostas-e-protecao-do-front.feature) |
| LLT86_C29 | 29 Continuar utilizável diante de retorno inesperado - <exemplo> | 10 | [07-7-respostas-e-protecao-do-front.feature](../tests/features/login/07-7-respostas-e-protecao-do-front.feature) |
| LLT86_C30 | 30 Tratar 401 do Core mesmo sem mensagem - <exemplo> | 4 | [07-7-respostas-e-protecao-do-front.feature](../tests/features/login/07-7-respostas-e-protecao-do-front.feature) |
| LLT86_C31 | 31 Tratar 403 sujeito à revogação de sessões - <exemplo> | 2 | [07-7-respostas-e-protecao-do-front.feature](../tests/features/login/07-7-respostas-e-protecao-do-front.feature) |
| LLT86_C32 | 32 Preservar sessão em negação simples de acesso - <exemplo> | 3 | [07-7-respostas-e-protecao-do-front.feature](../tests/features/login/07-7-respostas-e-protecao-do-front.feature) |
| LLT86_C33 | 33 Respeitar o bloqueio de tentativas da Clerk - <exemplo> | 2 | [07-7-respostas-e-protecao-do-front.feature](../tests/features/login/07-7-respostas-e-protecao-do-front.feature) |
| LLT86_C34 | 34 Manter segredos de servidor fora do Front - <exemplo> | 3 | [07-7-respostas-e-protecao-do-front.feature](../tests/features/login/07-7-respostas-e-protecao-do-front.feature) |
| LLT86_C35 | 35 Aguardar a resolução inicial da sessão - <exemplo> | 3 | [08-8-carregamento-acessibilidade-e-adaptacao-da-tela.feature](../tests/features/login/08-8-carregamento-acessibilidade-e-adaptacao-da-tela.feature) |
| LLT86_C36 | 36 Tratar falha ao inicializar a autenticação - <exemplo> | 2 | [08-8-carregamento-acessibilidade-e-adaptacao-da-tela.feature](../tests/features/login/08-8-carregamento-acessibilidade-e-adaptacao-da-tela.feature) |
| LLT86_C37 | 37 Operar o fluxo somente pelo teclado - <exemplo> | 4 | [08-8-carregamento-acessibilidade-e-adaptacao-da-tela.feature](../tests/features/login/08-8-carregamento-acessibilidade-e-adaptacao-da-tela.feature) |
| LLT86_C38 | 38 Identificar controles e erros por tecnologia assistiva - <exemplo> | 4 | [08-8-carregamento-acessibilidade-e-adaptacao-da-tela.feature](../tests/features/login/08-8-carregamento-acessibilidade-e-adaptacao-da-tela.feature) |
| LLT86_C39 | 39 Manter o foco útil após mudanças de estado - <exemplo> | 4 | [08-8-carregamento-acessibilidade-e-adaptacao-da-tela.feature](../tests/features/login/08-8-carregamento-acessibilidade-e-adaptacao-da-tela.feature) |
| LLT86_C40 | 40 Usar a autenticação com largura reduzida e zoom - <exemplo> | 6 | [08-8-carregamento-acessibilidade-e-adaptacao-da-tela.feature](../tests/features/login/08-8-carregamento-acessibilidade-e-adaptacao-da-tela.feature) |
| LLT86_C41 | 41 Interpretar a autenticação real com MFA obrigatório - <exemplo> | 5 | [09-9-integracao-real-do-login-web.feature](../tests/features/login/09-9-integracao-real-do-login-web.feature) |
| LLT86_C42 | 42 Renovar sessão sem criar token de usuário próprio - <exemplo> | 2 | [09-9-integracao-real-do-login-web.feature](../tests/features/login/09-9-integracao-real-do-login-web.feature) |
| LLT86_C43 | 43 Enviar sessão ao Core pelo transporte correto - <exemplo> | 2 | [09-9-integracao-real-do-login-web.feature](../tests/features/login/09-9-integracao-real-do-login-web.feature) |
| LLT86_C44 | 44 Rejeitar entrada inválida sem passar pelo formulário - <exemplo> | 5 | [10-anexo-verificacoes-complementares-de-backend.feature](../tests/features/login/10-anexo-verificacoes-complementares-de-backend.feature) |
| LLT86_C45 | 45 Recusar sessão inválida diretamente no Core - <exemplo> | 6 | [10-anexo-verificacoes-complementares-de-backend.feature](../tests/features/login/10-anexo-verificacoes-complementares-de-backend.feature) |
| LLT86_C46 | 46 Revogar todas as sessões no 403 aplicável | 1 | [10-anexo-verificacoes-complementares-de-backend.feature](../tests/features/login/10-anexo-verificacoes-complementares-de-backend.feature) |
| LLT86_C47 | 47 Não criar Tenant somente por autenticar identidade - <exemplo> | 2 | [10-anexo-verificacoes-complementares-de-backend.feature](../tests/features/login/10-anexo-verificacoes-complementares-de-backend.feature) |
