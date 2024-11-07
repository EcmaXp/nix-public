{ user, lib, sudo, ... }:
let
  fallbackPath = ".nix-fallback/desktop/programs/shells/plugins/starship";
  sourcePath = "~${user}/nix/desktop/programs/shells/plugins/starship";
  targetPath = "~${user}/.config/fish";
  mkSymlink = filename: ''
    ${sudo} -u ${user} ln -sf ${sourcePath}/${filename} ${targetPath}/${filename}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${sudo} -u ${user} mkdir -p ${targetPath}
        ${mkSymlink "async-starship.fish"}
      '';
    };
  };

  home-manager.users.${user} = {
    home.file = {
      "${fallbackPath}/async-starship.fish" = {
        source = ./async-starship.fish;
      };
    };

    programs.fish = {
      interactiveShellInit = ''
        if test -f ${targetPath}/async-starship.fish
          source ${targetPath}/async-starship.fish
        else
          source ~${user}/${fallbackPath}/async-starship.fish
        end
      '';
    };
    programs.starship = {
      enable = true;
      settings = {
        format = lib.concatStrings [
          "$line_break"
          "$shell"
          "$shlvl"
          "$direnv"
          "$all"
          "$time"
          "$cmd_duration"
          "$status"
          "$line_break"
          "$directory"
          "$character"
        ];
        add_newline = false;
        profiles = {
          "directory" = lib.concatStrings [
            "$directory"
            "$character"
          ];
        };
        shell = {
          disabled = false;
          fish_indicator = "fish";
          xonsh_indicator = "xonsh";
        };
        shlvl = {
          disabled = false;
        };
        direnv = {
          disabled = false;
          format = "[$symbol$loaded$allowed]($style)";
          allowed_msg = "";
          not_allowed_msg = "not allowed ";
          denied_msg = "denied ";
          loaded_msg = "";
          unloaded_msg = "not loaded/";
        };
        status = {
          format = "[$symbol $status]($style) ";
          disabled = false;
        };
        time = {
          disabled = false;
        };
        directory = {
          truncation_length = 5;
          truncation_symbol = "…/";
          fish_style_pwd_dir_length = 1;
        };
        package = {
          disabled = true;
        };
        aws = {
          region_aliases = {
            "ap-southeast-1" = "apse1 (Singapore)";
            "ap-northeast-1" = "apne1 (Tokyo)";
            "ap-northeast-2" = "apne2 (Seoul)";
            "us-east-1" = "usea1 (Virginia)";
            "us-west-2" = "uswe2 (Oregon)";
          };
        };
        kubernetes = {
          disabled = false;
          format = "([$symbol$context( \\($namespace\\))]($style) )";
          contexts = [
            {
              context_pattern = "(docker-desktop|orbstack)";
              context_alias = "";
              symbol = "";
            }
          ];
        };
        # optimize performance
        python = {
          disabled = true;
        };
        git_status = {
          ignore_submodules = true;
        };
      };
    };
  };
}
