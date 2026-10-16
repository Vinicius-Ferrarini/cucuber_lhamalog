# language: pt
@LLT86
Funcionalidade: 1 Entrada no login

  @USID_049 @front @perfil_atual @ADR_023 @ADR_024 @ADR_123 @pagina
  @LLT86_C01 @planejado
  Esquema do Cenário: 01 Encaminhar após a primeira etapa - <exemplo>
    Dado que a conexão <entrada> está habilitada na instância de teste
    E a conta fictícia está <configuracao>
    Quando concluo a primeira etapa no componente SignIn
    Então devo visualizar <destino>
    E nenhum recurso protegido deve ser liberado antes de concluir as tarefas e o MFA exigidos

    Exemplos:
      | exemplo | entrada | configuracao | destino |
      | senha com fator | e-mail e senha | com TOTP cadastrado | o desafio de MFA |
      | primeiro cadastro de fator | e-mail e senha | sem fator cadastrado | a tarefa setup-mfa |
      | Google com fator | Google | com TOTP cadastrado | o desafio de MFA |
      | Google sem fator | Google | sem fator cadastrado | a tarefa setup-mfa |


  @USID_049 @front @perfil_atual @ADR_023 @ADR_032 @pagina
  @LLT86_C02 @planejado
  Cenário: 02 Recusar senha incorreta no SignIn
    Dado que uso uma conta fictícia existente no SignIn
    Quando a Clerk rejeita a senha informada
    Então o componente deve indicar a falha e permitir corrigir os dados
    E o Core não deve receber a senha nem uma solicitação própria para validá-la
    E nenhum acesso protegido deve ser liberado


  @USID_049 @front @perfil_atual @criterio_do_plano @pagina
  @LLT86_C03 @planejado
  Esquema do Cenário: 03 Validar campos antes do envio normal - <exemplo>
    Dado que estou no formulário do componente Clerk
    Quando tento enviar <entrada>
    Então devo visualizar <orientacao>
    E nenhuma solicitação de autenticação deve ser enviada enquanto os campos forem inválidos

    Exemplos:
      | exemplo | entrada | orientacao |
      | campos vazios | e-mail e senha vazios | a indicação dos campos obrigatórios |
      | sem senha | e-mail válido e senha vazia | a indicação de senha obrigatória |
      | sem e-mail | e-mail vazio e senha preenchida | a indicação de e-mail obrigatório |
      | formato inválido | email-sem-arroba e senha preenchida | a indicação de formato inválido |


  @USID_049 @front @perfil_atual @google_configurado @criterio_do_plano @pagina
  @LLT86_C04 @planejado
  Cenário: 04 Cancelar entrada pelo Google
    Dado que iniciei a conexão Google habilitada no SignIn
    Quando cancelo a autenticação e retorno ao aplicativo
    Então devo continuar sem autenticação completa
    E devo poder iniciar uma nova tentativa sem acesso protegido


  @USID_049 @front @perfil_atual @google_configurado @criterio_do_plano @pagina
  @LLT86_C05 @planejado
  Esquema do Cenário: 05 Tratar falha da autenticação externa - <exemplo>
    Dado que iniciei a conexão Google configurada
    Quando ocorre <falha>
    Então devo visualizar que a entrada não foi concluída
    E devo poder tentar novamente sem carregamento indefinido
    E a falha não deve criar acesso protegido

    Exemplos:
      | exemplo | falha |
      | Google recusa | rejeição do provedor |
      | retorno interrompido | falha no retorno ao aplicativo |
      | Clerk indisponível | indisponibilidade do serviço Clerk |
