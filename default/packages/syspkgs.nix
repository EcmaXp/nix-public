{ platform, pkgs, ... }:
{
  environment.systemPackages =
    (with pkgs; [
      # classic tools
      file
      hostname
      screen
      tree
      watch
      wget

      # editor
      micro
      nano
      vim

      # network
      inetutils

      # dev
      git
    ])
    ++ (
      if platform == "darwin" then
        # NixOS pkgs for nix-darwin
        # https://github.com/NixOS/nixpkgs/blob/23.11/nixos/modules/config/system-path.nix
        with pkgs;
        [
          bashInteractive
          bzip2
          coreutils-full
          cpio
          curl
          diffutils
          findutils
          gawk
          stdenv.cc.libc
          getent
          getconf
          gnugrep
          gnupatch
          gnused
          gnutar
          gzip
          xz
          less
          ncurses
          netcat
          openssh
          procps
          time
          util-linux
          which
          zstd

          # Darwin unsupported
          # acl
          # attr
          # libcap
          # mkpasswd
          # su
        ]
      else
        [ ]
    );
}
