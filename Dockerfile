FROM rhub/r-minimal:4.2.3

LABEL maintainer "Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

# system libraries
RUN apk add --no-cache --update-cache \
        --repository http://nl.alpinelinux.org/alpine/v3.11/main \
        autoconf=2.69-r2 \
        automake=1.16.1-r0

ENV LC_ALL=nb_NO.UTF-8
ENV LANG=nb_NO.UTF-8

RUN apk add --no-cache mariadb-dev mariadb-connector-c-dev perl cairo-dev

# install package dependencies
RUN installr -d \
        -t "libsodium-dev curl-dev linux-headers autoconf automake" \
        -a libsodium \
        digest dplyr DT lifecycle magrittr pool readr rlang RMariaDB rmarkdown shiny shinyjs shinyalert shinycssloaders tibble yaml && \
        wget https://github.com/jgm/pandoc/releases/download/2.13/pandoc-2.13-linux-amd64.tar.gz && \
        tar xzf pandoc-2.13-linux-amd64.tar.gz && \
        mv pandoc-2.13/bin/* /usr/local/bin/ && \
        rm -rf pandoc-2.13*

RUN installr -d tinytex && R -e "tinytex::install_tinytex(TRUE)" && R -e "tinytex::tinytex_root()"

CMD ["R"]
