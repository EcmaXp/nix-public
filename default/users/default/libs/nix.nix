{
  config,
  lib,
  self,
  ...
}:
let
  inherit (config.home) homeDirectory;
  nixPath = "${homeDirectory}/nix";
in
{
  config = {
    lib.nix = {
      mkRelativePath =
        source:
        let
          relativePath = lib.removePrefix (toString self) (toString source);
        in
        "${nixPath}${relativePath}";
    };
  };
}
