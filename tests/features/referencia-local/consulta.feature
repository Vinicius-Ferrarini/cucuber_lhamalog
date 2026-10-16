# language: pt
@referencia_local
Funcionalidade: Demonstrar a estrutura Cucumber com uma página fictícia
  Esta demonstração exercita o mesmo comportamento de seleção da LLT-84.
  Não comprova a implementação do Front, Core, Clerk nem aprovação de um cenário de produto.

  Esquema do Cenário: Mostrar o detalhe correspondente à seleção local - <exemplo>
    Dado que a página local de referência mostra duas Ocorrências fictícias
    Quando seleciono na demonstração a Ocorrência "<id>"
    Então o detalhe local deve identificar "<id>" e "<titulo>"

    Exemplos:
      | exemplo | id | titulo |
      | primeiro registro | OC-EX-01 | Ocorrência Exemplo 01 |
      | segundo registro | OC-EX-02 | Ocorrência Exemplo 02 |
