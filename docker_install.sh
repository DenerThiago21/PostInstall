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

# --- Installin packages via apt install --- #

# Install Docker --------
if command -v docker >/dev/null 2>&1; then
	echo "Docker $(docker --version) is already installed"
else
	echo "Installing Docker ..."
	install_docker
	# Add your user to the docker group
	# usermod -aG docker $USER
fi
