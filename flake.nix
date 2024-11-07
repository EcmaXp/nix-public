{
  description = "EcmaXp's nix";

  inputs = {
    # stable
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager-stable.url = "github:nix-community/home-manager/release-24.05";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";
    nix-darwin-stable.url = "github:LnL7/nix-darwin";
    nix-darwin-stable.inputs.nixpkgs.follows = "nixpkgs-stable";
    ragenix-stable.url = "github:yaxitech/ragenix";
    ragenix-stable.inputs.nixpkgs.follows = "nixpkgs-stable";
    poetry2nix-stable.url = "github:nix-community/poetry2nix";
    poetry2nix-stable.inputs.nixpkgs.follows = "nixpkgs-stable";
    krewfile-stable.url = "github:brumhard/krewfile";
    krewfile-stable.inputs.nixpkgs.follows = "nixpkgs-stable";

    # unstable
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager-unstable.url = "github:nix-community/home-manager";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nix-darwin-unstable.url = "github:LnL7/nix-darwin";
    nix-darwin-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
    ragenix-unstable.url = "github:yaxitech/ragenix";
    ragenix-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
    poetry2nix-unstable.url = "github:nix-community/poetry2nix";
    poetry2nix-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
    krewfile-unstable.url = "github:brumhard/krewfile";
    krewfile-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs@{ self, ... }:
    let
      # channels
      stable = {
        inherit self;
        channel = "stable";
        nixpkgs = inputs.nixpkgs-stable;
        nixpkgs-stable = inputs.nixpkgs-stable;
        nixpkgs-unstable = inputs.nixpkgs-unstable;
        home-manager = inputs.home-manager-stable;
        nix-darwin = inputs.nix-darwin-stable;
        ragenix = inputs.ragenix-stable;
        poetry2nix = inputs.poetry2nix-stable;
        krewfile = inputs.krewfile-stable;
      };
      unstable = {
        inherit self;
        channel = "unstable";
        nixpkgs = inputs.nixpkgs-unstable;
        nixpkgs-stable = inputs.nixpkgs-stable;
        nixpkgs-unstable = inputs.nixpkgs-unstable;
        home-manager = inputs.home-manager-unstable;
        nix-darwin = inputs.nix-darwin-unstable;
        ragenix = inputs.ragenix-unstable;
        poetry2nix = inputs.poetry2nix-unstable;
        krewfile = inputs.krewfile-unstable;
      };

      # functions
      buildConfigurations = platform: (
        inputs.nixpkgs-stable.lib.attrsets.mapAttrs
          (name: value: platform (value // { hostname = name; }))
      );
      buildPackages = configurations: (
        inputs.nixpkgs-stable.lib.attrsets.mapAttrs
          (name: value: value.pkgs)
      ) configurations;

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
