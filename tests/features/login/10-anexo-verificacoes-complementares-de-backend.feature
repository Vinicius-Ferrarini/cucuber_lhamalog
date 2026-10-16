# language: pt
@LLT86
Funcionalidade: Anexo Verificações complementares de backend

  @USID_049 @api @clerk @criterio_do_plano
  @LLT86_C44 @planejado
  Esquema do Cenário: 44 Rejeitar entrada inválida sem passar pelo formulário - <exemplo>
    Dado que identifiquei a operação real de autenticação da Clerk e seu contrato
    Quando envio diretamente uma requisição com o e-mail <entrada>
    Então a Clerk deve rejeitar a solicitação conforme o contrato
    E nenhuma autenticação completa deve resultar dessa solicitação
    E o teste não deve enviar senha a um endpoint próprio do Core

    Exemplos:
      | exemplo | entrada |
      | formato inválido | texto email-sem-arroba |
      | campo ausente | ausente do corpo |
      | valor nulo | null |
      | texto vazio | texto vazio |
      | tipo incorreto | objeto no lugar do texto exigido |


  @USID_049 @api @core @ADR_022 @ADR_024 @ADR_032
  @LLT86_C45 @planejado
  Esquema do Cenário: 45 Recusar sessão inválida diretamente no Core - <exemplo>
    Dado que a requisição usa uma operação protegida real do Core
    Quando envio uma fixture de sessão <estado> sem passar pelo Front
    Então o Core deve responder 401 sem devolver o conteúdo protegido
    E não deve tratar a solicitação como autenticação válida

    Exemplos:
      | exemplo | estado |
      | sem token | sem token |
      | assinatura inválida | com assinatura inválida |
      | expirada | com exp vencido |
      | ainda não válida | com nbf no futuro |
      | origem recusada | com azp fora das origens permitidas |
      | setup incompleto | com sts igual a pending |


  @USID_049 @api @core @integracao @ADR_032 @ADR_034
  @LLT86_C46 @planejado
  Cenário: 46 Revogar todas as sessões no 403 aplicável
    Dado que uma conta fictícia possui duas sessões ativas na Clerk
    E a operação de teste aplica o 403 com revogação definido na ADR_032
    Quando o Core recusa o acesso por esse contrato
    Então deve responder 403 e revogar todas as sessões ativas dessa conta na Clerk
    E o teste deve comprovar a revogação no provedor
    E a renovação seguinte dessas sessões deve falhar sem restaurar o acesso


  @USID_049 @api @core @ADR_121 @ADR_122
  @LLT86_C47 @planejado
  Esquema do Cenário: 47 Não criar Tenant somente por autenticar identidade - <exemplo>
    Dado que a conta fictícia não efetuou compra de assinatura nem possui vínculo com empresa existente
    Quando ocorre <evento>
    Então esse evento isolado não deve criar Tenant Assinatura Organization ou Produto de negócio
    E a identidade deve continuar separada dos recursos de negócio

    Exemplos:
      | exemplo | evento |
      | cadastro de identidade | cadastro da identidade na Clerk |
      | novo login | novo login da mesma identidade |
