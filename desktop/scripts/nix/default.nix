{ user, ... }: {
  home-manager.users.${user} = {
    programs.fish = {
      shellInit = ''
        fish_add_path -gm ~/nix/desktop/scripts/nix/bin
      '';
      shellAbbrs = {
        "nr" = "nix-rebuild";
        "nrf" = "nix-rebuild-forever";
        "ns" = "nix-sync";
        "nsf" = "nix-sync --forever";
        "nsk" = "nix-sync karabiner";
        "nskf" = "nix-sync karabiner --forever";
        "nsl" = "nix-sync launchpad";
        "nslf" = "nix-sync launchpad --forever";
      };
    };
  };
}
