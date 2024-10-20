{ ... }: {
  imports = [
    ./nix
  ];

  programs.fish = {
    enable = true;
    shellInit = ''
      fish_add_path -gm ~/nix/default/scripts/bin
      for folder in ~/nix/default/scripts/bin/*
        if test -d $folder
          fish_add_path -gm $folder
        end
      end

      set --append fish_function_path ~/nix/default/scripts/fish
      for folder in ~/nix/default/scripts/fish/*
        if test -d $folder
          set --append fish_function_path $folder
        end
      end
    '';
  };
}
