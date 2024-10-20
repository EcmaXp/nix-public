{ user, ... }: {
  programs.fish = {
    enable = true;
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
