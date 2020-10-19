#' Formula de somar Valores de Créditos em Editais Oficiais
#'
#' Essa função manipula um edital oficial para que seja possivel
#' somar seu o total.
#'
#' @param lista lista oficial, importada pelo pacote pdftools.
#'
#' @return Resultado da soma total dos créditos.
#'
#' @export

somaEdital <- function(edital) {
  edital %>%
  # reduzir os espacos em branco repetidos dentro de uma string
  stringr::str_squish() %>%
  # extrair pedacos identificados pelo padrão, reconhece somente numeros
  stringr::str_extract_all("R\\$ ?[0-9,.]+") %>%
  # converter lista em vetor
  unlist() %>%
  # marca de agrupamento pela localidade e ignorada
  readr::parse_number(locale = locale(grouping_mark = ".", decimal_mark = ",")) %>%
  sum()
}


