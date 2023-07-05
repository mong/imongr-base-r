FROM rocker/r-ver:4.3.1

LABEL maintainer "Are Edvardsen <are.edvardsen@helse-nord.no>"

# system libraries of general use
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    pandoc \
    libcurl3-gnutls \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libxml2-dev \
    libssl-dev \
    libmariadb-dev \
    texlive-latex-recommended \
    texlive-latex-extra \
    lmodern \
    locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set norsk bokmaal as default system locale
RUN sed -i 's/^# *\(nb_NO.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen \
    && echo "LANG=\"nb_NO.UTF-8\"" > /etc/default/locale \
    && update-locale LANG=nb_NO.utf8

ENV LC_ALL=nb_NO.UTF-8
ENV LANG=nb_NO.UTF-8

# install package dependencies
RUN R -e "install.packages(c('digest',\
                             'dplyr',\
                             'DT',\
                             'lifecycle',\
                             'magrittr',\
                             'pool',\
                             'readr',\
                             'rlang',\
                             'remotes',\
                             'rmarkdown', \
                             'shiny',\
                             'shinyjs',\
                             'shinyalert',\
                             'shinycssloaders',\
                             'tibble',\
                             'yaml'))" && \
                             R -e "remotes::install_github('r-dbi/RMariaDB@*release')"

CMD ["R"]
