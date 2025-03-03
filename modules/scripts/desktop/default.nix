{ user, ... }:
{
  imports = [
    ./fallback.nix
    ./nix
  ];

  programs.fish = {
    shellInit = ''
      fish_add_path -gm ~${user}/nix/modules/scripts/desktop/bin
      for folder in ~${user}/nix/modules/scripts/desktop/bin/*
        if test -d $folder
          fish_add_path -gm $folder
        end
      end

      set --append fish_function_path ~${user}/nix/modules/scripts/desktop/fish
      for folder in ~${user}/nix/modules/scripts/desktop/fish/*
        if test -d $folder
          set --append fish_function_path $folder
        end
      end
    '';
  };
}
