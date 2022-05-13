#' Essa função manipula um edital oficial para que seja possivel
#' somar o total com pontos de interrogação intertido
#'
#' @param edital edital em pdf oficial, importada pelo pacote pdftools.
#'
#' @return Resultado da soma total dos créditos.
#'
#' @export
soma_edital_com_pontos_invertidos <- function(edital) {
  # reduzir os espacos em branco repetidos dentro de uma string
  texto <- stringr::str_squish(edital)
  # Capturar os valores e convertê-los em numéricos
  valores <- texto %>%
    # extrair pedacos identificados pelo padrão, reconhece somente numeros
    stringr::str_extract_all("R\\$ ?[0-9,.]+") %>%
    # extrair pontos de interrogação invertidos
    stringr::str_replace_all("\\u00bf","¿") %>%
    # converter lista em vetor
    unlist() %>%
    # marca de agrupamento pela localidade e ignorada
    readr::parse_number(locale = readr::locale(grouping_mark = ".", decimal_mark = ","))

  return(sum(valores))
}
