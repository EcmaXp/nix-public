{ user, ... }: {
  imports = [
    ./${user}/${user}.nix
  ];

  environment.variables = {
    RUNEWIDTH_EASTASIAN = "0";
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      fish_add_path -gm ~/nix/desktop/users/${user}/scripts/bin
      for folder in ~/nix/desktop/users/${user}/scripts/bin/*
        if test -d $folder
          fish_add_path -gm $folder
        end
      end

      set --append fish_function_path ~/nix/desktop/users/${user}/scripts/fish
      for folder in ~/nix/desktop/users/${user}/scripts/fish/*
        if test -d $folder
          set --append fish_function_path $folder
        end
      end
    '';
  };
}
