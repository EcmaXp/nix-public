{
  config,
  lib,
  ...
}:
let
  toolType = lib.types.attrsOf lib.types.str;

  withPrefix =
    prefix: tools:
    lib.mapAttrs' (name: version: {
      name = "${prefix}:${name}";
      value = version;
    }) tools;
in
{
  options.programs.mise.tools = {
    npx = lib.mkOption {
      type = toolType;
      default = { };
      description = "NPM packages to install via npx";
    };

    uvx = lib.mkOption {
      type = toolType;
      default = { };
      description = "Python packages to install via uvx (pipx)";
    };

    core = lib.mkOption {
      type = toolType;
      default = { };
      description = "Core mise tools";
    };
  };

  config = lib.mkIf config.programs.mise.enable {
    programs.mise.globalConfig.tools = lib.mkMerge [
      (withPrefix "npm" config.programs.mise.tools.npx)
      (withPrefix "pipx" config.programs.mise.tools.uvx)
      config.programs.mise.tools.core
    ];
  };
}
