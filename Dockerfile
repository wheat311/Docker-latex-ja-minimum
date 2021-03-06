FROM ubuntu:latest
LABEL maintainer "wheat311<kawa.jnra415@gmail.com>"

# ja-locale setup
RUN apt-get update && \
    apt-get -y install wget perl-modules
ENV TERM xterm-256color

# install texlive
COPY texlive.profile .
RUN wget http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar xvf install-tl-unx.tar.gz && \
	rm install-tl-unx.tar.gz && \
    install-tl-*/install-tl -no-gui -profile texlive.profile && \
    rm -rf install-tl-* texlive.profile && \
	/usr/local/texlive/????/bin/*/tlmgr path add && \
    tlmgr install latexmk && \
    tlmgr path add && \
    apt-get -y remove wget && \
    apt-get -y autoremove && \
    apt-get -y clean

# normal user setup
ENV USER latexer
ENV HOME /home/${USER}
ENV SHELL /bin/bash

RUN useradd -m ${USER}

USER ${USER}
WORKDIR ${HOME}
