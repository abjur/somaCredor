
# Somar editais de lista de credores <a href='https://abjur.github.io/somaCredor'><img src='man/figures/hex.png' align="right" height="139" /></a>

O objetivo desse pacote `{somaCredor}` é disponibilizar o script que
ajuda a somar todos os créditos da lista de credores que não apresentar
um total oficial.

Para seu funcionamento necessariamente a lista precisa estar nos padrões
oficiais de edital do Tribunal de Justiça de São Paulo.

# Instalação

``` r
remotes::install_github("abjur/somaCredor") # Instala direto do github
```

O primeiro passo é importar a lista em arquivo `.pdf` utilizando o
pacote `{pdftools}`:

``` r
library(somaCredor)

# importando arquivo em pdf

exemplo_pdf <- system.file("lista_aj.pdf",
                           package = "somaCredor")
edital <- pdftools::pdf_text(exemplo_pdf)
```

Depois de importada sua lista você poderá utilizar a função
`soma_edital` para encontrar o total dos créditos.

## Exemplo

``` r
resultado <- soma_edital(edital) # Aplica a função

resultado # Visualiza o resultado
```

    ## [1] 5190181

## Observações

Observamos que o padrão do documento oficial pode-se alterar dependendo
da organização dos responsáveis pela Lista de Credor.

A função prevê o funcionamento ideal para os seguintes problemas:

-   Valores entre a quebra da Página do TJSP.

-   Valores com erros de typo seguindo de (,): 100,000,00.

-   Listas com pontos de interrogação invertidos (¿).

Caso você visualizar a seguinte mensagem no console:

    ## Warning: Possível problema encontrado na formatação dos números. Utilizando
    ## estratégia mais agressiva de detecção! Verificar resultado manualmente.

ou existir algum dos padrões acima, verifique o resultado de forma
manual.
