{ platform, config, user, lib, ... }: {
  imports = [
    ./secrets
  ];

  home-manager.users.${user} = {
    programs = {
      git = {
        userName = "user";
        userEmail = "user@example.com";
      };
    };
  };
} // (if platform == "darwin" then {
  system.defaults = {
    loginwindow = {
      LoginwindowText = lib.strings.concatLines [
        config.networking.hostName
        "user@example.com"
      ];
    };
  };
} else { })
