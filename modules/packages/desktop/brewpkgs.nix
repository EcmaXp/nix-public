{ platform, ... }:
if platform == "darwin" then
  {
    homebrew = {
      masApps = {
        "1Password for Safari" = 1569813296;
        "AdBlock Pro" = 1018301773;
        "Amphetamine" = 937984704;
        "Apple Configurator" = 1037126344;
        "Apple Developer" = 640199958;
        "BandiZip" = 1265704574;
        "Flow" = 1423210932;
        "HazeOver" = 430798174;
        "Magnet" = 441258766;
        "RunCat" = 1429033973;
        "TestFlight" = 899247664;
        "WireGuard" = 1451685025;
      };
      taps = [
        "cockroachdb/tap"
        "lingrino/tap"
        "remko/age-plugin-se" # brew tap remko/age-plugin-se https://github.com/remko/age-plugin-se
      ];
      brews = [
        "libmagic"
        "age-plugin-se"
        "cockroach-sql"
        "docker-credential-helper"
        "incus"
        "localstack"
        "mas"
        "sqlcipher" # macOS's python3-sqlcipher uses brew's sqlcipher
        "symbex"
        "vaku"
      ];
      casks = [
        "1password"
        "1password-cli"
        "aerospace-dev"
        "aldente"
        "balenaetcher"
        "betterdisplay"
        "chatgpt"
        "db-browser-for-sqlite"
        "deepl"
        "firefox"
        "font-jetbrains-mono"
        "font-sf-mono"
        "font-sf-pro"
        "fork"
        "ghostty"
        "google-chrome"
        "google-cloud-sdk"
        "jetbrains-toolbox"
        "jordanbaird-ice"
        "karabiner-elements"
        "kdiff3"
        "keka"
        "kitty"
        "latest"
        "linearmouse"
        "little-snitch"
        "micro-snitch"
        "numi"
        "obsidian"
        "ollama"
        "openlens"
        "raycast"
        "secretive"
        "sf-symbols"
        "slack"
        "typora"
        "visual-studio-code"
        "visual-studio-code@insiders"
        "wireshark"
        "wooshy"
        "yubico-yubikey-manager" # gui
        "zed"
        "zed@preview"
        "zen-browser"
        "zoom"
      ];
    };
  }
else
  { }
