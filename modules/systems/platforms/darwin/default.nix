configuration: user:
{
  self,
  channel,
  platform ? "darwin",
  system ? "aarch64-darwin",
  hostname,
}:
let
  inputs = channel;
  pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
  pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
  sudo = "/usr/bin/sudo";
in
inputs.nix-darwin.lib.darwinSystem {
  specialArgs = {
    inherit
      platform
      system
      hostname
      user
      sudo
      inputs
      pkgs-stable
      pkgs-unstable
      self
      ;
  };
  modules = [
    configuration
    ../default
    ./darwin.nix
    ./homebrew.nix
    ./nix.nix
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-index-database.darwinModules.nix-index
    inputs.ragenix.darwinModules.default
  ];
}
