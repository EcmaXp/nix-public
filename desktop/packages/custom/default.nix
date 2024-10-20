{ user, pkgs, inputs, ... }:
let
  buildArgs = {
    inherit pkgs;
    inherit (inputs.poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryApplication;
  };

  pz = import ./pz.nix buildArgs;
  reloader-py = import ./reloader-py.nix buildArgs;
in
{
  home-manager.users.${user} = {
    home.packages = [
      pz
      reloader-py
    ];
  };
}
