args@{ user, pkgs, ... }:
let
  buildArgs = args // {
    inherit pkgs;
  };

  pz = import ./pz.nix buildArgs;
  reloader-py = import ./reloader-py.nix buildArgs;
in
{
  imports = [
    ./pyp.nix
    ./rage.nix
    ./toolgit.nix
  ];

  home-manager.users.${user} = {
    home.packages = [
      pz
      reloader-py
    ];
  };
}
