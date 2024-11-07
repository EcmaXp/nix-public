{ user, config, lib, ... }: {
  imports = [
    ./${user}/${user}.nix
    ./fallback.nix
  ];

  age.identityPaths = lib.mkBefore [
    "${config.users.users.${user}.home}/.ssh/id_machine"
  ];

  programs.fish = {
    enable = true;
    shellInit = ''
      fish_add_path -gm ~${user}/nix/desktop/users/${user}/scripts/bin
      for folder in ~${user}/nix/desktop/users/${user}/scripts/bin/*
        if test -d $folder
          fish_add_path -gm $folder
        end
      end

      set --append fish_function_path ~${user}/nix/desktop/users/${user}/scripts/fish
      for folder in ~${user}/nix/desktop/users/${user}/scripts/fish/*
        if test -d $folder
          set --append fish_function_path $folder
        end
      end
    '';
  };
}
