{ platform, config, ... }:
let
  inherit (config.home) homeDirectory;
  shellAbbrs = {
    default = {
      "nfi" = "nix-flake-repl";
    };
    nixos = {
      "nb" = "nh os build";
      "nr" = "nh os switch";
      "nt" = "nh os test";
      "nrf" = "ls ~/nix/**.nix | entr nh os switch";
    };
    darwin = {
      "nb" = "nh darwin build";
      "nr" = "nh darwin switch";
      "nt" = "nh darwin test";
      "nrf" = "ls ~/nix/**.nix | entr nh darwin switch";
    };
    home-manager = {
      "hb" = "nh home build";
      "hr" = "nh home switch";
      "hrf" = "ls ~/nix/**.nix | entr nh home switch";
    };
  };
in
{
  home.sessionVariables = {
    NH_FLAKE = "${homeDirectory}/nix";
  };

  home.scripts = {
    "default-nix" = {
      bin = ./bin;
    };
  };

  programs.fish = {
    shellAbbrs = shellAbbrs.default // shellAbbrs.${platform} // shellAbbrs.home-manager;
  };
}
