{ user, lib, pkgs, ... }: {
  programs.fish.enable = true;

  home-manager.users.${user} = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting
      '';
      shellAliases = {
        "rm" = "safe-rm -i";
        "unlink" = "safe-rm -i";
        "ls" = "eza";
        "cat" = "bat";
        "top" = "btop";
        "df" = "duf";
        "du" = "dust";
        "diff" = "difft";
        "hexdump" = "hexyl";
        "edit" = "$EDITOR";
        "age" = "rage";
      };
      shellAbbrs = {
        # aws
        "a" = "aws";

        # terraform
        "tf" = "terraform";
        "tfp" = "terraform plan";
        "tfa" = "terraform apply";

        # kubernetes
        "k" = "kubectl";
        "kc" = "kubectx";
        "kn" = "kubens";

        # dasel
        "dq" = "dasel";

        # git
        "lg" = "lazygit";
        # https://www.rockyourcode.com/my-git-aliases-and-abbreviations/
        "g" = "git";
        "ga" = "git add";
        "gadn" = "git add . && git diff --cached";
        # interactive git add
        "gai" = "git add -i";
        # git add --patch
        "gap" = "git add -p";
        "gapn" = "git add --intent-to-add . && git add --patch";
        "gbr" = "git branch";
        "gc" = "git commit";
        "gca" = "git commit --amend";
        "gcm" = "git commit -m";
        "gco" = "git checkout";
        "gd" = "git pull";
        # git diff
        "gdf" = "git df";
        "gdif" = "git diff";
        "gdoc" = "git doc";
        "gfom" = "git fetch origin master";
        "gft" = "git fetch";
        "gfu" = "git fetch upstream";
        # git --intent-to-add
        "gin" = "git add -N .";
        "glst" = "git last";
        "gmg" = "git merge";
        "gnew" = "git new";
        "gp" = "git push";
        "gpl" = "git pull";
        "gpo" = "git pull origin";
        "gpu" = "git pull upstream";
        "grb" = "git rebase";
        "grs" = "git reset";
        "gst" = "git status -sb";
        "gsw" = "git switch";

        # igrep
        "igrep" = "ig";
      };
    };

    programs.bash.enable = true;
    programs.zsh.enable = true;
    programs.nushell = {
      enable = true;
      envFile.text = ''
        $env.config = {
          show_banner: false,
        }
      '';
    };
  };
}
