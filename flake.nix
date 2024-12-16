{
  description = "EcmaXp's nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
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

  outputs = inputs@{ self, ... }:
    let
      # functions
      buildConfigurations = platform: (
        stable.nixpkgs.lib.attrsets.mapAttrs
          (name: value: platform (value // { hostname = name; }))
      );
      buildPackages = configurations: (
        unstable.nixpkgs.lib.attrsets.mapAttrs
          (name: value: value.pkgs)
      ) configurations;

      # channels
      stable = inputs // (with inputs; {
        nixpkgs-stable = nixpkgs;
      });
      unstable = stable // (with inputs; {
        nixpkgs = nixpkgs-unstable;
      });

      # platforms
      nixos = import ./default/systems/platforms/nixos;
      darwin = import ./default/systems/platforms/darwin;

      # profiles
      default = {
        inherit self;
        channel = stable;
        modules = [
          ./default
        ];
      };
      orbstack = default // {
        system = "aarch64-linux";
        modules = default.modules ++ [
          ./default/systems/vendors/orbstack
        ];
      };
      desktop = default // {
        modules = default.modules ++ [
          ./desktop
        ];
      };
      user = {
        user = "user";
      };
    in
    rec {
      nixosConfigurations = buildConfigurations nixos {
        "host" = orbstack // user;
      };
      darwinConfigurations = buildConfigurations darwin {
        "host" = desktop // user;
      };
      darwinPackages = buildPackages darwinConfigurations;
    };
}
