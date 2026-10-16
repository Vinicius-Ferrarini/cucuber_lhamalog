# Testes de login e recuperação de acesso

**Atividade:** [LLT-86](https://logviewer2026.atlassian.net/browse/LLT-86) · **Versão:** 9 · **Data:** 15/10/2026

Plano BDD com exemplos orientados por dados para testar o Front Web integrado à Clerk. As regras deste plano seguem os ADRs vigentes da arquitetura, que têm prioridade sobre as referências de design.

São **47 cenários**, com 32 esquemas parametrizados e 15 cenários simples, totalizando **127 execuções especificadas**. O corpo principal contém 43 cenários do Front e da integração Web; o anexo reúne quatro verificações complementares de backend. São testes planejados, ainda não executados.

Todos os testes começam **não executados**, sem automação criada e com TDD desmarcado. Especificação escrita não significa código implementado, teste aprovado ou tarefa concluída.

## Como usar

As seções agrupam testes por assunto; não são etapas de um único fluxo. Cada cenário é independente, com preparação, ação e resultado esperado. Os cenários seguem a ordem de leitura, do 01 ao 47, incluindo o anexo.

1. Leia as regras vigentes e escolha o perfil de ambiente.
2. Comece pelo corpo principal do Front. Consulte o anexo para as verificações complementares de backend. Escolha o cenário pelo número, título e camada.
3. Execute cada linha de `Exemplos` como um teste independente.
4. No código sob responsabilidade do LhamaLog, escreva o teste antes da implementação e comprove **Red**: falha pelo comportamento ausente.
5. Implemente o necessário para **Green** e confira os testes relevantes.
6. Avalie **Refactor** e mantenha os testes passando. Se não houver alteração necessária, registre essa avaliação.
7. Registre resultado, ambiente, perfil, responsabilidade, exemplos, referência do teste e evidência.

Os blocos Gherkin usam português. Cucumber exige implementar os passos para executá-los. Este arquivo planeja os testes; não instala o framework nem executa autenticação real. O TDD cobre a integração e o código do LhamaLog; não representa desenvolvimento ou alteração do código interno da Clerk.

Para trabalhar com IA, fornecer as regras comuns, o perfil e o cenário completo com seus exemplos. Os testes de interface usam respostas controladas; testes reais de API e integração precisam de evidência própria.

## Regras vigentes e referências

- [ADR_021](https://docs.google.com/document/d/1I0jEaj5aD6kWrUnBqxj__U23nOqkJSFRoSqntvyPA9w/edit): A Clerk mantém usuários, credenciais, sessões e fatores. O LhamaLog mantém os dados de negócio e seus vínculos.
- [ADR_023](https://docs.google.com/document/d/1tLZvIwU-3To6BD7NqFwGdL-s8gyvEZI8wowiP9nCWWU/edit): Usar componentes prontos SignIn, SignUp e UserProfile, com personalização permitida; não construir autenticação própria a partir do Figma.
- [ADR_024](https://docs.google.com/document/d/14pbDhYPqqaljM0Lb_92sseTxFWwGTtbCtn_jG2hYd6Q/edit): MFA é obrigatório; conta sem fator cadastrado passa pela tarefa setup-mfa e não acessa recursos protegidos enquanto a sessão estiver pending.
- [ADR_123](https://docs.google.com/document/d/1C3ukxyHxFyL8H5qGMTYJgBFaz8TWTEYEPkDaTbn5Xdg/edit): O perfil atual adota Clerk Student para MFA, sem SMS incluído. Papéis de autorização ficam em Membro: DONO, ADMIN e MEMBRO; a Clerk usa Admin/Member.
- [ADR_025](https://docs.google.com/document/d/1OMX1A9bp_loIrNCdkeYdsmYjKCQaCuM6Y5vnxqbin2A/edit): O Mobile LhamaLog fica em standby e não é dependência do login Web nem canal obrigatório de recuperação.
- [ADR_034](https://docs.google.com/document/d/1I5W4SCjk8Ix0n4UV6Z0TozEy6Lpn4swtMuvmP-w2QY4/edit): Perda de todos os fatores exige reset por suporte autorizado. Account lockout é da Clerk; o plano não inventa um limite próprio nem torna um padrão externo uma configuração confirmada.
- [ADR_032](https://docs.google.com/document/d/1m_5y0BqS_KPWIwkMs9-AThB1wTRNr1-F1u7BnWt7jNg/edit): 401 do Core leva ao login com “Você foi deslogado”. O 403 sujeito a revogação exige que o backend encerre todas as sessões; o Front retorna ao login. A Clerk renova o token; o Core o valida nas requisições.
- [ADR_126](https://docs.google.com/document/d/1QRk3uGaZZTc_tM64PkaFodcEAQ7ruIr_9Oz4Htq8srk/edit): Não-membro, Produto errado/de outro tenant e MEMBRO sem AcessoProduto recebem negação simples: voltar à tela inicial mantendo a sessão.
- [ADR_121](https://docs.google.com/document/d/1D-M3nCYKSf2tgtKqEW6MrCZIqKT-fj7PPBf23nkpyzM/edit): Tenant é a empresa cliente, ligado à Organization, e nasce na compra da assinatura. Login e cadastro de identidade não criam automaticamente Tenant, assinatura ou Produto.
- [ADR_122](https://docs.google.com/document/d/1eVI3Yt_6dfXpv1c8ntY2MDRQc_kF2S4dr8TktO6cR2E/edit): O Core consulta Membro e AcessoProduto; DONO e ADMIN veem todos os Produtos da empresa. Autenticar não concede acesso a empresas ou Produtos arbitrários.
- [ADR_114](https://docs.google.com/document/d/1mxuzh6DiDrHSS_fg17fcNHqbCeRZ2T_DvvYd90YcE_w/edit): Convite e promoção são operações de backend, sem telas por enquanto. O teste de login usa os vínculos retornados pelo Core.
- [ADR_141](https://docs.google.com/document/d/1tsFBbpdq8JqGasM8EcNN6oIXaAAVOXlxa3nJkanQIks/edit): As chamadas de negócio do Front vão ao Core. Autenticação continua com a Clerk; JWT interno e segredos de servidor não são enviados ao navegador.

### Perfil do ambiente

| Perfil | Aplicação neste plano |
| --- | --- |
| `@perfil_atual` | Clerk Student adotado pelo ADR_123, com MFA obrigatório do ADR_024; TOTP e códigos de backup. Conferir a configuração real da instância antes da execução |
| `@google_configurado` | Casos Google só se a conexão estiver habilitada na instância usada; seguem a mesma exigência de MFA do perfil atual |

O perfil de execução usa Clerk Student com MFA obrigatório, TOTP e códigos de backup. SMS não integra este plano. O aplicativo autenticador TOTP é independente do aplicativo Mobile LhamaLog.

### Camadas e responsabilidades

| Identificação | Comprova | Verificação |
| --- | --- | --- |
| `@componente @front` | Estados e acessibilidade do componente ou adaptador do LhamaLog | Renderização isolada com dependências controladas; não substitui a verificação do SignIn real |
| `@pagina @front` | Tela, navegação, formulário e proteção das rotas | Página com estados e respostas simulados na fronteira Clerk SDK ou Core |
| `@front @contrato` | Comportamento do Front ao receber erro previsto ou retorno inesperado | Simulação na fronteira realmente consumida: Clerk SDK ou Core |
| `@api @clerk` | Recusa real do serviço de autenticação mesmo sem o formulário | Requisição direta à operação real da Clerk, com dados fictícios |
| `@api @core` | Validação de sessão e efeitos obrigatórios do backend LhamaLog | Requisições diretas ao Core em ambiente de teste |
| `@integracao` | Funcionamento real da conexão entre Front, Clerk e Core | Fluxo real com conta de teste e registro separado |

As tags `@componente`, `@pagina` e `@integracao` indicam onde obter a evidência. Os cenários atuais existentes de interface usam `@pagina`; o cenário 38 também tem uma verificação isolada de componente, sem duplicar a contagem de exemplos. Estados simulados comprovam o comportamento do código do LhamaLog, não o funcionamento interno da Clerk. Não simular um SignIn inteiramente falso e apresentar isso como prova do componente real. Conferir o componente embarcado nas integrações 41 e 42 e nas verificações manuais de teclado, leitura assistiva, foco e layout.

Os grupos de API estão no anexo e são verificações complementares do contrato usado pelo Front. Não criam um endpoint próprio de senha no Core e não transformam a LLT-86 numa implementação completa de backend. Senha, código e recuperação são tratados pela Clerk; o Core recebe e valida a sessão.

### Contrato e limites de cobertura

- Identificar a operação real, a versão do SDK, a configuração do ambiente e o contrato usados antes de automatizar. Não inventar endpoints de login, nomes de campos de erro, prazos ou formatos de código.
- Reconhecer erros por código/tipo documentado, sem depender de uma frase literal, exceto pela mensagem definida no ADR_032: “Você foi deslogado”.
- `null` como entrada, campo ausente, texto vazio e tipo incorreto são testes diferentes. `null` como resposta é uma falha na comunicação, não prova de e-mail inválido.
- Sem causa reconhecida, mostrar orientação geral; nunca exibir `null`/`undefined`, travar, manter carregamento indefinido ou considerar a resposta uma autenticação válida.
- Erro de senha ou fator no `SignIn` não equivale a 401 do Core. Negação simples da ADR_126 não equivale ao 403 que revoga sessões da ADR_032. Nas rotas de papéis, a ADR_139 também prevê 403 de negação simples. O tratamento usa o contrato da operação; o status isolado não autoriza revogar sessões indiscriminadamente.
- Recuperação de senha usa o fluxo exposto pela Clerk. Usar as opções disponibilizadas pelo componente no ambiente de teste.
- Recuperação de MFA sem fator alternativo exige suporte autorizado. O teste usa uma fixture de reset já autorizado e verifica o novo cadastro de fator, sem executar o procedimento de autorização do suporte.
- A aparência do Figma orienta o entorno e a personalização permitida. Não exigir tela própria, seis caixas, contador fixo ou texto que contradiga o componente prebuilt.
- Permissões completas, compras, convites, criação de projetos e administração de papéis continuam em seus planos. Aqui entram apenas regressões de sessão e da chegada à área inicial. Papel de notificação não define permissão de login (ADR_138).

### Dados e preparação comuns

| Fixture | Preparação |
| --- | --- |
| Ana Exemplo | `ana.login@example.com`; conta fictícia na Clerk; variantes sem fator cadastrado, TOTP cadastrado, backup disponível e conta bloqueada |
| Bruno Exemplo | `bruno.login@example.com`; outra identidade para conferir vínculos e impedir troca de conta |
| Dispositivos | Navegadores isolados para contexto conhecido, novo dispositivo e duas sessões da mesma conta |
| Empresa e Produto | Empresa Exemplo A/Produto Alfa e Empresa Exemplo B/Produto Beta; vínculos e permissões fornecidos pelo Core |
| Recuperação | Conta com e-mail de teste verificado e fluxo de recuperação habilitado pela Clerk; valores aceitos, rejeitados e expirados controlados |
| Tokens e códigos | Fixtures ou referências protegidas no ambiente; nunca incluir senhas, códigos utilizáveis, tokens, credenciais ou logs reais no arquivo ou evidências |

Usar ambiente isolado. Cada cenário começa em estado próprio; não depende da execução de outro. Para testes reais de entrega, usar destinos de teste sob controle da equipe. Nenhum envio nem alteração de configuração foi realizado durante a revisão deste plano.

### Critérios complementares do Front

Os cenários 35 a 40 verificam critérios de qualidade da interface definidos neste plano: carregamento, falha de inicialização, teclado, nomes acessíveis, foco e adaptação da tela. Esses critérios complementam os ADRs e não representam uma certificação completa de acessibilidade. Usar o componente Clerk real nas verificações visuais e assistivas; correções podem envolver a integração, a configuração permitida ou uma limitação documentada do provedor, sem criar autenticação paralela.

Os tamanhos e o zoom abaixo são amostras de teste, não novos breakpoints obrigatórios do produto. Registrar navegador, viewport, zoom e tecnologia assistiva na evidência. A sessão, os vínculos de Empresa e os Produtos permanecem os mesmos ao mudar apresentação ou método de entrada.

## 1 Entrada no login

```gherkin
# language: pt
Funcionalidade: 1 Entrada no login

  @USID_049 @front @perfil_atual @ADR_023 @ADR_024 @ADR_123 @pagina
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
  Cenário: 02 Recusar senha incorreta no SignIn
    Dado que uso uma conta fictícia existente no SignIn
    Quando a Clerk rejeita a senha informada
    Então o componente deve indicar a falha e permitir corrigir os dados
    E o Core não deve receber a senha nem uma solicitação própria para validá-la
    E nenhum acesso protegido deve ser liberado


  @USID_049 @front @perfil_atual @criterio_do_plano @pagina
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
  Cenário: 04 Cancelar entrada pelo Google
    Dado que iniciei a conexão Google habilitada no SignIn
    Quando cancelo a autenticação e retorno ao aplicativo
    Então devo continuar sem autenticação completa
    E devo poder iniciar uma nova tentativa sem acesso protegido


  @USID_049 @front @perfil_atual @google_configurado @criterio_do_plano @pagina
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

```

## 2 MFA obrigatório e códigos de backup

```gherkin
# language: pt
Funcionalidade: 2 MFA obrigatório e códigos de backup

  @USID_049 @USID_051 @front @perfil_atual @ADR_024 @ADR_123 @pagina
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

```

## 3 Processamento e proteção da sessão

```gherkin
# language: pt
Funcionalidade: 3 Processamento e proteção da sessão

  @USID_049 @front @perfil_atual @ADR_024 @pagina
  Cenário: 08 Cancelar a verificação obrigatória
    Dado que aguardo a verificação de MFA ou a tarefa setup-mfa
    Quando cancelo o fluxo do componente
    Então não devo obter acesso protegido
    E devo poder retomar a autenticação pelo SignIn


  @USID_049 @front @perfil_atual @criterio_do_plano @pagina
  Esquema do Cenário: 09 Evitar envio repetido na interface - <exemplo>
    Dado que uma solicitação de <etapa> está em andamento
    Quando repito a ação de confirmação antes da resposta
    Então a interface deve manter uma única tentativa em andamento para essa ação
    E não deve repetir navegação ou confirmação de sucesso

    Exemplos:
      | exemplo | etapa |
      | login | primeira etapa |
      | MFA | verificação TOTP |


  @USID_049 @front @perfil_atual @criterio_do_plano @pagina
  Esquema do Cenário: 10 Recuperar a interface após falha de conexão - <exemplo>
    Dado que aguardo resposta de <etapa>
    Quando a comunicação falha
    Então devo visualizar uma indicação de falha sem carregamento indefinido
    E devo poder tentar novamente
    E a falha não deve concluir a autenticação

    Exemplos:
      | exemplo | etapa |
      | sem rede | primeira etapa |
      | falha no fator | MFA |


  @USID_049 @front @perfil_atual @ADR_023 @ADR_024 @pagina
  Esquema do Cenário: 11 Bloquear navegação antes de concluir autenticação - <exemplo>
    Dado que estou <estado>
    Quando tento abrir um recurso protegido por <navegacao>
    Então não devo visualizar seu conteúdo
    E devo ser encaminhado ao fluxo Clerk adequado ao estado da conta

    Exemplos:
      | exemplo | estado | navegacao |
      | sem sessão | sem sessão | endereço direto |
      | reload antes de MFA | com primeira etapa aceita e MFA não concluído | atualização da página |
      | voltar antes de MFA | com primeira etapa aceita e MFA não concluído | voltar do navegador |
      | setup incompleto | com tarefa setup-mfa não concluída | endereço direto |


  @USID_049 @front @perfil_atual @ADR_023 @ADR_032 @pagina
  Cenário: 12 Recarregar com sessão ativa
    Dado que minha sessão Clerk está ativa e as tarefas estão concluídas
    Quando atualizo a área inicial
    Então devo permanecer na conta correta após o carregamento do provedor
    E a atualização não deve exigir um novo login enquanto a sessão continuar válida


  @USID_049 @front @perfil_atual @ADR_032 @pagina
  Esquema do Cenário: 13 Interromper navegação após sessão inválida - <exemplo>
    Dado que a sessão da conta se torna <estado>
    Quando a interface detecta a perda da sessão
    Então o conteúdo protegido deve deixar de ser apresentado
    E devo ser encaminhado ao SignIn sem restaurar acesso pelo histórico

    Exemplos:
      | exemplo | estado |
      | expirada | expirada |
      | revogada | revogada |


  @USID_049 @front @perfil_atual @ADR_023 @pagina
  Esquema do Cenário: 14 Não restaurar sessão depois de sair - <exemplo>
    Dado que encerrei a sessão pelo componente Clerk
    Quando tento retornar usando <navegacao>
    Então não devo recuperar a sessão encerrada
    E o conteúdo protegido deve continuar indisponível

    Exemplos:
      | exemplo | navegacao |
      | histórico | voltar do navegador |
      | rota direta | endereço protegido direto |

```

## 4 Área inicial e identidade

```gherkin
# language: pt
Funcionalidade: 4 Área inicial e identidade

  @USID_048 @USID_049 @front @perfil_atual @ADR_121 @ADR_122 @criterio_do_plano @pagina
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
  Cenário: 16 Não exigir tela própria de convite no login
    Dado que um vínculo fictício foi criado pelo fluxo autorizado de convite no backend
    Quando autentico a conta correspondente na Clerk e carrego a área inicial
    Então os recursos apresentados devem corresponder ao vínculo devolvido pelo Core
    E o teste de login não deve depender de uma central própria de convites ou de uma notificação própria no aplicativo


  @USID_048 @USID_049 @front @perfil_atual @google_configurado @ADR_021 @pagina
  Cenário: 17 Preservar a identidade resolvida pela Clerk
    Dado que a conta Google de teste está vinculada a uma identidade Clerk conhecida
    Quando concluo a autenticação e o MFA exigido
    Então devo visualizar os dados correspondentes ao clerkUserId autenticado
    E o Front não deve unir contas ou trocar vínculos por comparar apenas o texto do e-mail

```

## 5 Recuperação de senha e de MFA

```gherkin
# language: pt
Funcionalidade: 5 Recuperação de senha e de MFA

  @USID_049 @front @perfil_atual @ADR_021 @ADR_023 @pagina
  Cenário: 18 Usar a recuperação disponível no componente
    Dado que a conta possui um fluxo de recuperação de senha habilitado pela Clerk
    Quando abro a recuperação no SignIn
    Então devo visualizar as opções suportadas e configuradas pelo provedor
    E não deve ser exigida uma lista própria de todos os contatos ou confirmação pelo Mobile LhamaLog


  @USID_049 @front @perfil_atual @ADR_021 @ADR_024 @criterio_do_plano @pagina
  Cenário: 19 Recuperar senha sem remover o MFA
    Dado que iniciei a recuperação de senha da conta fictícia com MFA obrigatório
    Quando concluo a comprovação aceita pela Clerk e defino uma nova senha fictícia no ambiente de teste
    Então a senha antiga deve ser rejeitada na tentativa seguinte
    E a nova senha deve ser aceita como primeira etapa
    E o MFA ou a tarefa setup-mfa exigida deve continuar sendo respeitado antes do acesso protegido


  @USID_049 @front @perfil_atual @criterio_do_plano @pagina
  Cenário: 20 Não enviar recuperação a um destino arbitrário
    Dado que a recuperação da Clerk usa o e-mail verificado da conta fictícia
    Quando tento indicar um destino diferente sem comprovar o vínculo com essa conta
    Então a interface não deve permitir recuperar a conta por esse destino arbitrário
    E o teste não deve exigir disparo para telefone ou Mobile não suportados pelo fluxo configurado


  @USID_049 @front @perfil_atual @ADR_023 @criterio_do_plano @pagina
  Esquema do Cenário: 21 Recusar comprovação inválida na recuperação - <exemplo>
    Dado que iniciei a recuperação de senha no componente Clerk
    Quando envio <comprovacao>
    Então devo visualizar a rejeição ou a orientação de recuperação fornecida pelo componente
    E a senha não deve ser alterada por essa tentativa

    Exemplos:
      | exemplo | comprovacao |
      | rejeitada | comprovação fictícia rejeitada |
      | expirada | comprovação fictícia expirada no serviço |


  @USID_049 @front @perfil_atual @USID_051 @ADR_024 @ADR_034 @pagina
  Cenário: 22 Exigir novo cadastro de MFA após reset autorizado
    Dado que a fixture registra um reset de MFA já autorizado e concluído pelo suporte
    E a exigência de MFA está ligada na Clerk
    Quando a conta inicia o próximo login
    Então devo visualizar a tarefa setup-mfa
    E nenhum recurso protegido deve ser liberado antes de concluir o novo cadastro


  @USID_049 @front @perfil_atual @USID_051 @ADR_024 @ADR_034 @pagina
  Cenário: 23 Não oferecer reset autônomo de MFA sem fator
    Dado que a conta perdeu seus fatores e códigos de backup
    Quando tenta prosseguir no login sem concluir a verificação
    Então o acesso protegido deve permanecer bloqueado
    E o Front não deve remover o MFA nem inventar recuperação automática por e-mail SMS ou Mobile
    E o reset deve permanecer restrito ao processo de suporte autorizado

```

## 6 Configuração do MFA pela Clerk

```gherkin
# language: pt
Funcionalidade: 6 Configuração do MFA pela Clerk

  @USID_051 @front @perfil_atual @ADR_023 @ADR_024 @ADR_123 @pagina
  Cenário: 24 Cadastrar fator exigido e disponibilizar backup
    Dado que a conta está na tarefa setup-mfa sem acesso protegido
    Quando concluo o cadastro de TOTP aceito pela Clerk
    Então a tarefa deve ser concluída conforme o provedor
    E os códigos de backup devem estar disponíveis pelo fluxo de segurança da Clerk
    E o próximo login deve respeitar a exigência de MFA


  @USID_051 @front @perfil_atual @ADR_024 @pagina
  Cenário: 25 Cancelar setup sem liberar acesso
    Dado que preciso cadastrar MFA e a sessão está pending
    Quando cancelo o cadastro antes da confirmação
    Então a sessão não deve ser tratada como ativa pelo LhamaLog
    E o próximo acesso deve continuar exigindo a tarefa setup-mfa


  @USID_051 @front @perfil_atual @ADR_023 @ADR_024 @pagina
  Cenário: 26 Manter fatores usando UserProfile
    Dado que a conta está autenticada e usa o UserProfile da Clerk
    Quando conclui uma alteração de fator aceita pelo provedor
    Então o estado exibido deve corresponder aos fatores confirmados pela Clerk
    E o Front não deve manter cadastro paralelo de MFA próprio


  @USID_051 @front @perfil_atual @ADR_023 @criterio_do_plano @pagina
  Esquema do Cenário: 27 Não anunciar alteração de fator não concluída - <exemplo>
    Dado que iniciei uma alteração de fator no UserProfile
    Quando a operação é <resultado>
    Então não devo visualizar confirmação de alteração concluída
    E o estado apresentado deve corresponder ao que foi efetivamente confirmado pela Clerk

    Exemplos:
      | exemplo | resultado |
      | cancelada | cancelada antes de confirmar |
      | rejeitada | rejeitada pelo provedor |

```

## 7 Respostas e proteção do Front

```gherkin
# language: pt
Funcionalidade: 7 Respostas e proteção do Front

  @USID_049 @front @contrato @criterio_do_plano @pagina
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

```

Simular erros na fronteira efetivamente consumida. Mensagem opcional ausente com código reconhecido continua sendo erro conhecido; representar falhas HTTP na forma exposta pelo SDK ou pela API. O 403 de negação simples da ADR_126 ou das rotas da ADR_139 não dispara logout global: usar o contrato da operação. O cenário 34 inspeciona o artefato e as respostas públicos do Front; comprovar ausência do valor secreto, não apenas do nome da variável.

## 8 Carregamento acessibilidade e adaptação da tela

```gherkin
# language: pt
Funcionalidade: 8 Carregamento acessibilidade e adaptação da tela

  @USID_049 @front @pagina @perfil_atual @criterio_front
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

```

No cenário 38, executar a checagem isolada nos componentes/adaptadores do LhamaLog e confirmar os quatro exemplos na página com o componente real. O resultado isolado não aprova acessibilidade do provedor. Nos cenários 37 a 40, combinar inspeção automatizada com verificação manual no navegador e registrar as condições usadas.

## 9 Integração real do login Web

Usar a Clerk real de teste, a página com o componente embarcado e o Core de teste. Registrar versões e configuração sem segredos. Uma simulação de resposta não substitui esta evidência. Conferir também teclado, foco, leitura assistiva e layout dos cenários 37 a 40 no componente real.

```gherkin
# language: pt
Funcionalidade: 9 Integração real do login Web

  @USID_049 @integracao @perfil_atual @ADR_023 @ADR_024 @ADR_123
  Esquema do Cenário: 41 Interpretar a autenticação real com MFA obrigatório - <exemplo>
    Dado que a Clerk real de teste usa o perfil atual com MFA obrigatório
    Quando realizo <tentativa>
    Então devo visualizar <destino>
    E o estado real da sessão deve corresponder a <sessao>
    E a evidência deve identificar a integração sem incluir segredos

    Exemplos:
      | exemplo | tentativa | destino | sessao |
      | conta sem fator | primeira etapa por senha em conta sem fator | setup-mfa | sessão ainda não ativa |
      | conta com fator | primeira etapa por senha em conta com TOTP | desafio de MFA | autenticação ainda incompleta |
      | MFA concluído | senha e TOTP aceitos | área inicial | sessão ativa |
      | Google e MFA | Google habilitado e TOTP aceitos | área inicial | sessão ativa |
      | senha rejeitada | senha rejeitada pela Clerk | falha no SignIn | nenhuma autenticação concluída |


  @USID_049 @integracao @ADR_022 @ADR_025 @ADR_028 @ADR_032
  Esquema do Cenário: 42 Renovar sessão sem criar token de usuário próprio - <exemplo>
    Dado que a conta possui sessão Clerk ativa
    Quando a renovação do session token <resultado>
    Então devo observar <efeito>
    E o Core não deve emitir um session token próprio para substituir o da Clerk
    E JWTs internos de serviço não devem ser entregues ao navegador

    Exemplos:
      | exemplo | resultado | efeito |
      | aceita | é aceita e o Core valida o token renovado | continuidade da sessão sem novo login |
      | recusada | falha por revogação da sessão | encerramento do acesso e retorno ao SignIn |


  @USID_049 @integracao @ADR_022 @ADR_023 @ADR_141
  Esquema do Cenário: 43 Enviar sessão ao Core pelo transporte correto - <exemplo>
    Dado que o Front chama uma API de negócio do Core em <origem>
    Quando a conta autenticada faz a requisição
    Então a sessão Clerk deve chegar por <transporte>
    E o Core deve validar a sessão antes de devolver dados protegidos
    E a requisição não deve conter senha nem JWT interno de serviço

    Exemplos:
      | exemplo | origem | transporte |
      | mesma origem | mesma origem | cookie de sessão |
      | outra origem | origem diferente | Authorization Bearer com token obtido pelo SDK |

```

## Anexo Verificações complementares de backend

Estes casos validam o serviço real e os efeitos no backend. São dependências complementares para coordenar com a equipe de backend; sua presença não transfere essa implementação para a LLT-86. Um teste da página com resposta simulada não comprova estes resultados. Nos casos do provedor, registrar verificação de contrato; não declarar Red ou refatoração do código interno da Clerk.

```gherkin
# language: pt
Funcionalidade: Anexo Verificações complementares de backend

  @USID_049 @api @clerk @criterio_do_plano
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
  Cenário: 46 Revogar todas as sessões no 403 aplicável
    Dado que uma conta fictícia possui duas sessões ativas na Clerk
    E a operação de teste aplica o 403 com revogação definido na ADR_032
    Quando o Core recusa o acesso por esse contrato
    Então deve responder 403 e revogar todas as sessões ativas dessa conta na Clerk
    E o teste deve comprovar a revogação no provedor
    E a renovação seguinte dessas sessões deve falhar sem restaurar o acesso


  @USID_049 @api @core @ADR_121 @ADR_122
  Esquema do Cenário: 47 Não criar Tenant somente por autenticar identidade - <exemplo>
    Dado que a conta fictícia não efetuou compra de assinatura nem possui vínculo com empresa existente
    Quando ocorre <evento>
    Então esse evento isolado não deve criar Tenant Assinatura Organization ou Produto de negócio
    E a identidade deve continuar separada dos recursos de negócio

    Exemplos:
      | exemplo | evento |
      | cadastro de identidade | cadastro da identidade na Clerk |
      | novo login | novo login da mesma identidade |

```

No cenário 46, respeitar a janela até a expiração do JWT emitido descrita na ADR_032; comprovar revogação e falha da renovação, sem exigir invalidação instantânea de todo JWT. O cenário 47 não contém compra nem convite e não impede sincronizar a identidade ou manter vínculos anteriores.

## Rastreabilidade dos requisitos

| Origem | Cobertura neste plano |
| --- | --- |
| USID_049 | Entrada, sessão e recuperação de acesso no Web |
| USID_051 | MFA e recuperação de acesso pela Clerk |
| USID_048 | Identidade e chegada à área inicial; administração de usuários está fora deste plano de login |
| USID_050 | Sem execução no Mobile LhamaLog, conforme ADR_025 |

## Acompanhamento de implementação

Marcar somente após obter a evidência da etapa. Para verificações externas do provedor, registrar resultado de contrato; Red e Refactor podem ser Não aplicável com justificativa. O anexo tem registro separado do aceite do Front.

### Acompanhamento 1 Entrada no login

### Cenário 01 — Encaminhar após a primeira etapa

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 02 — Recusar senha incorreta no SignIn

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 03 — Validar campos antes do envio normal

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 04 — Cancelar entrada pelo Google

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 05 — Tratar falha da autenticação externa

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Acompanhamento 2 MFA obrigatório e códigos de backup

### Cenário 06 — Aceitar um fator disponível no perfil atual

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 07 — Recusar verificação inválida

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Acompanhamento 3 Processamento e proteção da sessão

### Cenário 08 — Cancelar a verificação obrigatória

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 09 — Evitar envio repetido na interface

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 10 — Recuperar a interface após falha de conexão

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 11 — Bloquear navegação antes de concluir autenticação

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 12 — Recarregar com sessão ativa

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 13 — Interromper navegação após sessão inválida

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 14 — Não restaurar sessão depois de sair

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Acompanhamento 4 Área inicial e identidade

### Cenário 15 — Mostrar somente os recursos retornados para a conta

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 16 — Não exigir tela própria de convite no login

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 17 — Preservar a identidade resolvida pela Clerk

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Acompanhamento 5 Recuperação de senha e de MFA

### Cenário 18 — Usar a recuperação disponível no componente

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 19 — Recuperar senha sem remover o MFA

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 20 — Não enviar recuperação a um destino arbitrário

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 21 — Recusar comprovação inválida na recuperação

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 22 — Exigir novo cadastro de MFA após reset autorizado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 23 — Não oferecer reset autônomo de MFA sem fator

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Acompanhamento 6 Configuração do MFA pela Clerk

### Cenário 24 — Cadastrar fator exigido e disponibilizar backup

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 25 — Cancelar setup sem liberar acesso

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 26 — Manter fatores usando UserProfile

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 27 — Não anunciar alteração de fator não concluída

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Acompanhamento 7 Respostas e proteção do Front

### Cenário 28 — Apresentar erro reconhecido da Clerk

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 29 — Continuar utilizável diante de retorno inesperado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 30 — Tratar 401 do Core mesmo sem mensagem

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 31 — Tratar 403 sujeito à revogação de sessões

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 32 — Preservar sessão em negação simples de acesso

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 33 — Respeitar o bloqueio de tentativas da Clerk

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 34 — Manter segredos de servidor fora do Front

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Acompanhamento 8 Carregamento acessibilidade e adaptação da tela

### Cenário 35 — Aguardar a resolução inicial da sessão

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 36 — Tratar falha ao inicializar a autenticação

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 37 — Operar o fluxo somente pelo teclado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 38 — Identificar controles e erros por tecnologia assistiva

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 39 — Manter o foco útil após mudanças de estado

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 40 — Usar a autenticação com largura reduzida e zoom

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Acompanhamento 9 Integração real do login Web

### Cenário 41 — Interpretar a autenticação real com MFA obrigatório

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 42 — Renovar sessão sem criar token de usuário próprio

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 43 — Enviar sessão ao Core pelo transporte correto

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Acompanhamento Anexo Verificações complementares de backend

### Cenário 44 — Rejeitar entrada inválida sem passar pelo formulário

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 45 — Recusar sessão inválida diretamente no Core

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 46 — Revogar todas as sessões no 403 aplicável

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Cenário 47 — Não criar Tenant somente por autenticar identidade

- [ ] Teste criado
- [ ] Red comprovado
- [ ] Green comprovado
- [ ] Refactor avaliado e testes conferidos

### Registro de execução e evidências

Copie o registro para cada cenário/exemplo, camada e execução. Os resultados possíveis são **Passou**, **Falhou** ou **Não aplicável** com justificativa. Não executado é o estado inicial de todos. Evidências simuladas e reais não se substituem.

- Cenário e exemplo: PREENCHER
- Camada e responsabilidade: PREENCHER componente, página, API ou integração
- Ambiente e perfil: PREENCHER
- Resposta simulada ou real: PREENCHER
- Navegador viewport zoom e tecnologia assistiva: PREENCHER ou Não aplicável com justificativa
- Etapa: PREENCHER Red, Green, Refactor ou verificação de contrato
- Teste automatizado: PREENCHER link ou caminho, ou Não existe
- Resultado: PREENCHER após executar
- Evidência e contrato: PREENCHER referência sem segredos
- OBS: PREENCHER observação ou Sem observações

### Critérios de aceite do planejamento

- [ ] Conferi os cenários e sua correspondência com os ADRs vigentes
- [ ] Conferi os critérios de interface, as camadas de teste e os contratos utilizados
- [ ] Registrei a correspondência com o design da LLT-46 respeitando os componentes prebuilt
- [ ] Registrei a revisão exigida nos critérios da atividade no Jira

**Registro da revisão:** PREENCHER data, responsável e referência. **OBS:** Sem observações ou ajustes identificados.

A revisão do plano não comprova aprovação formal nem conclusão da LLT-86. A administração de usuários e o plano completo de autorização estão fora deste recorte de login. Testes complementares de API não devem ser declarados implementados apenas por constarem no Markdown.

## Referências

- [Pasta oficial dos ADRs — fonte prioritária](https://drive.google.com/drive/folders/1SsRGM7_f7WD8L0O4GnozbosImt8zReTs)
- [Índice local dos 147 ADRs consultados](../fontes-adr/INDICE-ADRS.md)
- [Documento 86 no Drive](https://docs.google.com/document/d/1W4dsdN3F6DSZo3ZSR_9TGUqEb7kDmHgO65C_Gd-EV6k/edit)
- [Modelo da LLT-83](https://docs.google.com/document/d/1ViQWy2JQV8QrvdRj3Iz3gRgJnkq9XBBOQD2tkvrthRY/edit)
- [LLT-46 e referência de design](https://logviewer2026.atlassian.net/browse/LLT-46)
- [Casos de uso de origem](https://docs.google.com/spreadsheets/d/1JObvNfZAJvCPjG4urP4OZKHVhKFNyCeVq1w2w8agRb0/edit)
- [Figma Login](https://www.figma.com/design/e88SaMez3hQZ0nmmC3uEtm/LhamaLog?node-id=422-4632)
- [Referência de Gherkin](https://cucumber.io/docs/gherkin/reference/)

### ADRs de referência

- [ADR_021](https://docs.google.com/document/d/1I0jEaj5aD6kWrUnBqxj__U23nOqkJSFRoSqntvyPA9w/edit) — [ADR_021] - Clerk como provedor de identidade e autenticação
- [ADR_022](https://docs.google.com/document/d/1_gIzS6-0aLOHBbBAtLEPtP7jWO5kiTagqn1r9GgqxxQ/edit) — [ADR_022] - Integração do backend Java com a Clerk
- [ADR_023](https://docs.google.com/document/d/1tLZvIwU-3To6BD7NqFwGdL-s8gyvEZI8wowiP9nCWWU/edit) — [ADR_023] - Componentes de front-end da Clerk
- [ADR_024](https://docs.google.com/document/d/14pbDhYPqqaljM0Lb_92sseTxFWwGTtbCtn_jG2hYd6Q/edit) — [ADR_024] - MFA obrigatório no login via Clerk
- [ADR_025](https://docs.google.com/document/d/1OMX1A9bp_loIrNCdkeYdsmYjKCQaCuM6Y5vnxqbin2A/edit) — [ADR_025] - Gestão de tokens internos e app móvel em standby
- [ADR_026](https://docs.google.com/document/d/1nLp6ItIT8ZgmaBFvn3fyMpr4SP7DWQVvNygjhs2IuxU/edit) — [ADR_026] - Backend Java com SDK oficial da Clerk e front-end em React
- [ADR_028](https://docs.google.com/document/d/1xJSvxvHGgRrC5wxJTDISyxN5onMbNnW8_6GCe7KRVCw/edit) — [ADR_028] - Tokens internos próprios, sem M2M nem API keys da Clerk
- [ADR_032](https://docs.google.com/document/d/1m_5y0BqS_KPWIwkMs9-AThB1wTRNr1-F1u7BnWt7jNg/edit) — [ADR_032] - Tratamento de erros 401/403 e renovação da sessão
- [ADR_034](https://docs.google.com/document/d/1I5W4SCjk8Ix0n4UV6Z0TozEy6Lpn4swtMuvmP-w2QY4/edit) — [ADR_034] - Ferramentas de suporte: revogação de sessões, reset de MFA e acesso remoto por token único
- [ADR_114](https://docs.google.com/document/d/1mxuzh6DiDrHSS_fg17fcNHqbCeRZ2T_DvvYd90YcE_w/edit) — [ADR_114] - Convite de membros e promoção a administrador (só backend)
- [ADR_121](https://docs.google.com/document/d/1D-M3nCYKSf2tgtKqEW6MrCZIqKT-fj7PPBf23nkpyzM/edit) — [ADR_121] - Modelo multi-tenant SaaS pool com tenant = empresa cliente (substitui a ADR_105)
- [ADR_122](https://docs.google.com/document/d/1eVI3Yt_6dfXpv1c8ntY2MDRQc_kF2S4dr8TktO6cR2E/edit) — [ADR_122] - Coleções do modelo multi-tenant
- [ADR_123](https://docs.google.com/document/d/1C3ukxyHxFyL8H5qGMTYJgBFaz8TWTEYEPkDaTbn5Xdg/edit) — [ADR_123] - Clerk Organizations gratuitas e papéis na coleção Membro
- [ADR_126](https://docs.google.com/document/d/1QRk3uGaZZTc_tM64PkaFodcEAQ7ruIr_9Oz4Htq8srk/edit) — [ADR_126] - Negação simples para não-membro ou Produto errado na URL
- [ADR_138](https://docs.google.com/document/d/1JHr3h1HQSP8fFQGnkc_fXwpEHfJKAKD9IQVKh9vqv_4/edit) — [ADR_138] - Exclusão de papel de notificação
- [ADR_139](https://docs.google.com/document/d/1a29dv9t_0HNnpT2z49L1aVrvl_BT4HqBUVehFlvxluU/edit) — [ADR_139] - Negação simples nas rotas de papéis
- [ADR_141](https://docs.google.com/document/d/1tsFBbpdq8JqGasM8EcNN6oIXaAAVOXlxa3nJkanQIks/edit) — [ADR_141] - Segmentação de rede dos módulos
