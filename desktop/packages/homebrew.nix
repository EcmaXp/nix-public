{ platform, ... }:
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
      "uv" # wait until for 0.4.x
    ];
    taps = [
      "nikitabobko/tap" # aerospace
      "cockroachdb/tap"
      "felixkratz/formulae"
      "remko/age-plugin-se" # brew tap remko/age-plugin-se https://github.com/remko/age-plugin-se
      "simonw/llm"
    ];
    casks = [
      "1password"
      "1password-cli"
      "aerospace"
      "aldente"
      "alt-tab"
      "aptakube"
      "arc"
      "balenaetcher"
      "cleanshot"
      "db-browser-for-sqlite"
      "deepl"
      "firefox"
      "font-sf-mono"
      "font-sf-pro"
      "fork"
      "google-chrome"
      "google-cloud-sdk"
      "iterm2"
      "jetbrains-toolbox"
      "jordanbaird-ice"
      "karabiner-elements"
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
      "numi"
      "obsidian"
      "ollama"
      "openlens"
      "raycast"
      "scroll-reverser"
      "secretive"
      "sf-symbols"
      "slack"
      "topnotch"
      "typora"
      "utm"
      "visual-studio-code"
      "wireshark"
      "yubico-yubikey-manager" # gui
      "zed"
      "zed@preview"
      "zoom"
      # "mactex"
    ];
  };
} else { }
