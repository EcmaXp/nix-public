{ platform, hostname, user, lib, ... }: {
  home-manager.users.${user} = {
    programs = {
      git = {
        userName = "user";
        userEmail = "user@example.com";
      };
    };
  };
}
