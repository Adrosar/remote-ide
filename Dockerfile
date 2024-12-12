# Podstawowy obraz zapewniający IDE w wersji ONLINE
FROM codercom/code-server:4.95.3-debian

# Instalacja klucza GPG dla źródła Node.js:
RUN sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg && sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

# Stworzenie repozytorium DEB dla Node.js:
RUN NODE_MAJOR=20 && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# Instalacja Node.js:
RUN sudo apt-get update && sudo apt-get install nodejs -y

# Instalacja server "http-server":
RUN sudo /usr/bin/npm install -g http-server

# Pobranie i instalacja GoLang:
RUN curl -O https://dl.google.com/go/go1.23.4.linux-amd64.tar.gz && sudo tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz && rm go1.23.4.linux-amd64.tar.gz

# Instalacja pakietów dla GoLang:
RUN /usr/local/go/bin/go install github.com/cweill/gotests/gotests@v1.6.0
RUN /usr/local/go/bin/go install github.com/fatih/gomodifytags@v1.17.0
RUN /usr/local/go/bin/go install github.com/josharian/impl@v1.4.0
RUN /usr/local/go/bin/go install github.com/haya14busa/goplay/cmd/goplay@v1.0.0
RUN /usr/local/go/bin/go install github.com/go-delve/delve/cmd/dlv@v1.23.1
RUN /usr/local/go/bin/go install honnef.co/go/tools/cmd/staticcheck@v0.5.1
RUN /usr/local/go/bin/go install golang.org/x/tools/gopls@v0.16.2

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

# Kopiowanie przykładowych projektów:
COPY ./examples/example-go /home/coder/workspace/example-go
COPY ./examples/example-js /home/coder/workspace/example-js

# Zapewnienie odpowiednich uprawień do plików:
RUN sudo chown -R coder:coder /home/coder

