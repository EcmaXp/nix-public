{ user, lib, ... }:
{
  home-manager.users.${user} = {
    home.file = {
      ".nix-fallback/desktop/users/${user}/scripts/bin" = {
        source = ./${user}/scripts/bin;
        recursive = true;
      };
      ".nix-fallback/desktop/users/${user}/scripts/fish" = {
        source = ./${user}/scripts/fish;
        recursive = true;
      };
    };
  };

  programs.fish = {
    shellInit = lib.mkBefore ''
      fish_add_path -gm ~${user}/.nix-fallback/desktop/users/${user}/scripts/bin
      for folder in ~${user}/.nix-fallback/desktop/users/${user}/scripts/bin/*
        if test -d $folder
          fish_add_path -gm $folder
        end
      end

      set --append fish_function_path ~${user}/.nix-fallback/desktop/users/${user}/scripts/fish
      for folder in ~${user}/.nix-fallback/desktop/users/${user}/scripts/fish/*
        if test -d $folder
          set --append fish_function_path $folder
        end
      end
    '';
  };
}