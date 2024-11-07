{ user, ... }: {
  home-manager.users.${user} = {
    programs.mise = {
      enable = true;
      settings = {
        legacy_version_file_disable_tools = [
          "terraform"
        ];
      };
    };
  };
}
