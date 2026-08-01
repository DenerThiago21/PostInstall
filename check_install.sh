#!/bin/bash

# --- Installin packages via apt install --- #


# Install git
if command -v git >/dev/null 2>&1; then
	echo "GIT is installed"
else
	echo "Installing GIT ..." 
fi 

# Install GCC
if command -v gcc >/dev/null 2>&1; then
	echo "GCC is installed"
else
	echo "Installing GCC ..."
fi

# Install Python3
if command -v python3 >/dev/null 2>&1; then
	echo "python3 is installed"
else
	echo "Installing Python3 ..."
fi

# Install python3-pip
if command -v pip3 >/dev/null 2>&1; then
	echo "pip3 is installed"
else
	echo "Installing pip3 ..."
fi

# Install Rust and Cargo
if command -v rustc >/dev/null 2>&1 && command -v cargo >/dev/null 2>&1; then
	echo "Rust & Cargo is installed"
else
	echo "Installing Rust & Cargo ..."
fi

# Install JDK
if command -v javac >/dev/null 2>&1; then
	echo "JDK is installed"
else
	echo "Installing OpenJDK 21 ..."
fi

# Install Docker
if command -v docker >/dev/null 2>&1; then
	echo "Docker $(docker --version) is installed"
else
	echo "Installing Docker ..."
fi

# Install TMUX
if command -v tmux >/dev/null 2>&1; then
	echo "TMUX is installed"
else
	echo "Installing TMUX ..."
fi

