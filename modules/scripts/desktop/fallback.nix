{ user, lib, ... }:
{
  home-manager.users.${user} = {
    home.file = {
      ".nix-fallback/modules/scripts/desktop/bin" = {
        source = ./bin;
        recursive = true;
      };
      ".nix-fallback/modules/scripts/desktop/fish" = {
        source = ./fish;
        recursive = true;
      };
    };
  };

  programs.fish = {
    shellInit = lib.mkBefore ''
      fish_add_path -gm ~${user}/.nix-fallback/modules/scripts/desktop/bin
      for folder in ~${user}/.nix-fallback/modules/scripts/desktop/bin/*
        if test -d $folder
          fish_add_path -gm $folder
        end
      end

      set --append fish_function_path ~${user}/.nix-fallback/modules/scripts/desktop/fish
      for folder in ~${user}/.nix-fallback/modules/scripts/desktop/fish/*
        if test -d $folder
          set --append fish_function_path $folder
        end
      end
    '';
  };
}
