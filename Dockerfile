FROM biohaz/basic_ubuntu:latest

#MAINTAINER BioH4z <https://github.com/BioH4z>

# Set the working directory to /home
WORKDIR /home

# Set shell for conda
SHELL ["/bin/bash", "-c"] 

#set User ROOT
USER root

# config problems about region and time 
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# install libraries and tools
RUN apt-get update \
	&& apt-get install -y zlib1g-dev libbz2-dev liblzma-dev\
	openjdk-8-jdk \
	fastqc samtools

RUN pip install cutadapt==5.2 --break-system-packages
RUN pip install multiqc --break-system-packages

# Donwload other tools create "Tools" folder
RUN mkdir /home/Tools
RUN mkdir /home/Tools/STAR
RUN git clone https://github.com/alexdobin/STAR.git /home/Tools/STAR \
	&& wget -P /home/Tools/ https://sourceforge.net/projects/subread/files/subread-2.0.1/subread-2.0.1-Linux-x86_64.tar.gz \
	&& tar zxvf /home/Tools/subread-2.0.1-Linux-x86_64.tar.gz -C /home/Tools \
	&& rm /home/Tools/subread-2.0.1-Linux-x86_64.tar.gz
