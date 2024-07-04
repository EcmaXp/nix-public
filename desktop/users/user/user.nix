{ platform, hostname, user, lib, ... }: {
  environment.variables = {
    // ...
  };

  home-manager.users.${user} = {
    programs = {
      git = {
        userName = "user";
        userEmail = "user@example.com";
      };
      fish = {
        shellAliases = {
          // ...
        };
        shellAbbrs = {
          // ...
        };
      };
      starship = {
        settings = {
          directory.substitutions = {
            // ...
          };
        };
      };
    };
  };

  homebrew = {
    casks = [
      // ...
    ];
  };
} // (if platform == "darwin" then {
  system.defaults = {
    loginwindow = {
      LoginwindowText = lib.strings.concatLines [
        hostname
      ];
    };
  };
} else { })
