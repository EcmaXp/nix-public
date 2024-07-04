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

    # unstable
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager-unstable.url = "github:nix-community/home-manager";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nix-darwin-unstable.url = "github:LnL7/nix-darwin";
    nix-darwin-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
    ragenix-unstable.url = "github:yaxitech/ragenix";
    ragenix-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs@{ self, ... }:
    let
      # platform
      darwin = import ./desktop/darwin.nix;

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
      };

      # systems
      aarch64-darwin = "aarch64-darwin";

      # profiles
      desktop = import ./desktop/desktop.nix;

      # users
      user = { user = "user"; };
    in
    {
      darwinConfigurations = rec {
        "hostname" = darwin stable aarch64-darwin desktop user;
      };
      darwinPackages = (darwin stable aarch64-darwin desktop user).pkgs;
    };
}
