


library(httr)
library(jsonlite)
library(stringr)
library(dplyr)
library(tidyr)
library(purrr)


base_url_selic<- "https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/odata/ExpectativasMercadoSelic?"

selecoes<-c("Data","Mediana")



base_url_rreo <- "apidatalake.tesouro.gov.br/ords/siconfi/tt/rreo?"

# parâmetros de consulata ao RREO
ano <- "2024"
bimestre <- "1"
tipo_relatorio <- "RREO"
num_anexo <- "RREO-Anexo+01"
ente <- c("3304557", "3127701","3115409")



chamada<-function(ente){
  chamada_api_rreo <- paste(base_url_rreo,
                            "an_exercicio=", ano, "&",
                            "nr_periodo=", bimestre, "&",
                            "co_tipo_demonstrativo=", tipo_relatorio, "&",
                            "no_anexo=", num_anexo, "&",
                            "id_ente=", ente, sep = "")
  
  rreo <- GET(chamada_api_rreo)
  
  
  status_code(rreo)   ### 200 é ok
  
  rreo_txt <- content(rreo, as="text", encoding="UTF-8")
  
  rreo_json <- fromJSON(rreo_txt, flatten = FALSE) 
  
  
  rreo_df <- as.data.frame(rreo_json[["items"]]) 
  
  
  base<-knitr::kable(head(rreo_df))
  
  return(rreo_df )
  
}
chamada_selic<-function(sel){
  chamada_api_rreo <- paste(base_url_selic,
                            "select=",str_c(selecoes,collapse = ","), sep = "")
  return(chamada_api_rreo )
}

selic <- GET(chamada_selic(sel=selecoes))


status_code(selic)   ### 200 é ok

selic_txt <- content(selic, as="text", encoding="UTF-8")

selic_json <- fromJSON(selic_txt, flatten = FALSE) 


selic_df <- as.data.frame(selic_json[["value"]]) 


base_selic<-knitr::kable(head(selic_df))



View(selic_df)


### teste


