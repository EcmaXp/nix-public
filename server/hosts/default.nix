{ hostname, ... }:
{
  imports = [
    ./${hostname}
  ];
}