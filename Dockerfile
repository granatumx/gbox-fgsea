## Emacs, make this -*- mode: sh; -*-
 
# [tkwolf 20180712] Using specific dated version
FROM granatumx/gbox-r-sdk:1.0.0
#FROM bioconductor/bioconductor_docker:latest
# FROM r-base:3.6.3
#debian:testing-20180426

## This handle reaches Carl and Dirk
MAINTAINER "GranatumX" granatumx@yahoo.com

# devtools_1.13.5 (above)
RUN R -e 'install.packages(c("stringr"))'
RUN R -e 'install.packages(c("forcats"))'
RUN R -e 'BiocManager::install(c("fgsea"))'
RUN R -e 'BiocManager::install(c("KEGG.db"))'
RUN R -e 'BiocManager::install(c("GO.db"))'
RUN R -e 'BiocManager::install(c("org.Hs.eg.db"))'
RUN R -e 'BiocManager::install(c("org.Hm.eg.db"))'

# Set version correctly so user can install gbox
# Requires bash and sed to set version in yamls
# Can modify if base OS does not support bash/sed

COPY . .
RUN ./GBOXtranslateVERinYAMLS.sh
RUN tar zcvf /gbox.tgz package.yaml yamls/*.yaml
