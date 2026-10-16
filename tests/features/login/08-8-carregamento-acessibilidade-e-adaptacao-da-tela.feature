# language: pt
@LLT86
Funcionalidade: 8 Carregamento acessibilidade e adaptação da tela

  @USID_049 @front @pagina @perfil_atual @criterio_front
  @LLT86_C35 @planejado
  Esquema do Cenário: 35 Aguardar a resolução inicial da sessão - <exemplo>
    Dado que abro a aplicação e a Clerk ainda está inicializando
    Quando o estado final será <estado>
    Então devo perceber o carregamento sem um formulário ativo prematuro
    E nenhum conteúdo protegido deve aparecer enquanto a sessão estiver indefinida
    E ao resolver o estado devo visualizar <destino> sem oscilação indevida entre telas

    Exemplos:
      | exemplo | estado | destino |
      | visitante | sem sessão | SignIn |
      | sessão válida | sessão ativa com MFA concluído | área inicial |
      | sessão incompleta | sessão pending com setup obrigatório | setup-mfa sem conteúdo protegido |


  @USID_049 @front @pagina @perfil_atual @criterio_front
  @LLT86_C36 @planejado
  Esquema do Cenário: 36 Tratar falha ao inicializar a autenticação - <exemplo>
    Dado que a página de login está sendo aberta
    Quando ocorre <falha> antes de montar o SignIn
    Então devo visualizar uma orientação de indisponibilidade sem detalhes internos
    E a página não deve ficar branca nem manter carregamento indefinido
    E devo conseguir recarregar a página para tentar novamente
    E nenhum acesso protegido deve ser liberado

    Exemplos:
      | exemplo | falha |
      | recurso indisponível | falha no carregamento do recurso do provedor |
      | configuração recusada | erro de configuração informado pela inicialização do provedor |


  @USID_049 @USID_051 @front @pagina @perfil_atual @criterio_front
  @LLT86_C37 @planejado
  Esquema do Cenário: 37 Operar o fluxo somente pelo teclado - <exemplo>
    Dado que estou em <etapa> com o componente real e dados fictícios
    Quando percorro os controles com Tab e Shift Tab e aciono a ação com a tecla adequada ao controle
    Então todos os controles necessários devem ser alcançáveis em ordem compreensível
    E o foco deve estar visível sem ficar preso em um controle
    E devo conseguir <acao> sem depender do mouse
    E o envio não deve ocorrer em duplicidade

    Exemplos:
      | exemplo | etapa | acao |
      | primeira etapa | SignIn por senha | preencher e enviar as credenciais |
      | segundo fator | desafio TOTP | preencher e enviar o fator |
      | recuperação | recuperação de senha da Clerk | informar os dados e avançar |
      | retorno | desafio de MFA com ação de retorno disponível | voltar à entrada sem conceder acesso |


  @USID_049 @USID_051 @front @pagina @componente @perfil_atual @criterio_front
  @LLT86_C38 @planejado
  Esquema do Cenário: 38 Identificar controles e erros por tecnologia assistiva - <exemplo>
    Dado que verifico <elemento> na tela com o componente real
    Quando consulto o nome acessível e a leitura por tecnologia assistiva
    Então devo identificar <informacao> sem depender apenas de cor ou placeholder
    E um erro específico deve estar associado ao campo correspondente e ser percebido na leitura
    E não deve ser necessário conhecer um nome interno do código para usar a interface

    Exemplos:
      | exemplo | elemento | informacao |
      | e-mail | campo de e-mail após erro local | finalidade do campo e erro de formato |
      | senha | campo de senha após ausência de preenchimento | finalidade do campo e obrigatoriedade |
      | fator | campo TOTP após rejeição | finalidade do campo e erro do fator |
      | envio | botão de continuar | ação executada e estado indisponível durante envio |


  @USID_049 @USID_051 @front @pagina @perfil_atual @criterio_front
  @LLT86_C39 @planejado
  Esquema do Cenário: 39 Manter o foco útil após mudanças de estado - <exemplo>
    Dado que utilizo a autenticação pelo teclado
    Quando ocorre <mudanca>
    Então o foco deve chegar a <destino> que permita entender o estado e continuar
    E o foco não deve permanecer em elemento removido ou oculto
    E a ordem de navegação deve continuar compreensível

    Exemplos:
      | exemplo | mudanca | destino |
      | avançar para MFA | primeira etapa aceita e desafio de MFA exibido | identificação da nova etapa ou primeiro controle do desafio |
      | erro de campo | validação local impede o envio | campo inválido ou resumo acessível que leve ao campo |
      | erro de serviço | provedor rejeita o fator | orientação perceptível e controle para corrigir a tentativa |
      | retorno à entrada | ação de voltar exibe o SignIn | identificação da etapa ou primeiro controle da entrada |


  @USID_049 @USID_051 @front @pagina @perfil_atual @criterio_front
  @LLT86_C40 @planejado
  Esquema do Cenário: 40 Usar a autenticação com largura reduzida e zoom - <exemplo>
    Dado que abro <etapa> no navegador desktop com viewport <largura> e zoom <zoom>
    Quando preencho os dados e visualizo uma orientação de validação
    Então campos botões mensagens e foco devem continuar legíveis e alcançáveis
    E nenhum controle necessário deve ficar cortado ou coberto
    E devo conseguir concluir ou corrigir a etapa usando rolagem vertical quando necessária
    E o conteúdo do formulário não deve exigir rolagem horizontal para ler e operar

    Exemplos:
      | exemplo | etapa | largura | zoom |
      | login estreito | SignIn | 360 por 800 pixels | 100 por cento |
      | MFA estreito | desafio TOTP | 360 por 800 pixels | 100 por cento |
      | recuperação estreita | recuperação de senha | 360 por 800 pixels | 100 por cento |
      | login ampliado | SignIn | 1280 por 800 pixels | 200 por cento |
      | MFA ampliado | desafio TOTP | 1280 por 800 pixels | 200 por cento |
      | recuperação ampliada | recuperação de senha | 1280 por 800 pixels | 200 por cento |
