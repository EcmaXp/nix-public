{ user, ... }:
{
  imports = [
    # there is no fallback for nix-sync
    # ./fallback.nix
  ];

  home-manager.users.${user} = {
    programs.fish = {
      shellInit = ''
        fish_add_path -gm ~${user}/nix/modules/scripts/desktop/nix/bin
      '';
      shellAbbrs = {
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
