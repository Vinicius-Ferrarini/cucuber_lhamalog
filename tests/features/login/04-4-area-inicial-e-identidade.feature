# language: pt
@LLT86
Funcionalidade: 4 Área inicial e identidade

  @USID_048 @USID_049 @front @perfil_atual @ADR_121 @ADR_122 @criterio_do_plano @pagina
  @LLT86_C15 @planejado
  Esquema do Cenário: 15 Mostrar somente os recursos retornados para a conta - <exemplo>
    Dado que concluí a autenticação e o Core retorna <recursos>
    Quando a área inicial termina de carregar
    Então devo visualizar <resultado>
    E a interface não deve inventar vínculos nem criar Empresa ou Produto por efetuar login

    Exemplos:
      | exemplo | recursos | resultado |
      | conta sem recursos | nenhuma empresa ou Produto acessível | o estado vazio da área inicial |
      | dono | os Produtos da Empresa Exemplo A para DONO | os recursos autorizados da Empresa Exemplo A |
      | membro | somente Produto Alfa permitido para MEMBRO | somente Produto Alfa |


  @USID_048 @USID_049 @front @perfil_atual @ADR_114 @ADR_121 @ADR_123 @pagina
  @LLT86_C16 @planejado
  Cenário: 16 Não exigir tela própria de convite no login
    Dado que um vínculo fictício foi criado pelo fluxo autorizado de convite no backend
    Quando autentico a conta correspondente na Clerk e carrego a área inicial
    Então os recursos apresentados devem corresponder ao vínculo devolvido pelo Core
    E o teste de login não deve depender de uma central própria de convites ou de uma notificação própria no aplicativo


  @USID_048 @USID_049 @front @perfil_atual @google_configurado @ADR_021 @pagina
  @LLT86_C17 @planejado
  Cenário: 17 Preservar a identidade resolvida pela Clerk
    Dado que a conta Google de teste está vinculada a uma identidade Clerk conhecida
    Quando concluo a autenticação e o MFA exigido
    Então devo visualizar os dados correspondentes ao clerkUserId autenticado
    E o Front não deve unir contas ou trocar vínculos por comparar apenas o texto do e-mail
