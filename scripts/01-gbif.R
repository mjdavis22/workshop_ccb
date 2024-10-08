
# setup -------------------------------------------------------------------

rm(list = ls())

library(rgbif)
library(tidyverse)

# data --------------------------------------------------------------------

key <- 
  name_backbone("Abronia villosa") |> 
  pull(usageKey)


gbif_download <- 
  occ_download(
    pred("taxonKey", key),format = "SIMPLE_CSV",
    user = 'melanie.davis.22',
    pwd = 'Myotis666',
    email = 'melanie.davis@ucr.edu')

occ_download_wait(gbif_download)

gbif_download |> 
  write_rds('data/raw/key.rds')

gbif_download |> 
  read_rds(
    file = "data/raw/key.rds")

data <- 
  occ_download_get(
    gbif_download, 
    path = 'data/raw', 
    overwrite = TRUE) |> 
  occ_download_import()

# save data ---------------------------------------------------------------

data |> 
  write_csv('data/raw/abronia_gbif_raw.csv')
