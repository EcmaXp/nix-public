{ user, pkgs, pkgs-unstable, ... }: {
  home-manager.users.${user} = {
    home.packages = (
      (with pkgs; [
        # nix
        nixpkgs-fmt
        nix-prefetch-scripts

        # shell
        xonsh
        xxh

        # multiplexer
        zellij

        # cli
        asciinema
        bat
        bkt
        btop
        htop
        cheat
        choose
        curlie
        dasel
        difftastic
        dog
        duf
        dust
        dyff
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
        jwt-cli
        lnav
        lzop
        parallel
        pdfgrep
        peco
        procs
        pv
        reflex
        ripgrep
        ripgrep-all
        rq
        rsync
        safe-rm
        sd
        terminal-notifier
        xh
        xz
        yq

        # charmbracelet
        charm
        charm-freeze
        glow
        gum
        markscribe
        melt
        mods
        pop
        skate
        soft-serve
        vhs
        wishlist

        # zip
        lz4
        p7zip
        zstd

        # hash
        b3sum
        xxHash

        # lib
        graphviz

        # doc
        tldr

        # encryption
        age
        age-plugin-yubikey
        gnupg
        pinentry_mac
        rage
        yubico-piv-tool
        yubikey-manager

        # dev
        ast-grep
        capstone
        certstrap
        cfssl
        codeql
        d2
        devbox
        openssl

        # language servers
        nixd
        nil

        # git
        gh
        git
        git-absorb
        git-filter-repo
        git-secrets
        git-standup
        git-town
        lazygit
        pre-commit
        tig

        # db
        mariadb
        mariadb-client
        pgcli
        redis
        sqlcipher
        sqlite
        sqlite-utils
        sqlite-web

        # python
        black
        isort
        mypy
        pipx
        poetry
        pyp
        python313
        ruff
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
        visidata

        # cloud
        act
        aws-iam-authenticator
        aws-vault
        awscli2
        flyctl
        s5cmd
        saml2aws
        spice-gtk
        ssm-session-manager-plugin

        # vm/container
        docker
        docker-client
        lazydocker
        lima

        # hashicorp
        consul
        packer
        terraform
        terraformer
        terragrunt
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
        kubeswitch
        kubetail
        kubie
        kustomize
        minikube
        minio
        skaffold
        stern
        tailspin
        talosctl
        vcluster

        # network
        axel
        caddy
        cloudflared
        dnscrypt-proxy
        doggo
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
      ]) ++ (with pkgs.poetryPlugins; [
        poetry-plugin-export
      ]) ++ (with pkgs.nodePackages; [
        cdk8s-cli
      ]) ++ (with pkgs-unstable; [
        # python
        uv
      ])
    );
  };
}
