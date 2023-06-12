# Podstawowy obraz zapewniający IDE w wersji ONLINE
FROM codercom/code-server

# Instalacja Node.js 16.x
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

# Pobranie i instalacja Go 1.20
RUN curl -O https://dl.google.com/go/go1.20.linux-amd64.tar.gz
RUN sudo tar -C /usr/local -xzf go1.20.linux-amd64.tar.gz
RUN rm go1.20.linux-amd64.tar.gz

# Dodanie ścieżek do PATH
RUN echo export PATH=/usr/local/go/bin:\$PATH >env.sh && sudo mv ./env.sh /etc/profile.d/env.sh && sudo chmod +x /etc/profile.d/env.sh
