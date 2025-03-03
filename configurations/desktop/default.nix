{ hostname, ... }:
{
  imports = [
    ./${hostname}/configuration.nix
    ../../modules/profiles/desktop
    ../../modules/systems/platforms/darwin/desktop
  ];
}
