{ user, ... }: {
  imports = [
    ./pinentry.nix
  ];

  programs = {
    gnupg.agent.enable = true;
  };
}
