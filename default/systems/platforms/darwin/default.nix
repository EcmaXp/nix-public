{ self, channel, system ? "aarch64-darwin", hostname, user, modules }:
let
  inputs = channel;
  pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
  pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
  platform = "darwin";
  sudo = "/usr/bin/sudo";
in
inputs.nix-darwin.lib.darwinSystem {
  specialArgs = {
    inherit platform;
    inherit system;
    inherit hostname;
    inherit user;
    inherit sudo;
    inherit inputs;
    inherit pkgs-stable;
    inherit pkgs-unstable;
    inherit self;
  };
  modules = [
    ./darwin.nix
    ./nix.nix
    inputs.home-manager.darwinModules.home-manager
    inputs.ragenix.darwinModules.default
  ] ++ modules;
}
