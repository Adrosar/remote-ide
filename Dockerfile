# Podstawowy obraz zapewniający IDE w wersji ONLINE
FROM codercom/code-server

# Instalacja NodeJS:
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

# Pobranie i instalacja GoLang:
RUN curl -O https://dl.google.com/go/go1.20.linux-amd64.tar.gz && sudo tar -C /usr/local -xzf go1.20.linux-amd64.tar.gz && rm go1.20.linux-amd64.tar.gz

# Instalacja pakietów dla GoLang:
RUN /usr/local/go/bin/go install github.com/cweill/gotests/gotests@v1.6.0
RUN /usr/local/go/bin/go install github.com/fatih/gomodifytags@v1.16.0
RUN /usr/local/go/bin/go install github.com/josharian/impl@v1.1.0
RUN /usr/local/go/bin/go install github.com/haya14busa/goplay/cmd/goplay@v1.0.0
RUN /usr/local/go/bin/go install github.com/go-delve/delve/cmd/dlv@latest
RUN /usr/local/go/bin/go install honnef.co/go/tools/cmd/staticcheck@latest
RUN /usr/local/go/bin/go install golang.org/x/tools/gopls@latest

# Dodanie skryptu który modyfikuje PATH podczas startu systemu:
RUN echo export PATH=$HOME/go/bin:/usr/local/go/bin:\$PATH >env.sh && sudo mv ./env.sh /etc/profile.d/env.sh && sudo chmod +x /etc/profile.d/env.sh

# Instalacja dodatków dla VSC:
RUN code-server --install-extension aaron-bond.better-comments
RUN code-server --install-extension esbenp.prettier-vscode
RUN code-server --install-extension golang.Go
RUN code-server --install-extension octref.vetur
RUN code-server --install-extension PKief.material-icon-theme
RUN code-server --install-extension mhutchie.git-graph

# Kopiowanie konfiguracji:
COPY ./assets/server-config.yaml /home/coder/.config/code-server/config.yaml
COPY ./assets/machine-settings.json /home/coder/.local/share/code-server/Machine/settings.json
