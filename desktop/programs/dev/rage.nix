{ system, inputs, ... }: {
  imports = [
    inputs.ragenix.darwinModules.default
  ];

  environment.systemPackages = [
    inputs.ragenix.packages.${system}.default
  ];
}
