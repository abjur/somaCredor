#' Formula de somar Valores de Créditos em Editais Oficiais
#'
#' Essa função cria um aviso de possível problema na formatação
#' dos números.
#'
#' @return retorna a seguinte mensagem "Possível problema encontrado na formatação
#' dos números. Utilizando estratégia mais agressiva de detecção!
#'  Verificar resultado manualmente."
#'
#' @export

warn_parse <- function() {
  warning(
    stringr::str_c(
      "Possível problema encontrado na formatação dos números. ",
      "Utilizando estratégia mais agressiva de detecção! ",
      "Verificar resultado manualmente."
    )
  )
}
#' Essa função manipula um edital oficial para que seja possivel
#' somar o total.
#'
#' @param edital edital em pdf oficial, importada pelo pacote pdftools.
#'
#' @return Resultado da soma total dos créditos.
#'
#' @export
soma_edital <- function(edital) {
  # reduzir os espacos em branco repetidos dentro de uma string
  texto <- stringr::str_squish(edital)
  # Capturar os valores e convertê-los em numéricos
  valores <- texto %>%
    # extrair pedacos identificados pelo padrão, reconhece somente numeros
    stringr::str_extract_all("R\\$ ?[0-9,.]+") %>%
    # converter lista em vetor
    unlist() %>%
    # marca de agrupamento pela localidade e ignorada
    readr::parse_number(locale = readr::locale(grouping_mark = ".", decimal_mark = ","))

  # Garantir que não tivemos problemas com o parse
  if (length(valores) != sum(stringr::str_count(texto, "\\$"))) {
    warn_parse()
    # Expressão regular para encontrar números (possivelmente quebrados)
    rx <-
      stringr::regex("(?<=R\\$.{0,1000})[0-9.]+,[0-9]+", dotall = TRUE)
    # Capturar os valores e convertê-los em numéricos
    valores <- texto %>%
      # juntar todas as páginas para poder pegar números que atravessam elas
      stringr::str_c(collapse = " ") %>%
      # extrair pedacos identificados pelo padrão, reconhece somente numeros
      stringr::str_extract_all(rx) %>%
      # converter lista em vetor
      unlist() %>%
      # marca de agrupamento pela localidade e ignorada
      readr::parse_number(locale = readr::locale(grouping_mark = ".", decimal_mark = ","))

    # Garantir que não tivemos problemas com decimal vírgula
  } else if (length(valores) != sum(stringr::str_count(texto, "(?<=[0-9]),(?=[0-9])"))) {
    warn_parse()
    entrada <- texto %>%
      # extrair pedacos identificados pelo padrão, reconhece somente numeros
      stringr::str_extract_all("R\\$ ?[0-9,.]+") %>%
      # converter lista em vetor
      unlist() %>%
      # Remover finalzinho extra dos números
      stringr::str_remove_all("[.,]+$")
    final <- stringr::str_extract(entrada, ",[0-9]{2}$")
    inicio_arrumado <-
      stringr::str_extract(entrada, ".+(?=,[0-9]{2}$)") %>%
      stringr::str_remove_all("[^0-9]")
    # Agrupando as variaveis
    valores <- stringr::str_c(inicio_arrumado, final) %>%
      # Marca de agrupamento pela localidade e ignorada
      readr::parse_number(locale = readr::locale(decimal_mark = ","))
  }
  return(sum(valores))
}
