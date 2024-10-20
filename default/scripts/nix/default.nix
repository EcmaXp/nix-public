{ user, ... }: {
  home-manager.users.${user} = {
    programs.fish = {
      shellInit = ''
        fish_add_path -gm ~/nix/default/scripts/nix/bin
      '';
      shellAbbrs = {
        "ni" = "nix-repl";
      };
    };
  };
}
