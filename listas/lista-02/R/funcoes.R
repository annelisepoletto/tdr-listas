# Lê o CSV e acrescenta o nome do mês como fator.
ler_dados <- function(arquivo) {
  dados <- read.csv(arquivo)
  
  dados$Mes <- factor(
    dados$Month,
    levels = 5:9,
    labels = c("Maio", "Junho", "Julho", "Agosto", "Setembro")
  )
  
  dados
}

# Calcula a média mensal de Ozone e Solar.R.
resumir <- function(dados) {
  medias <- aggregate(
    cbind(Ozone, Solar.R) ~ Mes,
    data = dados,
    FUN = mean,
    na.rm = TRUE
  )
  
  medias
}
# Ajusta o modelo de Ozone em função de Solar.R.
modelar <- function(dados) {
  lm(Ozone ~ Solar.R, data = dados)
}

# Desenha a dispersão com a reta ajustada, salva o PNG e devolve seu caminho.
desenhar <- function(dados, modelo, arquivo) {
  dir.create(
    dirname(arquivo),
    showWarnings = FALSE,
    recursive = TRUE
  )
  
  png(arquivo, width = 1400, height = 900, res = 180)
  
  plot(
    Ozone ~ Solar.R,
    data = dados,
    pch = 19,
    xlab = "Radiação solar",
    ylab = "Ozônio (ppb)"
  )
  
  abline(modelo, lwd = 2)
  
  dev.off()
  
  arquivo
}