{
  config,
  lib,
  ...
}:
let
  inherit (config.lib.nix) mkRelativePath;
in
{
  options.home.symlink = lib.mkOption {
    type = lib.types.attrsOf lib.types.path;
    default = { };
  };

  config = {
    home.file = lib.mapAttrs (name: source: {
      source = config.lib.file.mkOutOfStoreSymlink (mkRelativePath source);
      force = true;
    }) config.home.symlink;
  };
}
