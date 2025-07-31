{
  home.scripts = {
    "desktop-nix" = {
      bin = ./bin;
    };
  };

  programs.fish = {
    shellAbbrs = {
      "ns" = "nix-sync";
      "nsf" = "nix-sync --forever";
      "nsk" = "nix-sync karabiner";
      "nskf" = "nix-sync karabiner --forever";
      "nsl" = "nix-sync launchpad";
      "nslf" = "nix-sync launchpad --forever";
    };
  };
}
