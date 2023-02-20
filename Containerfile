FROM docker.io/debian:11.3
LABEL authors="Kosmas Hench" \
      description="Bundle of the conda environments for the msa_pipeline"

# setting up conda
RUN apt update && apt install -y wget procps
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh && \
    bash Miniconda3-py39_4.12.0-Linux-x86_64.sh -b -p /miniconda

ENV PATH ${PATH}:/miniconda/bin

# install mamba for fast installation and set up channels
RUN conda install mamba -y -n base -c conda-forge
RUN conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge

# install packages available via conda
COPY envs/*.yaml /
RUN mamba env create -f /align.yaml && conda clean -a
RUN mamba env create -f /bedtools.yaml && conda clean -a
RUN mamba env create -f /biopython.yaml && conda clean -a
RUN mamba env create -f /mashtree.yaml && conda clean -a
RUN mamba env create -f /phast.yaml && conda clean -a
RUN mamba env create -f /roast.yaml && conda clean -a
RUN mamba env create -f /split.yaml && conda clean -a
RUN mamba env create -f /ucsc.yaml && conda clean -a
# ENV PATH ${PATH}:/miniconda/envs/msa_envs-0.1/bin

# Initialize conda in bash config fiiles:
RUN conda init bash
