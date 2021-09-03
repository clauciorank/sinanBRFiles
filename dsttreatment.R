
hepgeral <- readxl::read_xlsx('~/Documents/datasus/HEPATITES.xlsx', sheet = 1)

hepgeral2 <- readxl::read_xlsx('~/Documents/datasus/HEPATITES.xlsx', sheet = 2) %>% select(-c(1,2))

cod_mun <- hepgeral2 <- readxl::read_xlsx('~/Documents/datasus/HEPATITES.xlsx', sheet = 2) %>% select(c(1,2))
library(dplyr)

hep <- bind_cols(hepgeral, hepgeral2)


hepA <- hep %>% select(grep(x = colnames(hep), pattern = ' A ')) 

hepB <- hep %>% select(grep(x = colnames(hep), pattern = ' B ')) %>% select(-1)


hepC <- hep %>% select(grep(x = colnames(hep), pattern = ' C ')) %>% select(-1) 


hepD <- hep %>% select(grep(x = colnames(hep), pattern = ' D ')) 



hepA <- bind_cols(cod_mun, hepA)
hepB <- bind_cols(cod_mun, hepB)
hepC <- bind_cols(cod_mun, hepC)
hepD <- bind_cols(cod_mun, hepD)



write.csv(hepD, '~/Documents/datasus/HEPS/HEPD.csv', row.names = F)


## AIDS
aids1 <- read.csv('~/Documents/datasus/aids1.csv') %>% select(-1)
aids2 <- read.csv('~/Documents/datasus/aids2.csv') %>% select(-c(1,2))
aids3 <-read.csv('~/Documents/datasus/aids3.csv')%>% select(-c(1,2))


aids <- bind_cols(aids1,aids2,aids3)

write.csv(aids, '~/Documents/datasus/AIDS.csv', row.names = F)




## Sifilis
library(dplyr)
data <- data.frame()

for (i in 1:6) {
  if (i==1) {
    data <- readxl::read_xlsx('~/Downloads/Baixar dados de todos os municípios - SÍFILIS (1).xlsx', sheet = i) %>% select(-1)
  }else{
    app <- readxl::read_xlsx('~/Downloads/Baixar dados de todos os municípios - SÍFILIS (1).xlsx', sheet = i) %>% select(-c(1:3))
    data <- bind_cols(data, app)
  }
  
}

write.csv(data, '~/Documents/datasus/DSTS/SIFILIS.csv', row.names = F)

saveRDS(data, '~/Documents/datasus/DSTS/SIFILIS.Rds')


files <- list.files('~/Documents/datasus/DSTS/')
files_rds <- substring(files,1, 4)


setwd('~/Documents/datasus/DSTS/')

for (i in 1:length(files)){
  a <- read.csv(files[i])
  saveRDS(a, paste0(files_rds[i], '.Rds'))
}



