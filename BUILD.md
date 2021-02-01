# BUILD

[toc]

-----



## rocker/binder

https://hub.docker.com/r/rocker/binder/dockerfile

![image-20210129193459839](assets/BUILD/image-20210129193459839.png)

### Dockerfile

```ruby
FROM rocker/geospatial:3.6.3

ENV NB_USER rstudio
ENV NB_UID 1000
ENV VENV_DIR /srv/venv

# Set ENV for all programs...
ENV PATH ${VENV_DIR}/bin:$PATH
# And set ENV for R! It doesn't read from the environment...
RUN echo "PATH=${PATH}" >> /usr/local/lib/R/etc/Renviron
RUN echo "export PATH=${PATH}" >> ${HOME}/.profile

# The `rsession` binary that is called by nbrsessionproxy to start R doesn't seem to start
# without this being explicitly set
ENV LD_LIBRARY_PATH /usr/local/lib/R/lib

ENV HOME /home/${NB_USER}
WORKDIR ${HOME}

RUN apt-get update && \
    apt-get -y install python3-venv python3-dev && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a venv dir owned by unprivileged user & set up notebook in it
# This allows non-root to install python libraries if required
RUN mkdir -p ${VENV_DIR} && chown -R ${NB_USER} ${VENV_DIR}

USER ${NB_USER}
RUN python3 -m venv ${VENV_DIR} && \
    # Explicitly install a new enough version of pip
    pip3 install pip==9.0.1 && \
    pip3 install --no-cache-dir \
         jupyter-rsession-proxy

RUN R --quiet -e "devtools::install_github('IRkernel/IRkernel')" && \
    R --quiet -e "IRkernel::installspec(prefix='${VENV_DIR}')"


CMD jupyter notebook --ip 0.0.0.0


## If extending this image, remember to switch back to USER root to apt-get
```



### install.R (packages)

![image-20210129193625269](assets/BUILD/image-20210129193625269.png)

## R-3.6.3



![image-20210129193033964](assets/BUILD/image-20210129193033964.png)



![image-20210129193104341](assets/BUILD/image-20210129193104341.png)



![image-20210129194041044](assets/BUILD/image-20210129194041044.png)







## R-3.5.3

![image-20210129193732569](assets/BUILD/image-20210129193732569.png)



![image-20210129194006804](assets/BUILD/image-20210129194006804.png)







![image-20210129193316914](assets/BUILD/image-20210129193316914.png)



![image-20210129193350063](assets/BUILD/image-20210129193350063.png)



## R-3.5.1

![image-20210129195417397](assets/BUILD/image-20210129195417397.png)



![image-20210129195439691](assets/BUILD/image-20210129195439691.png)



## rocker/binder

https://hub.docker.com/r/rocker/binder/dockerfile

```ruby
FROM rocker/geospatial:3.6.3

ENV NB_USER rstudio
ENV NB_UID 1000
ENV VENV_DIR /srv/venv

# Set ENV for all programs...
ENV PATH ${VENV_DIR}/bin:$PATH
# And set ENV for R! It doesn't read from the environment...
RUN echo "PATH=${PATH}" >> /usr/local/lib/R/etc/Renviron
RUN echo "export PATH=${PATH}" >> ${HOME}/.profile

# The `rsession` binary that is called by nbrsessionproxy to start R doesn't seem to start
# without this being explicitly set
ENV LD_LIBRARY_PATH /usr/local/lib/R/lib

ENV HOME /home/${NB_USER}
WORKDIR ${HOME}

RUN apt-get update && \
    apt-get -y install python3-venv python3-dev && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a venv dir owned by unprivileged user & set up notebook in it
# This allows non-root to install python libraries if required
RUN mkdir -p ${VENV_DIR} && chown -R ${NB_USER} ${VENV_DIR}

USER ${NB_USER}
RUN python3 -m venv ${VENV_DIR} && \
    # Explicitly install a new enough version of pip
    pip3 install pip==9.0.1 && \
    pip3 install --no-cache-dir \
         jupyter-rsession-proxy

RUN R --quiet -e "devtools::install_github('IRkernel/IRkernel')" && \
    R --quiet -e "IRkernel::installspec(prefix='${VENV_DIR}')"


CMD jupyter notebook --ip 0.0.0.0


## If extending this image, remember to switch back to USER root to apt-get

```