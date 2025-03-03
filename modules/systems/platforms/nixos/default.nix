configuration: user:
{
  self,
  channel,
  platform ? "nixos",
  system ? "x86_64-linux",
  hostname,
}:
let
  inputs = channel;
  pkgs = import inputs.nixpkgs { inherit system; };
  pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
  pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
  sudo = "${pkgs.sudo}/bin/sudo";
in
inputs.nixpkgs.lib.nixosSystem {
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
    ./nix.nix
    ./nixos.nix
    ./terminfo.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
    inputs.ragenix.nixosModules.default
  ];
}
