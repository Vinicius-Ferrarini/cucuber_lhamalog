# LhamaLog Cucumber

Estrutura inicial baseada nos documentos LLT-83, LLT-84, LLT-85 e LLT-86, preparada em 16/10/2026.

- 130 cenários de produto em português: 41 de Ocorrências, 42 de dashboards/relatórios e 47 de login.
- 303 linhas de execução dos planos, antes de repetir formatos de exportação suportados no ambiente.
- 1 cenário local adicional com 2 exemplos executáveis para demonstrar seleção e detalhe.
- Planos do produto com handlers não implementados: a execução retorna pending e falha em modo estrito; não há aprovação artificial.
- Demonstração independente, usando uma página fictícia em memória. Não acessa Jira, Drive, Core, Clerk nem uma aplicação real.

## Preparação

Use Node.js 24 LTS e npm. A configuração também segue as versões de Node aceitas pelo Cucumber instalado.

```sh
npm ci
npm run browsers:install
```

Se preferir um navegador já instalado, copie .env.example para .env e use BROWSER_CHANNEL=msedge ou chrome. HEADLESS=true mantém a execução em segundo plano. BASE_URL e CORE_API_URL só serão utilizados pelos adaptadores que a equipe implementar; preencher essas variáveis não conecta automaticamente os steps ao produto.

Não guardar segredos ou sessão real no pacote. Dependências e navegador são instalados no computador que executará os testes; node_modules e executáveis de navegador não estão no ZIP.

## Começar pela demonstração

```sh
npm test
npm run test:unit
```

O exemplo mostra duas Ocorrências fictícias e confere o detalhe de cada seleção no navegador. Seu relatório fica em reports/exemplo.html. O comando npm test executa apenas essa referência local; não representa toda a suíte do produto.

## Demonstrar Red Green e Refactor

```sh
npm run test:red
npm run test:green
npm run test:unit
```

Red termina com código de erro de propósito: a variante local contém o defeito de sempre abrir o primeiro registro. O segundo exemplo deve falhar por identificar a Ocorrência errada. Green seleciona o registro correspondente e deve passar nos dois exemplos. A função de seleção está separada da montagem da página em tests/fixtures/referencia-local.mjs; ela pode ser refatorada e os testes executados novamente. A alternância Red/Green é uma demonstração reproduzível, não uma afirmação de que o produto foi desenvolvido com TDD.

Evidências Red e Green usam nomes de arquivo separados. Um erro de instalação ou navegador indisponível não comprova Red.

## Validar os planos

```sh
npm run validar
npm run inventario
npm run test:planos -- --tags "@LLT84_C08"
npm run test:front
npm run test:integracao
npm run test:api
```

validar confere IDs, contagem e preparação Cucumber sem executar passos. Dry-run com sucesso só comprova a estrutura; não aprova comportamento. Na execução real dos planos, o primeiro passo sem handler fica pending e os seguintes são skipped. Isso é esperado no pacote inicial e não é Red.

Use --tags @LLT84, @LLT85 ou @LLT86 para selecionar uma atividade. IDs completos, como @LLT86_C01, selecionam um cenário. Algumas verificações do plano têm mais de uma camada e podem aparecer em mais de um filtro; resultados não devem ser somados como cenários únicos.

## Organização

```text
tests/
  features/
    ocorrencias/
    dashboards-relatorios/
    login/
    referencia-local/
  steps/
    ocorrencias/
    dashboards-relatorios/
    login/
    compartilhados/
  fixtures/
  support/
  unit/
docs/
scripts/
reports/
```

docs/COBERTURA.md relaciona cada cenário ao .feature. docs/rastreabilidade.json registra fontes, tags, contagens e hashes dos documentos de entrada. Os quatro Markdown estão em docs/. IMPLEMENTAR-UM-PASSO.md explica como conectar o catálogo ao código real.

Após alterar texto ou tabela de um .feature, execute `npm run catalogo:atualizar` e depois `npm run validar`. O sincronizador preserva os handlers existentes, atualiza catálogos e rastreabilidade e exige IDs únicos e sequenciais por atividade. Não aprova a alteração de requisitos: atualize também o documento de origem. Os arquivos iniciais usam cenários e esquemas com tabelas Exemplos; Rules, DocStrings e DataTables dentro de passos exigem ampliar explicitamente o sincronizador antes de utilizá-los.

## Próxima implementação no projeto real

Conferir a estrutura do repositório e adaptar linguagem e ferramentas de testes, seletores e fronteiras realmente disponíveis. Começar pelo caso LLT84_C08 com o Front real e resposta controlada do Core. Depois implementar filtros, dashboards e Clerk, mantendo separados componente, página, API e integração. Não foram inventados endpoints nem seletores do LhamaLog.

As regras de backend seguem os ADRs citados nos planos. Fórmulas, formatos de relatório, permissões de operação e configuração Clerk não são definidos por este pacote. Exportações repetem os formatos que o contrato efetivamente oferecer.

## Referências técnicas

- [Cucumber JS](https://github.com/cucumber/cucumber-js)
- [Configuração do Cucumber JS](https://github.com/cucumber/cucumber-js/blob/main/docs/configuration.md)
- [Dry-run do Cucumber JS](https://github.com/cucumber/cucumber-js/blob/main/docs/dry_run.md)
- [Playwright Library](https://playwright.dev/docs/library)
- [Navegadores Playwright](https://playwright.dev/docs/browsers)

Não publicar relatórios de uma integração real sem conferir e remover dados identificáveis e segredos. O pacote não contém credenciais reais.
