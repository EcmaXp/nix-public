{ pkgs ? import <nixpkgs> { }, mkPoetryApplication }: mkPoetryApplication {
  projectDir = pkgs.fetchFromGitHub {
    owner = "EcmaXp";
    repo = "reloader.py";
    rev = "0.14.3";
    sha256 = "1qxyv00f8kdwa06g53zv4i023an5kkln2qiy0z125n0rklpwc0hc"; # 0.14.3
  };
}
