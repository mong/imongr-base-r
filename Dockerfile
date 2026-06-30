FROM pandoc/minimal:3.10.0 AS pandoc-source

FROM rhub/r-minimal:4.6.0

LABEL maintainer="Arnfinn Hykkerud Steindal <arnfinn.hykkerud.steindal@helse-nord.no>"

COPY --from=pandoc-source /usr/local/bin/pandoc /usr/local/bin/pandoc

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
           ggplot2

CMD ["R"]
