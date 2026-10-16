# language: pt
@LLT86
Funcionalidade: 2 MFA obrigatório e códigos de backup

  @USID_049 @USID_051 @front @perfil_atual @ADR_024 @ADR_123 @pagina
  @LLT86_C06 @planejado
  Esquema do Cenário: 06 Aceitar um fator disponível no perfil atual - <exemplo>
    Dado que a primeira etapa por <entrada> foi aceita
    E o método <metodo> está configurado na conta de teste
    Quando confirmo um valor fictício aceito pela Clerk
    Então a sessão deve concluir as tarefas exigidas e tornar-se ativa
    E devo chegar à área inicial do LhamaLog

    Exemplos:
      | exemplo | entrada | metodo |
      | senha e TOTP | e-mail e senha | TOTP |
      | senha e backup | e-mail e senha | código de backup |
      | Google e TOTP | Google habilitado | TOTP |
      | Google e backup | Google habilitado | código de backup |


  @USID_049 @USID_051 @front @perfil_atual @ADR_023 @criterio_do_plano @pagina
  @LLT86_C07 @planejado
  Esquema do Cenário: 07 Recusar verificação inválida - <exemplo>
    Dado que a primeira etapa foi aceita e aguardo <metodo>
    Quando tento confirmar <entrada>
    Então o componente deve indicar <orientacao>
    E nenhum recurso protegido deve ser liberado

    Exemplos:
      | exemplo | metodo | entrada | orientacao |
      | TOTP incorreto | TOTP | código rejeitado | falha na verificação |
      | TOTP vazio | TOTP | campo vazio | preenchimento obrigatório |
      | TOTP incompleto | TOTP | código incompleto conforme a configuração | correção do código |
      | TOTP expirado | TOTP | código expirado no serviço | falha na verificação |
      | backup rejeitado | código de backup | valor rejeitado | falha na verificação |
      | backup reutilizado | código de backup | valor já consumido no serviço | falha na verificação |
