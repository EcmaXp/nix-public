{ hostname, user, ... }:
{
  home-manager.users.${user} = {
    programs.git = {
      userName = "${user}@${hostname}.local";
      userEmail = "${user}@${hostname}.local";
    };
  };
}
