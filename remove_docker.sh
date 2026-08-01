
remover_docker_completo() {
    echo "Removendo o Docker completamente do sistema..."
    sudo systemctl stop docker.socket docker 2>/dev/null
    sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker.io docker-doc docker-compose docker-compose-v2
    sudo apt-get autoremove -y --purge
    sudo rm -rf /var/lib/docker /var/lib/containerd
    sudo rm -f /etc/apt/keyrings/docker.asc /etc/apt/sources.list.d/docker.list /etc/apt/sources.list.d/docker.sources
    sudo groupdel docker 2>/dev/null
    sudo apt update
    echo "Docker e todos os seus dados foram apagados!"
}


# 1. Remove os arquivos e travas antigas
sudo rm -f /etc/apt/sources.list.d/docker*

# 1.1. Limpa os arquivos de cache locais do APT que guardam o erro
sudo rm -rf /var/lib/apt/lists/*docker*

# 2. Descobre o codinome puro do seu sistema e valida na tela
CODENAME=$(lsb_release -cs)
echo "A versão detectada do seu Ubuntu é: $CODENAME"

# 3. Cria o arquivo usando o formato tradicional de linha única (evita erros do tee)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $CODENAME stable" | sudo tee /etc/apt/sources.list.d/docker.list

# 4. Limpa o cache antigo do APT e atualiza
sudo apt-get clean
sudo apt update




remover_docker_completo


