{ hostname, ... }:
{
  imports = [
    ./${hostname}/configuration.nix
    ../../modules/profiles/server
  ];
}
