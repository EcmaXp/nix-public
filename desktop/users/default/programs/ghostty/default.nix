let
  configDir = "Library/Application Support/com.mitchellh.ghostty";
in
{
  home.symlink = {
    "${configDir}/config" = ./config;
    "${configDir}/appearance.conf" = ./appearance.conf;
    "${configDir}/behavior.conf" = ./behavior.conf;
    "${configDir}/keybinds.conf" = ./keybinds.conf;
  };

  programs.fish = {
    shellInit = ''
      if set -q GHOSTTY_BIN_DIR
        fish_add_path -gm $GHOSTTY_BIN_DIR
      else if test -d /Applications/Ghostty.app/Contents/MacOS
        fish_add_path -gm /Applications/Ghostty.app/Contents/MacOS
      end
    '';
    interactiveShellInit = ''
      if set -q GHOSTTY_RESOURCES_DIR
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
        set --prepend fish_complete_path "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_completions.d"
      end
    '';
  };
}
