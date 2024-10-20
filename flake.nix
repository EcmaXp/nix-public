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

      # platforms
      darwin = (
        { channel, system ? "aarch64-darwin", modules, user }:
        let
          inputs = channel;
          pkgs = import inputs.nixpkgs { inherit system; };
          pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
          pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
          platform = "darwin";
          hostname = (
            builtins.readFile (pkgs.runCommand "hostname" { } ''
              /usr/sbin/scutil --get LocalHostName | /usr/bin/tr -d '\n' > $out
            '').outPath
          );
        in
        inputs.nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit platform;
            inherit system;
            inherit hostname;
            inherit user;
            inherit inputs;
            inherit pkgs-stable;
            inherit pkgs-unstable;
            inherit self;
          };
          inherit modules;
        }
      );

      # profiles
      desktop = {
        channel = stable;
        modules = [
          ./default
          ./desktop
        ];
      };
      user = desktop // {
        user = "user";
      };
    in
    {
      darwinConfigurations = {
        "host" = darwin user;
      };
      darwinPackages = (darwin user).pkgs;
    };
}
