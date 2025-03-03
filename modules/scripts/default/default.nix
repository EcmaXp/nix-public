{ user, ... }:
{
  imports = [
    ./fallback.nix
    ./nix
  ];

  programs.fish = {
    shellInit = ''
      fish_add_path -gm ~${user}/nix/modules/default/scripts/bin
      for folder in ~${user}/nix/modules/default/scripts/bin/*
        if test -d $folder
          fish_add_path -gm $folder
        end
      end

      set --append fish_function_path ~${user}/nix/modules/default/scripts/fish
      for folder in ~${user}/nix/modules/default/scripts/fish/*
        if test -d $folder
          set --append fish_function_path $folder
        end
      end
    '';
  };
}
