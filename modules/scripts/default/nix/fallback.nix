{ user, lib, ... }:
{
  home-manager.users.${user} = {
    home.file = {
      ".nix-fallback/modules/default/scripts/nix/bin" = {
        source = ./bin;
        recursive = true;
      };
    };

    programs.fish = {
      shellInit = lib.mkBefore ''
        fish_add_path -gm ~${user}/.nix-fallback/modules/default/scripts/nix/bin
      '';
    };
  };
}
