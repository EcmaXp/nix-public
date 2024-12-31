{ platform, ... }:
if platform == "darwin" then
  {
    homebrew = {
      masApps = {
        "1Password for Safari" = 1569813296;
        "AdBlock Pro" = 1018301773;
        "Amphetamine" = 937984704;
        "BandiZip" = 1265704574;
        "Dropover" = 1355679052;
        "Flow" = 1423210932;
        "HazeOver" = 430798174;
        "Magnet" = 441258766;
        "RunCat" = 1429033973;
        "WireGuard" = 1451685025;
      };
      taps = [
        "chase/tap"
        "cockroachdb/tap"
        "felixkratz/formulae"
        "lingrino/tap"
        "remko/age-plugin-se" # brew tap remko/age-plugin-se https://github.com/remko/age-plugin-se
        "simonw/llm"
      ];
      brews = [
        "age-plugin-se"
        "awrit"
        "cockroach-sql"
        "docker-credential-helper"
        "incus"
        "localstack"
        "lxc"
        "mackup"
        "mas"
        "sketchybar"
        "sqlcipher" # macOS's python3-sqlcipher uses brew's sqlcipher
        "symbex"
        "vaku"
      ];
      casks = [
        "1password"
        "1password-cli"
        "aerospace-dev"
        "aldente"
        "alt-tab"
        "aptakube"
        "arc"
        "balenaetcher"
        "betterdisplay"
        "chatgpt"
        "cleanshot"
        "db-browser-for-sqlite"
        "deepl"
        "firefox"
        "font-sf-mono"
        "font-sf-pro"
        "fork"
        "ghostty"
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
        "visual-studio-code@insiders"
        "wireshark"
        "yubico-yubikey-manager" # gui
        "zed"
        "zed@preview"
        "zen-browser"
        "zoom"
        # "mactex"
      ];
    };
  }
else
  { }
