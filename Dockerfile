# R version 3.5.1 (2018-07-02) -- "Feather Spray", with RStudio 1.1.463
# FROM rocker/binder:3.5.1
# R version 3.6.3 (2020-02-29) -- "Holding the Windsock", with RStudio 1.2.5042
FROM rocker/binder:3.6.3

# Copy your repository contents to the image
COPY --chown=rstudio:rstudio . ${HOME}

## Run an install.R script, if it exists.
RUN if [ -f install.R ]; then R --quiet -f install.R; fi

