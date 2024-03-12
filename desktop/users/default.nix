{ platform, user, pkgs, lib, ... }:
let
  home = {
    linux = "/home/${user}";
    darwin = "/Users/${user}";
  }.${platform};
in
{
  imports = [
    ./home-manager.nix
    ./${user}/${user}.nix
  ];

  users.users = {
    ${user} = {
      inherit home;
      shell = pkgs.fish;
    };
  };

  environment.shells = with pkgs; [
    zsh
    fish
  ];

  environment.variables = {
    EDITOR = "micro";
    RUNEWIDTH_EASTASIAN = "0";
  };
}
