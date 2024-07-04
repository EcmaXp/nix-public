{ platform, user, pkgs, lib, inputs, ... }:
let
  home = {
    linux = "/home/${user}";
    darwin = "/Users/${user}";
  }.${platform};
in
{
  imports = [
    ./${user}/${user}.nix
  ] ++ (if platform == "darwin" then [
    inputs.home-manager.darwinModules.home-manager
  ] else [ ]);

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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${user} = {
      home.stateVersion = "24.05";

      programs = {
        home-manager.enable = true;
      };
    };
  };
}
