# language: pt
@LLT86
Funcionalidade: 7 Respostas e proteção do Front

  @USID_049 @front @contrato @criterio_do_plano @pagina
  @LLT86_C28 @planejado
  Esquema do Cenário: 28 Apresentar erro reconhecido da Clerk - <exemplo>
    Dado que iniciei <operacao> no componente Clerk
    Quando a resposta controlada contém código ou tipo documentado para <causa>
    Então devo visualizar <orientacao> e poder corrigir a tentativa
    E o erro não deve concluir a etapa nem conceder acesso

    Exemplos:
      | exemplo | operacao | causa | orientacao |
      | e-mail inválido | a entrada por senha | formato de e-mail inválido | orientação sobre o campo |
      | senha rejeitada | a entrada por senha | credencial rejeitada | falha na entrada |
      | fator rejeitado | a confirmação de MFA | desafio rejeitado | falha na verificação |


  @USID_049 @front @contrato @criterio_do_plano @pagina
  @LLT86_C29 @planejado
  Esquema do Cenário: 29 Continuar utilizável diante de retorno inesperado - <exemplo>
    Dado que enviei uma tentativa sem autenticação completa confirmada
    Quando a fronteira consumida pela interface retorna <resposta>
    Então devo visualizar uma orientação geral de que não foi possível concluir a operação
    E devo poder tentar novamente sem carregamento indefinido
    E a interface deve continuar utilizável sem mostrar null ou undefined
    E nenhum sucesso ou acesso protegido deve ser liberado pela resposta

    Exemplos:
      | exemplo | resposta |
      | nulo | null |
      | vazio | corpo vazio onde é exigido conteúdo |
      | sem código | erro sem os campos obrigatórios para identificação |
      | sem mensagem | erro sem informação reconhecível pelo contrato |
      | desconhecido | código de erro desconhecido |
      | JSON inválido | conteúdo inválido para o JSON esperado |
      | HTML inesperado | HTML onde era esperada resposta estruturada |
      | 404 genérico | HTTP 404 sem explicação |
      | 500 genérico | HTTP 500 sem corpo |
      | 200 incompleto | HTTP 200 sem comprovação de autenticação exigida |


  @USID_049 @front @contrato @ADR_032 @pagina
  @LLT86_C30 @planejado
  Esquema do Cenário: 30 Tratar 401 do Core mesmo sem mensagem - <exemplo>
    Dado que uma chamada protegida do Front ao Core está em andamento
    Quando o Core responde HTTP 401 com <corpo>
    Então devo visualizar Você foi deslogado
    E devo retornar ao SignIn com o acesso local protegido encerrado
    E o tratamento não deve depender da descrição do erro no corpo

    Exemplos:
      | exemplo | corpo |
      | erro básico | erro básico |
      | corpo vazio | corpo vazio |
      | nulo | null |
      | sem descrição | objeto sem mensagem |


  @USID_049 @front @contrato @ADR_032 @pagina
  @LLT86_C31 @planejado
  Esquema do Cenário: 31 Tratar 403 sujeito à revogação de sessões - <exemplo>
    Dado que a operação está classificada pelo contrato como 403 com revogação da ADR_032
    Quando o Core responde HTTP 403 com <corpo>
    Então devo visualizar Você foi deslogado
    E devo retornar ao SignIn sem manter acesso local protegido
    E o teste deve distinguir esse resultado da negação simples da ADR_126

    Exemplos:
      | exemplo | corpo |
      | erro básico | erro básico |
      | corpo vazio | corpo vazio |


  @USID_049 @front @contrato @ADR_121 @ADR_126 @pagina
  @LLT86_C32 @planejado
  Esquema do Cenário: 32 Preservar sessão em negação simples de acesso - <exemplo>
    Dado que a conta está autenticada com sessão válida
    Quando o Core nega acesso porque <motivo> conforme o contrato de negação simples
    Então devo retornar à tela inicial e continuar logado
    E o recurso recusado não deve ser exibido
    E a interface não deve aplicar o logout global da ADR_032

    Exemplos:
      | exemplo | motivo |
      | não membro | a conta não é membro da empresa solicitada |
      | Produto incorreto | o Produto da URL é inválido ou de outra empresa |
      | sem AcessoProduto | o MEMBRO não possui acesso ao Produto |


  @USID_049 @front @contrato @ADR_034 @pagina
  @LLT86_C33 @planejado
  Esquema do Cenário: 33 Respeitar o bloqueio de tentativas da Clerk - <exemplo>
    Dado que o serviço indica <estado> para a conta fictícia
    Quando tento concluir a autenticação no componente
    Então devo visualizar <resultado>
    E o Front não deve implementar um limite paralelo nem desbloquear a conta por conta própria

    Exemplos:
      | exemplo | estado | resultado |
      | bloqueada | bloqueio ativo por tentativas | a orientação de bloqueio do provedor sem acesso protegido |
      | liberada pelo provedor | fim do bloqueio confirmado pelo provedor | possibilidade de tentar o login sem autenticação automática |


  @USID_049 @front @contrato @ADR_022 @ADR_026 @ADR_028 @ADR_141 @pagina
  @LLT86_C34 @planejado
  Esquema do Cenário: 34 Manter segredos de servidor fora do Front - <exemplo>
    Dado que inspeciono os arquivos públicos e respostas entregues ao navegador de teste
    Quando verifico a presença de <segredo>
    Então esse segredo não deve estar presente no conteúdo público
    E os componentes devem usar apenas a chave publicável e a sessão nos limites do contrato

    Exemplos:
      | exemplo | segredo |
      | chave secreta | CLERK_SECRET_KEY |
      | assinatura de webhook | CLERK_WEBHOOK_SIGNING_SECRET |
      | JWT entre serviços | credencial ou chave de assinatura do JWT interno |
