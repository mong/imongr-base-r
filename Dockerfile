FROM rhub/r-minimal:4.5.0

LABEL maintainer "Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

# hadolint ignore=DL3018
RUN apk add --no-cache --update-cache \
        mariadb-connector-c-dev

ENV LC_ALL=nb_NO.UTF-8
ENV LANG=nb_NO.UTF-8

ARG TARGETARCH

RUN installr -d \
    -t "cairo-dev gfortran" \
    -a "cairo font-liberation" \
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
           yaml \
           Cairo \
           ggplot2 \
           shinyvalidate \
  && wget -q https://github.com/jgm/pandoc/releases/download/2.19.2/pandoc-2.19.2-linux-${TARGETARCH}.tar.gz \
  && tar xzf pandoc-2.19.2-linux-${TARGETARCH}.tar.gz \
  && mv pandoc-2.19.2/bin/* /usr/local/bin/ \
  && rm -rf pandoc-2.19.2*

CMD ["R"]
