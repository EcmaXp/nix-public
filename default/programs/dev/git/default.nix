{ user, ... }:
{
  home-manager.users.${user} = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      extraConfig = {
        init.defaultbranch = "main";
        core.excludesfile = "~/.gitignore";
      };
    };

    home.file = {
      ".gitignore" = {
        source = ./git.gitignore;
      };
    };
  };
}
