{ platform, user, ... }: {
  imports = [
    ./fallback.nix
  ];

  home-manager.users.${user} = {
    programs.fish = {
      shellInit = ''
        fish_add_path -gm ~${user}/nix/default/scripts/nix/bin
      '';
      shellAbbrs = {
        nixos = {
          "nfi" = "nix-flake-repl";
          "nr" = "sudo nixos-rebuild switch";
          "nrf" = "ls ~/nix/**.nix | sudo entr nixos-rebuild switch";
        };
        darwin = {
          "nfi" = "nix-flake-repl";
          "nr" = "darwin-rebuild switch";
          "nrf" = "ls ~/nix/**.nix | entr darwin-rebuild switch";
        };
      }.${platform};
    };
  };
}
