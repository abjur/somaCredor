library(pdftools)
library(magrittr)

edital <- pdftools::pdf_text("~/Downloads/download.pdf")

resultado <- soma_edital(edital) # Aplica a função

resultado # Visualiza o resultado
