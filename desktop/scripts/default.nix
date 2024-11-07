{ user, ... }: {
  imports = [
    ./fallback.nix
    ./nix
  ];

  programs.fish = {
    enable = true;
    shellInit = ''
      fish_add_path -gm ~${user}/nix/desktop/scripts/bin
      for folder in ~${user}/nix/desktop/scripts/bin/*
        if test -d $folder
          fish_add_path -gm $folder
        end
      end

      set --append fish_function_path ~${user}/nix/desktop/scripts/fish
      for folder in ~${user}/nix/desktop/scripts/fish/*
        if test -d $folder
          set --append fish_function_path $folder
        end
      end
    '';
  };
}
