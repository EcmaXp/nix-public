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
    ./openssh.nix
    ./pyp.nix
    ./rage.nix
  ];

  home-manager.users.${user} = {
    home.packages = [
      pz
      reloader-py
    ];
  };
}
