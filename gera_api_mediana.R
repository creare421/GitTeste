

base_url_selic<- "https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/odata/ExpectativasMercadoSelic?"

selecoes<-c("Data","Mediana")



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


