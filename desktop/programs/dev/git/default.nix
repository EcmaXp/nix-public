{ platform, user, ... }: {
  home-manager.users.${user} = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      signing.signByDefault = true;
      delta = {
        enable = true;
        # https://github.com/zed-industries/zed/issues/11700
        options.dark = true;
      };
      extraConfig = {
        init.defaultbranch = "main";
        core.excludesfile = "~/nix/desktop/programs/dev/git/git.gitignore";
      } // (if platform == "darwin" then {
        credential.helper = "osxkeychain";
      } else { });
    };
  };
}
