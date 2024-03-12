{ platform, user, ... }: {
  home-manager.users.${user} = {
    programs.git = {
      enable = true;
      signing.signByDefault = true;
      delta.enable = true;
      extraConfig = {
        init.defaultbranch = "main";
        core.excludesfile = "~/nix/desktop/programs/dev/git/git.gitignore";
      } // (if platform == "darwin" then {
        credential.helper = "osxkeychain";
      } else { });
    };
  };
}
