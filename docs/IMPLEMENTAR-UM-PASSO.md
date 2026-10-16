# Como conectar um passo ao projeto

1. Localize o ID do cenário em COBERTURA.md e abra seu .feature.
2. Consulte tests/steps/<módulo>/templates.json. Cada texto tem um stepId estável e lista de cenários que o usam.
3. Abra implementations.mjs desse módulo e adicione um handler com esse stepId. O handler recebe world, parameters, text, template e scenarioId.
4. Faça o handler chamar o componente, página ou API real de teste e verificar o efeito observável. Use os nomes de parâmetros indicados pelo template. Não retorne sucesso sem uma ação ou assertiva que comprove o passo.
5. Dados variáveis vêm de parameters. Extraia preparação e ações compartilhadas para support/ ou adaptadores próprios do módulo conforme o código real.
6. Execute só o cenário selecionado: `npm run test:planos -- --tags "@LLT84_C08"`.
7. Primeiro elimine pending/undefined e erros de ambiente. Depois comprove Red por comportamento ausente, Green pela implementação mínima e Refactor mantendo os testes relevantes passando.
8. Atualize o registro TDD no documento somente com a evidência obtida.

Os arquivos catalog.json contêm os textos expandidos das tabelas para evitar casamento ambíguo de steps. O registro central elimina duplicatas literais e seleciona o binding pelo ID do cenário. Ao alterar textos ou tabelas, rode `npm run catalogo:atualizar` e `npm run validar`, além de atualizar o documento correspondente. O catálogo é um ponto de partida para integrar estes documentos; não substitui as abstrações que surgirem no projeto real.

Clerk: usar a instância e as facilidades de teste oficiais que o projeto efetivamente configurar. MFA não deve ser desabilitado para facilitar testes, segredos de servidor não devem ir ao Front e não há conta real configurada neste pacote.

Um teste com resposta simulada comprova a apresentação do Front. Ele não comprova persistência, autorização no Core ou autenticação real. Não converter o exemplo local em evidência de aprovação da aplicação.
