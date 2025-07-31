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
        "Wallpaper Play" = 1638457121;
        "WireGuard" = 1451685025;
      };
      taps = [
        "cockroachdb/tap"
        "lingrino/tap"
        "nikitabobko/tap"
      ];
      brews = [
        "cockroach-sql"
        "docker-credential-helper"
        "git-grab"
        "incus"
        "kubetail"
        "libmagic"
        "lume"
        "mas"
        "minio"
        "ruby-build"
        "sqlcipher" # macOS's python3-sqlcipher uses brew's sqlcipher
        "vaku"
      ];
      casks = [
        "1password"
        "aerospace"
        "aldente"
        "balenaetcher"
        "betterdisplay"
        "chatgpt"
        "claude"
        "cloudflare-warp"
        "codeql"
        "cursor"
        "db-browser-for-sqlite"
        "deepl"
        "devtoys"
        "firefox"
        "font-jetbrains-mono"
        "font-sf-mono"
        "font-sf-pro"
        "fork"
        "ghostty"
        "github"
        "google-chrome"
        "google-cloud-sdk"
        "google-drive"
        "jetbrains-toolbox"
        "jordanbaird-ice"
        "karabiner-elements"
        "kdiff3"
        "keka"
        "latest"
        "linear-linear"
        "linearmouse"
        "little-snitch"
        "micro-snitch"
        "numi"
        "obsidian"
        "ollama-app"
        "osquery"
        "privileges"
        "raycast"
        "ridibooks"
        "secretive"
        "sf-symbols"
        "slack"
        "teleport-suite"
        "typora"
        "visual-studio-code"
        "windsurf"
        "wireshark-app"
        "wooshy"
        "yubico-yubikey-manager" # gui
        "zed"
        "zen"
      ];
    };
  }
else
  { }
