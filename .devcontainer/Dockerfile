# syntax=docker/dockerfile:1.2
ARG SRCVERSION=17
# update based on https://hub.docker.com/r/dataeditors/stata17/tags
ARG SRCTAG=2023-01-10
ARG SRCHUBID=dataeditors
# update based on https://hub.docker.com/r/rocker/verse/tags
ARG RVERSION=4.2.0
ARG RTYPE=verse

# define the source for Stata
FROM ${SRCHUBID}/stata${SRCVERSION}:${SRCTAG} as stata

# use the source for R

FROM rocker/${RTYPE}:${RVERSION}
COPY --from=stata /usr/local/stata/ /usr/local/stata/
#RUN echo "export PATH=/usr/local/stata:${PATH}" >> /root/.bashrc
ENV PATH "$PATH:/usr/local/stata" 


# The next parts need to be run as root ========================================== ROOT
USER root

# copy the license in so we can do the install of packages
COPY stata.lic /usr/local/stata/stata.lic
RUN chmod a+r /usr/local/stata/stata.lic

# install the gh binaries
RUN \ 
   curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |  dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
   && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list 

# Install packages needed for aea-scripts
#    and
# Stuff we need from the Stata Docker Image
# https://github.com/AEADataEditor/docker-stata/blob/f2c0d52f133a32c6892fe1f67796322390ce7c35/Dockerfile#L15
# We need to redo this here, since we are using the base image from `rocker`. 
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
         locales \
         libncurses5 \
         libfontconfig1 \
         git \
         nano \
         unzip \
         curl \
         pandoc \
         wkhtmltopdf \
         gh \
         rsync \
         python3-pip \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

# install the AEA scripts into /usr/local/sbin
#RUN git clone https://github.com/AEADataEditor/editor-scripts.git /usr/local/bin 

# Install LaTeX packages that are needed

RUN tlmgr install geometry hyperref xcolor subfig epstopdf pdftexcmds infwarerr kvoptions caption epstopdf-pkg

# install rclone
RUN curl https://rclone.org/install.sh | bash

# get latest python requirements
RUN curl https://raw.githubusercontent.com/AEADataEditor/replication-template-development/development/requirements.txt > /requirements.txt \
   && pip install -r /requirements.txt 

# Now switch back to the regular user (rstudio) ================================ REGULAR USER
USER rstudio

# install any packages into the home directory as the user,
COPY setup.do /setup.do
WORKDIR /home/statauser
RUN /usr/local/stata/stata do /setup.do | tee setup.$(date +%F).log
RUN echo "export PATH=/usr/local/stata:\${PATH}" >> /home/rstudio/.bashrc

# install to home
RUN git clone https://github.com/AEADataEditor/editor-scripts.git /home/rstudio/bin 

RUN echo "export PATH=/home/rstudio/bin:/home/rstudio/.local/bin:\${PATH}" >> /home/rstudio/.bashrc



# Configure git to store credentials
# NOTE: do not use this in general, as it stores your credentials!
# NOTE: Create a personal access token specifically for use on Codespaces, 
#       so you can invalidate it if needed!

RUN git config --global credential.helper store

#  then delete the license again - this is not needed on Codespaces but MUST <<<<<<<<<<<<<<<<
#  be done if you intend to publish a Docker image like this one!!
#USER root
#RUN rm /usr/local/stata/stata.lic

# Setup for standard operation
SHELL [ "/bin/bash", "-l", "-c" ]
USER rstudio
#WORKDIR /code

# Setup for Rstudio operation
#USER root
#EXPOSE 8787
#CMD ["/init"]

