#!/bin/bash
set -e

# =============================================================================
# About
#   Author:         Shyam Yadati <shyam@yadatconsulting.com>
#   Description:    Install script for installing ns-3 on a vm or a real Ubuntu 
#                   machine machine
#   Version:        ns-3.29
#
# References:   
#   NS3 Tutorial:   https://www.nsnam.org/docs/release/3.29/tutorial/singlehtml/index.html
#   NS3 Install:    https://www.nsnam.org/wiki/Installation

# # =============================================================================
# # Environemental setup:
# # Set up dpkg to not run interactively
# ARG DEBIAN_FRONTEND=noninteractive
INSTALL_DIR=${HOME}/opt
mkdir -p ${INSTALL_DIR}
pushd .
cd ${INSTALL_DIR}

# =============================================================================
# Install needed prequisites

# run update
sudo apt-get update

# minimal requirements for C/C++ users (release):
# This is the minimal set of packages needed to run ns-3 from a released
# tarball.
sudo apt-get install -y \
    build-essential \
    gcc \
    g++

# minimal requirements for Python API users (release 3.30, 3.31, and ns-3-dev):
# This is the minimal set of packages needed to work with Python bindings from
# a released tarball.
sudo apt-get install -y \
    python \
    python-dev \
    python3 \
    python3-dev \
    pkg-config \
    sqlite3

# minimal requirements for Python (development):
# For use of ns-3-allinone repository (cloned from Git), additional packages
# are needed to fetch and successfully install pybindgen and netanim.
sudo apt-get install -y \
    python3-setuptools \
    git

# Netanim animator: qt5 development tools are needed for Netanim animator; qt4
# will also work but we have migrated to qt5.
sudo apt-get install -y \
    qt5-default \
    mercurial

# Support for ns-3-pyviz visualizer
sudo apt-get install -y \
    gir1.2-goocanvas-2.0 \
    python-gi \
    python-gi-cairo \
    python3-gi \
    python3-gi-cairo \
    python3-pygraphviz \
    gir1.2-gtk-3.0 \
    ipython3

# Support for MPI-based distributed emulation
sudo apt-get install -y \
    openmpi-bin \
    openmpi-common \
    openmpi-doc \
    libopenmpi-dev

# Support for bake build tool:
sudo apt-get install -y \
    autoconf \
    cvs \
    bzr \
    unrar

# Debugging:
sudo apt-get install -y \
    gdb \
    valgrind

# Support for utils/check-style.py code style check program
sudo apt-get install -y \
    uncrustify

# Doxygen and related inline documentation:
sudo apt-get install -y \
    doxygen \
    graphviz \
    imagemagick
sudo apt-get install -y \
    texlive \
    texlive-extra-utils \
    texlive-latex-extra \
    texlive-font-utils \
    dvipng \
    latexmk

# The ns-3 manual and tutorial are written in reStructuredText for Sphinx
# (doc/tutorial, doc/manual, doc/models), and figures typically in dia
# (also needs the texlive packages above):
sudo apt-get install -y \
    python3-sphinx \
    dia

# GNU Scientific Library (GSL) support for more accurate 802.11b WiFi error
# models (not needed for OFDM):
sudo apt-get install -y \
    gsl-bin \
    libgsl-dev \
    libgsl23 \
    libgslcblas0

# To read pcap packet traces
sudo apt-get install -y \
    tcpdump

# Database support for statistics framework
sudo apt-get install -y \
    sqlite \
    sqlite3 \
    libsqlite3-dev

# Xml-based version of the config store (requires libxml2 >= version 2.7)
sudo apt-get install -y \
    libxml2 \
    libxml2-dev

# Support for generating modified python bindings
sudo apt-get install -y \
    cmake \
    libc6-dev \
    libc6-dev-i386 \
    libclang-6.0-dev \
    llvm-6.0-dev \
    automake \
    python3-pip

sudo -H python3 -m pip install --upgrade pip
sudo -H python3 -m pip install cxxfilt

# A GTK-based configuration system
sudo apt-get install -y \
    libgtk-3-dev

# To experiment with virtual machines and ns-3
sudo apt-get install -y \
    vtun \
    lxc \
    uml-utilities

# Support for openflow module (requires some boost libraries)
if [ "$release" = "Ubuntu 18.04.5 LTS" ]; then
    sudo apt-get install -y \
      libboost-signals-dev \
      libboost-filesystem-dev
else
  sudo apt-get install -y \
      libboost-signals1.67-dev \
      libboost-filesystem1.67-dev
fi

# -------------------------------------
# Add build dependencies for ns3 build
sudo -H python3 -m pip install --upgrade \
    "pygccxml>=1.9.1"
sudo apt-get install -y \
    libgcrypt-dev \
    castxml \
    libdpdk-dev

# -------------------------------------
# install protobufs for ns3-gym
sudo apt-install -y \
    libprotobuf-dev \
    protobuf-compiler    

# install libzmq for ns3-gym
sudo apt install -y \
    libzmq5 \
    libzmq5-dev

# =============================================================================
# Install ns3-gym
# NOTE: See https://www.nsnam.org/releases/ for all available releases
cd ${INSTALL_DIR}

# -------------------------------------
# fetch ns3-gym
git clone https://github.com/tkn-tub/ns3-gym.git
cd ./ns3-gym

# head is broken - the following commit works
git checkout 470362bbf59fb871def89e0b3dc6deb51561baf2

# -------------------------------------
# build ns3-gym
./waf configure
./waf build

# -------------------------------------
# install python package
sudo -H python3 -m pip install ./src/opengym/model/ns3gym