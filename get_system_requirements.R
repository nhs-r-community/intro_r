library(jsonlite)
library(magrittr)
library(purrr)
library(httr)

renvlock <- read_json("renv.lock")

packages <- renvlock$Packages %>%
  keep(~ any(.x$Repository == "CRAN", FALSE)) %>%
  names()

packages <- paste("pkgname=", packages, sep = "", collapse = "&")

url <- "http://packagemanager.rstudio.com/__api__/repos/1/sysreqs?all=false&distribution=ubuntu&release=20.04"

res <- GET(paste(url, packages, sep = "&"))

requirements <- content(res)$requirements %>%
  map("requirements") %>%
  map("install_scripts") %>%
  flatten() %>%
  flatten_chr() %>%
  unique()

c("#!/bin/sh", "", "# system requirements for packages", "", requirements) %>%
  writeLines("system_requirements.sh")

Sys.chmod("system_requirements.sh", "0755")