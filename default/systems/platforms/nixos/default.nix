{
  self,
  channel,
  system ? "x86_64-linux",
  hostname,
  user,
  modules,
}:
let
  inputs = channel;
  pkgs = import inputs.nixpkgs { inherit system; };
  pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
  pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
  platform = "nixos";
  sudo = "${pkgs.sudo}/bin/sudo";
in
inputs.nixpkgs.lib.nixosSystem {
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
    ./nix.nix
    ./nixos.nix
    ./terminfo.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
    inputs.ragenix.nixosModules.default
  ] ++ modules;
}
