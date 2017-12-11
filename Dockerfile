FROM ubuntu:16.04

RUN apt-get update
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | tee -a /etc/apt/sources.list
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
RUN gpg -a --export E084DAB9 | apt-key add -
RUN apt-get update && apt-get -y install python3
RUN apt-get -y install r-base libcurl4-openssl-dev libssl-dev libxml2-dev

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages(c('argparse', 'e1071', 'tidyverse'))"
RUN Rscript -e "source('https://bioconductor.org/biocLite.R');biocLite();biocLite('preprocessCore')"

COPY bin/cibersort_wrapper.R /usr/local/bin/
RUN chmod a+x /usr/local/bin/cibersort_wrapper.R
COPY bin/CIBERSORT.R /usr/local/bin/
RUN chmod a+x /usr/local/bin/CIBERSORT.R
