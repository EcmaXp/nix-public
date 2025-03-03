{
  description = "EcmaXp's nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixpkgs";
    pyproject-nix.url = "github:nix-community/pyproject.nix";
    pyproject-nix.inputs.nixpkgs.follows = "nixpkgs";
    poetry2nix.url = "github:nix-community/poetry2nix";
    poetry2nix.inputs.nixpkgs.follows = "nixpkgs";
    uv2nix.url = "github:adisbladis/uv2nix";
    uv2nix.inputs.pyproject-nix.follows = "pyproject-nix";
    uv2nix.inputs.nixpkgs.follows = "nixpkgs";
    krewfile.url = "github:brumhard/krewfile";
    krewfile.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      # functions
      buildConfigurations = nixpkgs.lib.attrsets.mapAttrs (
        name: value: value (default // { hostname = name; })
      );
      buildPackages =
        configurations: (nixpkgs.lib.attrsets.mapAttrs (name: value: value.pkgs)) configurations;

      # default
      default = {
        inherit self;
        channel = inputs // {
          nixpkgs-stable = nixpkgs;
        };
      };

      # platforms
      darwin = import ./modules/systems/platforms/darwin;
      nixos = import ./modules/systems/platforms/nixos;

      # configurations
      desktop = ./configurations/desktop;
      server = ./configurations/server;

      # users
      user = "user";
    in
    rec {
      nixosConfigurations = buildConfigurations {
        # server
        "server" = nixos server user;
      };
      darwinConfigurations = buildConfigurations {
        "desktop" = darwin desktop user;
      };
      darwinPackages = buildPackages darwinConfigurations;
    };
}
