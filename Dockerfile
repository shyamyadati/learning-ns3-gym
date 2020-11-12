FROM ubuntu:18.04
MAINTAINER Shyam Yadati <shyam@yadaticonsulting.com>
LABEL Description="Docker image for ns3-gym"

# =============================================================================
# add ns-3-gym requirements - 
# NOTE: ns-3 is included in ns3-gym, so no need to install it seperately

# set up the environment
ARG DEBIAN_FRONTEND=noninteractive

# -------------------------------------
# install pre-reqs for script
RUN apt-get update

# minimal requirements for C/C++ users (release):
# This is the minimal set of packages needed to run ns-3 from a released
# tarball.
RUN apt-get install -y \
    build-essential \
    gcc \
    g++ \
    python \
    python-dev \
    python3 \
    python3-dev \
    pkg-config \
    python3-setuptools \
    git \
    qt5-default \
    mercurial \
    gir1.2-goocanvas-2.0 \
    python-gi \
    python-gi-cairo \
    python3-gi \
    python3-gi-cairo \
    python3-pygraphviz \
    gir1.2-gtk-3.0 \
    ipython3 \
    openmpi-bin \
    openmpi-common \
    openmpi-doc \
    libopenmpi-dev \
    autoconf \
    cvs \
    bzr \
    unrar \
    gdb \
    valgrind \
    uncrustify \
    doxygen \
    graphviz \
    imagemagick \
    texlive \
    texlive-extra-utils \
    texlive-latex-extra \
    texlive-font-utils \
    dvipng \
    latexmk \
    python3-sphinx \
    dia \
    gsl-bin \
    libgsl-dev \
    libgsl23 \
    libgslcblas0 \
    tcpdump \
    sqlite \
    sqlite3 \
    libsqlite3-dev \
    libxml2 \
    libxml2-dev \
    cmake \
    libc6-dev \
    libc6-dev-i386 \
    libclang-6.0-dev \
    llvm-6.0-dev \
    automake \
    python3-pip \
    libgtk-3-dev \
    vtun \
    lxc \
    uml-utilities \
    libboost-signals-dev \
    libboost-filesystem-dev \
    libgcrypt-dev \
    castxml \
    libdpdk-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libzmq5 \
    libzmq5-dev    


RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install \
    cxxfilt \
    "pygccxml>=1.9.1"


# =============================================================================
# Install ns3-gym
WORKDIR /usr

# -------------------------------------
# fetch ns3-gym
RUN git clone https://github.com/tkn-tub/ns3-gym.git
WORKDIR ./ns3-gym

# head is broken - the following commit works
RUN git checkout 470362bbf59fb871def89e0b3dc6deb51561baf2

# -------------------------------------
# build ns3-gym
RUN ./waf configure
RUN ./waf build

# -------------------------------------
# install python package
RUN python3 -m pip install ./src/opengym/model/ns3gym