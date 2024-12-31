{ config, ... }:
let
  identities = import ./identities config.networking.hostName;
in
{
  age = {
    identityPaths = identities.identityPaths;
    secrets = {
      "example.yaml".file = ./example.yaml.age;
    };
  };
}
