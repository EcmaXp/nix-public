{ user, ... }:
{
  home-manager.users.${user} = {
    home.file = {
      ".nanorc" = {
        source = ./nanorc;
      };
    };
  };
}
