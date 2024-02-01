FROM rhub/r-minimal:4.3.2

LABEL maintainer "Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

# hadolint ignore=DL3018
RUN apk add --no-cache --update-cache \
        --repository http://nl.alpinelinux.org/alpine/v3.11/main \
        mariadb-connector-c-dev \
        perl

ENV LC_ALL=nb_NO.UTF-8
ENV LANG=nb_NO.UTF-8

RUN installr -d \
        -t "libsodium-dev mariadb-dev curl-dev linux-headers autoconf automake" \
        -a libsodium \
           digest \
           dplyr \
           DT \
           magrittr \
           pool \
           readr \
           rlang \
           RMariaDB \
           rmarkdown \
           shiny \
           shinyjs \
           shinyalert \
           shinycssloaders \
           tibble \
           yaml

RUN wget -q https://github.com/jgm/pandoc/releases/download/2.13/pandoc-2.13-linux-amd64.tar.gz \
    && tar xzf pandoc-2.13-linux-amd64.tar.gz \
    && mv pandoc-2.13/bin/* /usr/local/bin/ \
    && rm -rf pandoc-2.13*

CMD ["R"]
