#!/bin/bash

# Installing Docker function
install_docker(){
        apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc docker-buildx podman-docker containerd runc | cut -f1)

        # Add Docker's official GPG key:
        apt update
        apt install -y ca-certificates curl
        install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        chmod a+r /etc/apt/keyrings/docker.asc

        local system_codename
        system_codename=$(lsb_release -cs)
        # Add the repository to Apt s
        tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $system_codename
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
        apt update

        apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

        # Create the docker group
        groupadd -f docker

        # Add your user to the docker group
        usermod -aG docker $SUDO_USER

}

# --- Installing packages via apt install --- #

# Install Curl
if command -v curl >/dev/null 2>&1; then
	echo "curl is already installed"
else
	echo "installing curl ..."
	apt install -y curl
fi

# Install htop
if command -v htop >/dev/null 2>&1; then
	echo "htop is already installed"
else
	echo "Installing htop ..."
	apt install -y htop
fi

# Install git
if command -v git >/dev/null 2>&1; then
	echo "GIT is already installed"
else
	echo "Installing GIT ..." 
	apt install -y git
fi

# Install GCC
if command -v gcc >/dev/null 2>&1; then
	echo "GCC is already installed"
else
	echo "Installing GCC ..."
	apt install -y build-essential
fi

# Install Python3
if command -v python3 >/dev/null 2>&1; then
	echo "python3 is already installed"
else
	echo "Installing Python3 ..."
	apt install -y python3 python3-pip python3-venv
fi

# Install python3-pip
if command -v pip3 >/dev/null 2>&1; then
	echo "pip3 is already installed"
else
	echo "Installing pip3 ..."
	apt install -y python3-pip
fi

# Install Rust and Cargo
if command -v rustc >/dev/null 2>&1 && command -v cargo >/dev/null 2>&1; then
	echo "Rust & Cargo is already installed"
else
	echo "Installing Rust & Cargo ..."
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	source ~/.cargo/env
fi

# Install JDK
if command -v javac >/dev/null 2>&1; then
	echo "JDK is already installed"
else
	echo "Installing OpenJDK 21 ..."
	apt install -y openjdk-21-jdk
fi

# Install Docker --------
if command -v docker >/dev/null 2>&1; then
	echo "Docker $(docker --version) is already installed"
else
	echo "Installing Docker ..."
	install_docker
fi

# Install TMUX
if command -v tmux >/dev/null 2>&1; then
	echo "TMUX is already installed"
else
	echo "Installing TMUX ..."
	apt install -y tmux
fi

# Install flatpak
if command -v flatpak >/dev/null 2>&1; then
	echo "Flatpak is already installed"
else
	echo "installing flatpak"
	apt install -y flatpak	
fi




# --- Installing apps via Flatpak flathub --- #

# Configuring flathub on remotes
# flatpak remote-add --if-not-existis flathub https://flathub.org/repo/flathub.flatpakrepo --> comando com erro
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install Obsidian
flatpak install -y flathub md.obsidian.Obsidian
# Install Discord
flatpak install -y flathub com.discordapp.Discord
# Install VSCode
flatpak install -y flathub com.visualstudio.code
# Install Spotify
flatpak install -y flathub com.spotify.Client
# Install VLC
flatpak install -y flathub org.videolan.VLC
# Install GIMp
flatpak install -y flathub org.gimp.GIMP
# Install  Thunderbird
flatpak install -y flathub org.mozilla.thunderbird
# Install Foliate
flatpak install -y flathub com.github.johnfactotum.Foliate
# Install Brave, Opera GX, Chrome e Firefox
flatpak install -y flathub com.brave.Browser
flatpak install -y flathub com.opera.opera-gx
flatpak install -y flathub com.google.Chrome
flatpak install -y flathub org.mozilla.firefox
# Install Reaper
flatpak install -y flathub fm.reaper.Reaper
