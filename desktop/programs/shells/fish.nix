{ user, lib, pkgs, ... }:
let
  sourcePath = "~${user}/nix/desktop/programs/shells";
  targetPath = "~${user}/.config/fish";
  mkSymlink = filename: ''
    sudo -u ${user} ln -sf ${sourcePath}/${filename} ${targetPath}/${filename}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        mkdir -p ${targetPath}
        ${mkSymlink "kubectl_aliases.fish"}
      '';
    };
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      /opt/homebrew/bin/brew shellenv | source
      fish_add_path -gm "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
      for nix_profile in (string split " " $NIX_PROFILES)
        fish_add_path -gm $nix_profile/bin
      end
      fish_add_path -gm ~/.dotnet/tools
      fish_add_path -gm ~/.krew/bin
      fish_add_path -gm ~/.cargo/bin
      fish_add_path -gm ~/go/bin
      fish_add_path -gm ~/.asdf/shims
      fish_add_path -gm ~/.local/bin
    '';
  };

  home-manager.users.${user} = {
    programs.fish = {
      interactiveShellInit = ''
        source ${targetPath}/kubectl_aliases.fish
        source {$HOME}/.iterm2_shell_integration.fish
        # map hyper-caps_lock on kitty
        bind \e\[114\;6u 'zi ; commandline -f repaint'
        bind \e\[12593\;6u 'zi ; commandline -f repaint'
        # map hyper-caps_lock on zed
        bind \e\[24\;1~ 'zi ; commandline -f repaint'
      '';
      shellAbbrs = {
        # nix-darwin
        "nr" = "darwin-rebuild switch --flake ~/nix";
        "nrf" = "ls ~/nix/**.nix | entr darwin-rebuild switch --flake ~/nix";
        "ns" = "pushd ~/nix; poetry run sync; popd";
        "nsf" = "pushd ~/nix; poetry run sync --forever; popd";
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
