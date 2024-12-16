{ user, lib, ... }: {
  home-manager.users.${user} = {
    home.file = {
      ".nix-fallback/default/scripts/bin" = {
        source = ./bin;
        recursive = true;
      };
      ".nix-fallback/default/scripts/fish" = {
        source = ./fish;
        recursive = true;
      };
    };
  };

  programs.fish = {
    shellInit = lib.mkBefore ''
      fish_add_path -gm ~${user}/.nix-fallback/default/scripts/bin
      for folder in ~${user}/.nix-fallback/default/scripts/bin/*
        if test -d $folder
          fish_add_path -gm $folder
        end
      end

      set --append fish_function_path ~${user}/.nix-fallback/default/scripts/fish
      for folder in ~${user}/.nix-fallback/default/scripts/fish/*
        if test -d $folder
          set --append fish_function_path $folder
        end
      end
    '';
  };
}
