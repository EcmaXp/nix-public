{ platform, lib, ... }:
if platform == "darwin" then {
  environment.variables = {
    HOMEBREW_NO_ANALYTICS = "1";
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    masApps = {
      "1Password for Safari" = 1569813296;
      "AdBlock Pro" = 1018301773;
      Amphetamine = 937984704;
      BandiZip = 1265704574;
      Dropover = 1355679052;
      Flow = 1423210932;
      HazeOver = 430798174;
      Magnet = 441258766;
      RunCat = 1429033973;
      WireGuard = 1451685025;
    };
    brews = [
      "age-plugin-se"
      "cockroach-sql"
      "docker-credential-helper"
      "localstack"
      "lxc"
      "mackup"
      "mas"
      "sketchybar"
      "sqlcipher" # macOS's python3-sqlcipher uses brew's sqlcipher
      "symbex"
      "yabai"
    ];
    taps = [
      "cockroachdb/tap"
      "felixkratz/formulae"
      "koekeishiya/formulae"
      "remko/age-plugin-se" #  brew tap remko/age-plugin-se https://github.com/remko/age-plugin-se
      "simonw/llm"
    ];
    casks = [
      "1password"
      "1password-cli"
      "alt-tab"
      "aptakube"
      "arc"
      "balenaetcher"
      "cleanshot"
      "db-browser-for-sqlite"
      "deepl"
      "firefox"
      "fork"
      "google-chrome"
      "iterm2"
      "jetbrains-toolbox"
      "jordanbaird-ice"
      "kdiff3"
      "keka"
      "kitty"
      "latest"
      "launchpad-manager"
      "linearmouse"
      "little-snitch"
      "micro-snitch"
      "notion"
      "notion-calendar"
      "obsidian"
      "ollama"
      "openlens"
      "raycast"
      "scroll-reverser"
      "secretive"
      "slack"
      "topnotch"
      "typora"
      "visual-studio-code"
      "wireshark"
      "yubico-yubikey-manager" # gui
      "zed"
      "zoom"
      # "mactex"
    ];
  };
} else { }
