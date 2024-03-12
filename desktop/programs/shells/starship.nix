{ user, lib, ... }: {
  home-manager.users.${user} = {
    programs.starship = {
      enable = true;
      settings = {
        format = lib.concatStrings [
          "$shell"
          "$shlvl"
          "$direnv"
          "$all"
          "$status"
          "$line_break"
          "$directory"
          "$character"
        ];
        add_newline = true;
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
        };
        status = {
          format = "[$symbol $status]($style) ";
          disabled = false;
        };
        directory = {
          truncation_length = 5;
          truncation_symbol = "…/";
          fish_style_pwd_dir_length = 1;
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
          format = "[$symbol$context( ($namespace))]($style) ";
        };
      };
    };
  };
}
