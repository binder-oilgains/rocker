ARG RSTUDIO_VERSION=1.4.1103
# ENV RSTUDIO_VERSION=1.2.5042
FROM rocker/binder:3.6.3

# Copy your repository contents to the image
COPY --chown=rstudio:rstudio . ${HOME}

## Run an install.R script, if it exists.
RUN if [ -f install.R ]; then R --quiet -f install.R; fi

