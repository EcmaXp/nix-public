{
  user,
  config,
  sudo,
  ...
}:
let
  sourcePath = "~${user}/nix/modules/programs/desktop/dev/pyp";
  targetPath = "~${user}/.config/pyp";
  mkSymlink = filename: ''
    ${sudo} -u ${user} ln -sf ${sourcePath}/${filename} ${targetPath}/${filename}
  '';
in
{
  environment.variables = {
    PYP_CONFIG_PATH = "${config.users.users.${user}.home}/.config/pyp/pypcfg.py";
  };

  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${sudo} -u ${user} mkdir -p ${targetPath}
        ${mkSymlink "pypcfg.py"}
      '';
    };
  };
}
