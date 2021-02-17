FROM rocker/r-base:4.0.3

LABEL maintainer "Are Edvardsen <are.edvardsen@helse-nord.no>"

# system libraries of general use
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo=1.9.5 \
    pandoc=2.9.2 \
    pandoc-citeproc=0.17.0 \
    libcurl4-gnutls-dev=7.74.0 \
    libcairo2-dev=1.16.0 \
    libxt-dev=1:1.2.0 \
    libxml2-dev=2.9.10 \
    libssl-dev=1.1.1i \
    libmariadbclient-dev=1:10.5.8 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# basic R functionality
RUN R -e "install.packages(c('remotes'), repos='https://cloud.r-project.org/')"

# install package dependencies
RUN R -e "install.packages(c('digest', 'dplyr', 'DT', 'magrittr', 'pool', 'readr', 'rlang', 'RMariaDB', 'yaml'))"

RUN R -e "remotes::install_github('rstudio/shiny')"

RUN R -e "install.packages(c('shinyalert', 'shinycssloaders'))"

CMD ["R"]
