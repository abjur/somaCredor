
# Somar Editais de lista de credores

O objetivo desse pacote `{somaRelacaoCredores}` é disponibilizar o
script que ajuda a somar todos os créditos da lista de credores que não
apresentar um total oficial.

Para seu funcionamento necessariamente a lista precisa originar nos
padrões de edital do Tribunal de Justiça de São Paulo.

# Instalação

``` r
remotes::install_github("abjur/somaRelacaoCredores")
```

O primeiro passo é importar a lista em arquivo `.pdf` utilizando o
pacote `{pdftools}`:

``` r
library(somaRelacaoCredores)

# importando arquivo em pdf

exemplo_pdf <- system.file(
  "lista_aj.pdf", 
  package = "somaRelacaoCredores"
)
edital <- pdftools::pdf_text(exemplo_pdf)
```

Depois de importada sua lista você poderá utilizar a função
`soma_edital` para encontrar o total dos créditos.

## Exemplo

``` r
resultado <- soma_edital(edital)

resultado
```

    ## [1] 5190181

## Observações

Observamos que o padrão do documento oficial pode-se alterar dependendo
da organização dos responsáveis pela Lista de Credor.

A função que exemplificamos prevê o funcionamento ideal para os
seguintes problemas:

  - Valores entre a quebra da Página do TJSP.

  - Valores com erros de typo seguindo de (,): 100,000,00.

Caso existir algum desses padrões, verifique esses valores de forma
manual.
