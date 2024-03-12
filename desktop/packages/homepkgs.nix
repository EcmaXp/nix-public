{ platform, user, pkgs, lib, ... }: {
  home-manager.users.${user} = {
    home.packages = (
      (with pkgs; [
        # nix
        nixpkgs-fmt

        # shell
        xonsh
        xxh

        # gui
        kdiff3
        slack
        wireshark
        zoom-us

        # cli
        asciinema
        bat
        btop
        cheat
        choose
        curlie
        dasel
        difftastic
        dog
        duf
        dust
        entr
        exif
        eza
        fclones
        fd
        ffmpeg
        fq
        fswatch
        fx
        gnused
        gron
        grpcurl
        hexyl
        httpie
        hyperfine
        igrep
        jc
        jless
        jo
        jq
        jsonnet
        lnav
        lzop
        parallel
        pdfgrep
        peco
        procs
        pv
        reflex
        ripgrep
        rq
        rsync
        safe-rm
        sd
        terminal-notifier
        xh
        xz
        yq

        # charm
        charm
        charm-freeze
        gum
        melt
        mods
        pop
        soft-serve
        vhs
        wishlist

        # zip
        lz4
        p7zip
        xxHash
        zstd

        # lib
        graphviz

        # doc
        tldr

        # encryption
        age
        age-plugin-yubikey
        gnupg
        rage
        yubico-piv-tool
        yubikey-manager

        # dev
        asdf-vm
        ast-grep
        capstone
        certstrap
        cfssl
        codeql
        devbox
        gh
        git
        git-filter-repo
        git-secrets
        git-town
        lazygit
        openssl
        pre-commit
        tig

        # db
        mysql
        mysql-client
        # pgcli  # TODO: enable after gssapi fixed
        redis
        sqlcipher
        sqlite
        sqlite-utils
        sqlite-web

        # python
        black
        mypy
        pipx
        poetry
        python312
        ruff
        uv
        virtualenv

        # language
        go
        lua
        nodejs_20
        protobuf
        rustc
        rustpython
        rustup
        yarn

        # AI
        lima
        llm
        ollama

        # Data
        datasette
        # visidata  # TODO: enable after gssapi fixed

        # cloud
        act
        aws-iam-authenticator
        aws-vault
        awscli2
        flyctl
        saml2aws
        spice-gtk
        ssm-session-manager-plugin

        # continaer
        docker
        docker-client
        lazydocker

        # hashicorp
        consul
        terraform
        tfswitch
        vault

        # kubernetes
        argocd
        cilium-cli
        cmctl
        cri-tools
        eksctl
        func
        infracost
        istioctl
        k3d
        k6
        k9s
        kind
        kn
        krew
        kube-linter
        kubeconform
        kubectl
        kubectx
        kubent
        kubergrunt
        kubernetes-helm
        kubeshark
        kubetail
        kubie
        kustomize
        minikube
        minio
        skaffold
        stern
        tailspin
        vcluster

        # network
        axel
        caddy
        cloudflared
        dnscrypt-proxy
        iperf3
        minicom
        nmap
        oha
        trippy
        wireguard-go
        wireguard-tools
      ]) ++ (with pkgs.python312Packages; [
        pip
        ipython
        keyring
      ]) ++ (with pkgs.nodePackages; [
        cdk8s-cli
      ]) ++ (if platform == "darwin" then with pkgs; [
        # gui
        alt-tab-macos
        bartender
        keka

        # cli
        mas
      ] else [ ])
    );
  };
}
