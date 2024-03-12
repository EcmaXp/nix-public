{ user, lib, pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellInit = ''
      /opt/homebrew/bin/brew shellenv | source
      fish_add_path -gp ~/.local/bin
      fish_add_path -gp ~/.asdf/shims
      fish_add_path -gp ~/.krew/bin
      fish_add_path -gp ~/.cargo/bin
      fish_add_path -gp ~/go/bin
      fish_add_path -gp "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
      for nix_profile in (string split " " $NIX_PROFILES)
        fish_add_path -gm $nix_profile/bin
      end
    '';
  };

  home-manager.users.${user} = {
    programs.fish = {
      interactiveShellInit = ''
        source {$HOME}/.iterm2_shell_integration.fish
      '';
      shellAbbrs = {
        # nix-darwin
        "nr" = "darwin-rebuild switch --flake ~/nix";
        "nhr" = "ls ~/nix/**.nix | entr darwin-rebuild switch --flake ~/nix";
        "ni" = "nix repl --expr '{ nix = builtins.getFlake (toString ~/nix); }'";
      };
      functions = {
        __fish_command_not_found_handler = {
          body = "~/.local/bin/nix-command-not-found $argv";
          onEvent = "fish_command_not_found";
        };
      };
    };

    home.file.".local/bin/nix-command-not-found" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
        command_not_found_handle "$@"
      '';
    };
  };
}
