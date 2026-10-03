library(targets)
library(here)
library(tarchetypes)
tar_source("R")

list(
  tar_target(
    arquivo,
    here("dados", "airquality.csv"),
    format = "file"
  ),
  
  tar_target(
    dados,
    ler_dados(arquivo)
  ),
  
  tar_target(
    medias,
    resumir(dados)
  ),
  
  tar_target(
    modelo,
    modelar(dados)
  ),
  
  tar_target(
    figura,
    desenhar(dados, modelo, here("R", "grafico.png")),
    format = "file"
  ),
  
  tar_target(
    medias_csv,
    {
      dir.create(here("saidas"), showWarnings = FALSE)
      arquivo_saida <- here("saidas", "medias.csv")
      write.csv(medias, arquivo_saida, row.names = FALSE)
      arquivo_saida
    },
    format = "file"
  ),
  
  tar_quarto(
    relatorio,
    path = "relatorio.qmd"
  )
)