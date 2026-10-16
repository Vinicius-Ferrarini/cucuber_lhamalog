# Plano para conectar a estrutura ao LhamaLog

## Entregue no pacote

Especificações .feature dos planos 84, 85 e 86, seus catálogos de passos, as fixtures fictícias, configuração, relatórios e uma demonstração local executável. O modelo 83 permanece como documento de referência, sem duplicar seus exemplos como requisitos de produto.

## Implementação no repositório real

1. Conferir linguagem, organização e ferramentas do repositório. Este pacote utiliza JavaScript em módulos ESM, Cucumber JS e Playwright como estrutura independente de testes; não define a linguagem da aplicação.
2. Adaptar os componentes ou páginas de teste e a configuração de ambiente que realmente existirem. Não basta preencher BASE_URL; ainda é preciso implementar os handlers.
3. Começar por LLT84_C08 com a página real e resposta controlada de detalhe. Usar IDs/roles reais da interface, sem copiar os seletores da fixture local como se fossem do produto.
4. Escrever as assertivas e confirmar a falha por comportamento ausente. Resolver pending/undefined e instalação antes de chamar o resultado de Red.
5. Implementar o comportamento da aplicação para Green. Depois extrair ações e preparação comuns, avaliar Refactor e repetir os testes relevantes.
6. Expandir para busca, filtros e mutações de Ocorrências; em seguida dashboards e exportações; depois Clerk e os fluxos de login.
7. Implementar as integrações com Core e Clerk no ambiente isolado de teste. Preparar autorização e dados por cenário, sem desabilitar MFA ou usar segredos de backend no Front.
8. Validar cada formato de exportação realmente disponibilizado e inspecionar conteúdo e autorização do arquivo. Respostas simuladas não aprovam fórmula, geração nem cancelamento reais.
9. Configurar o processo de integração contínua do repositório: primeiro verificações de estrutura e testes locais; depois separar testes de Front e integrações que dependam de ambiente.

## Critério para considerar um cenário automatizado

- O passo faz uma ação ou assertiva observável apropriada à camada.
- A fixture é própria, fictícia e independente de outro cenário.
- O teste falha quando o comportamento verificado é removido ou alterado incorretamente.
- Existe evidência de execução no ambiente indicado e vínculo com o cenário/USID.
- Nenhum resultado pending, undefined, skipped ou dry-run é declarado como aprovado.

## Preservar as fontes

As regras de backend seguem os ADRs citados nos documentos. Alterar cenários exige atualizar .feature, catálogo, rastreabilidade e documento correspondente. Não transformar exemplos de formatos, métricas ou mensagens em contratos finais por dedução.
