# language: pt
@LLT85
Funcionalidade: Anexo Verificações complementares de backend

  @USID_031 @USID_033 @USID_034 @USID_035 @USID_037 @api @core @ADR_121 @ADR_122 @ADR_126
  @LLT85_C40 @planejado
  Esquema do Cenário: 40 Recusar operações fora do escopo autorizado - <exemplo>
    Dado que a sessão fictícia não tem acesso ao contexto solicitado
    Quando chamo diretamente <operacao> com identificador de outra Empresa ou Produto sem permissão
    Então o Core deve recusar sem devolver dados indicadores contribuição agregada ou arquivo desse contexto
    E a recusa deve seguir o contrato de negação simples sem revogar a sessão por esse motivo

    Exemplos:
      | exemplo | operacao |
      | dados | consulta de dashboard ou Ocorrências empresariais |
      | geração | solicitação de relatório |
      | obtenção | obtenção do arquivo de relatório |


  @USID_032 @USID_033 @USID_035 @USID_036 @api @core @criterio_front
  @LLT85_C41 @planejado
  Esquema do Cenário: 41 Validar critérios e formato sem depender do formulário - <exemplo>
    Dado que identifiquei a operação real e seus parâmetros documentados
    Quando envio diretamente <entrada> incompatível com esse contrato
    Então o Core deve recusar conforme o contrato sem consultar ou exportar um escopo irrestrito por omissão
    E a proteção não deve depender da validação feita pelo navegador

    Exemplos:
      | exemplo | entrada |
      | período | intervalo inicial posterior ao final |
      | tipo de dado | tipo inválido no parâmetro de filtro exigido |
      | formato | formato não suportado pela operação de exportação |


  @USID_033 @USID_035 @api @core @ADR_121 @ADR_122
  @LLT85_C42 @planejado
  Cenário: 42 Proteger a referência de download contra outra identidade
    Dado que Ana Exemplo gerou um relatório autorizado no ambiente de teste
    E Bruno Exemplo não tem acesso ao contexto desse relatório
    Quando Bruno tenta usar diretamente a referência de obtenção do arquivo pelo mecanismo previsto no contrato
    Então o serviço deve impedir a obtenção dos dados sem autorização
    E o teste deve verificar o mecanismo efetivo de autorização da entrega sem inventar prazo ou tecnologia de URL
