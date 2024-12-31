{ pkgs, user, ... }:
{
  imports = [
    ./aliases
  ];

  environment.variables = {
    EDITOR = "micro";
  };

  environment.shells = with pkgs; [
    bash
    zsh
    fish
  ];

  programs.fish = {
    enable = true;
  };

  users.users.${user} = {
    shell = pkgs.fish;
  };

  home-manager.users.${user} = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting
      '';
    };

    programs.nushell = {
      envFile.text = ''
        $env.config = {
          show_banner: false,
        }
      '';
    };
  };
}
