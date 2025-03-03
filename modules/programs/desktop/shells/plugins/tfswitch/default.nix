{
  user,
  pkgs-unstable,
  sudo,
  ...
}:
let
  fallbackPath = ".nix-fallback/modules/programs/desktop/shells/plugins/tfswitch";
  sourcePath = "~${user}/nix/modules/programs/desktop/shells/plugins/tfswitch";
  targetPath = "~${user}/.config/fish";
  mkSymlink = filename: ''
    ${sudo} -u ${user} ln -sf ${sourcePath}/${filename} ${targetPath}/${filename}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${sudo} -u ${user} mkdir -p ${targetPath}
        ${mkSymlink "tfswitch.fish"}
      '';
    };
  };

  home-manager.users.${user} = {
    home.packages = (
      with pkgs-unstable;
      [
        tfswitch
      ]
    );

    home.file = {
      "${fallbackPath}/tfswitch.fish" = {
        source = ./tfswitch.fish;
      };
    };

    programs.fish = {
      interactiveShellInit = ''
        if test -f ${targetPath}/tfswitch.fish
          source ${targetPath}/tfswitch.fish
        else
          source ~${user}/${fallbackPath}/tfswitch.fish
        end
      '';
    };
  };
}
