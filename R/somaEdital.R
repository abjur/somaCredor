#' Formula de somar Valores de Créditos em Editais Oficiais
#'
#' Essa função manipula um edital oficial para que seja possivel
#' somar seu o total.
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
    warning(stringr::str_c(
      "Possível problema encontrado na formatação dos números. ",
      "Utilizando estratégia mais agressiva de detecção! ",
      "Verificar resultado manualmente."
    ))
    # Expressão regular para encontrar números (possivelmente quebrados)
    rx <- stringr::regex("(?<=R\\$.{0,1000})[0-9.]+,[0-9]+", dotall = TRUE)
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
  }
  return(sum(valores))
}

