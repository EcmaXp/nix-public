{ user, ... }: {
  home-manager.users.${user} = {
    programs.fish = {
      shellAbbrs = {
        "nr" = "nix-rebuild";
        "nrf" = "nix-rebuild-forever";
        "ns" = "nix-sync";
        "nsf" = "nix-sync --forever";
        "nsk" = "nix-sync karabiner";
        "nskf" = "nix-sync karabiner --forever";
        "nsr" = "nix-sync raycast";
        "nsrf" = "nix-sync raycast --forever";
        "nsl" = "nix-sync launchpad";
        "nslf" = "nix-sync launchpad --forever";
        "ni" = "nix-repl";
      };
      functions = {
        "nix-rebuild" = {
          body = "darwin-rebuild switch --flake ~/nix $argv";
        };
        "nix-rebuild-forever" = {
          body = "ls ~/nix/**.nix | entr darwin-rebuild switch --flake ~/nix $argv";
        };
        "nix-sync" = {
          body = "pushd ~/nix; uv run sync $argv; popd";
        };
        "nix-repl" = {
          body = "nix repl --expr '{ nix = builtins.getFlake (toString ~/nix); }' $argv";
        };
      };
    };
  };
}
