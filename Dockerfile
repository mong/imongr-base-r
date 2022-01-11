FROM rocker/r-base:4.1.2

LABEL maintainer "Are Edvardsen <are.edvardsen@helse-nord.no>"

# system libraries of general use
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl3-gnutls \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libxml2-dev \
    libssl-dev \
    libmariadb-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install package dependencies
RUN R -e "install.packages(c('digest',\
                             'dplyr',\
                             'DT',\
                             'lifecycle',\
                             'magrittr',\
                             'pool',\
                             'readr',\
                             'rlang',\
                             'RMariaDB',\
                             'shiny',\
                             'shinyjs',\
                             'shinyalert',\
                             'shinycssloaders',\
                             'tibble',\
                             'yaml'))"

CMD ["R"]
