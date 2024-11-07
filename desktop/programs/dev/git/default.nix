{ platform, user, ... }: {
  home-manager.users.${user} = {
    programs.git = {
      signing.signByDefault = true;
      delta = {
        enable = true;
        # https://github.com/zed-industries/zed/issues/11700
        options.dark = true;
      };
      extraConfig = (if platform == "darwin" then {
        credential.helper = "osxkeychain";
      } else { });
    };
  };
}
