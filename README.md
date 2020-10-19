
# Somar Editais de lista de credores

O objetivo desse pacote `{somaRelacaoCredores}` é disponibilizar o
script que ajuda a somar todos os créditos da lista de credores que não
apresentar um total oficial.

Para seu funcionamento necessariamente a lista precisa originar nos
padrões de edital do Tribunal de Justiça de São Paulo.

# Instalação

    remotes::install_github("abjur/somaRelacaoCredores")

O primeiro passo é importar a lista em arquivo `.pdf` utilizando o
pacote `{pdftools}`:

    library(somaRelacaoCredores)

    # importando arquivo em pdf

    exemplo_pdf <- system.file(
      "lista_aj.pdf", 
      package = "somaRelacaoCredores"
    )
    edital <- pdftools::pdf_text(exemplo_pdf)

Depois de importada sua lista você poderá utilizar a função
`somaEditais` para encontrar o total dos créditos

## Exemplo

    listaAJ <- somaEdital(edital)

    listaAJ

    ## [1] 4809999