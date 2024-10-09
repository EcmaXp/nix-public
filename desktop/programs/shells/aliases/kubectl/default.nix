{ user, ... }:
let
  sourcePath = "~${user}/nix/desktop/programs/shells/aliases/kubectl";
  targetPath = "~${user}/.config/fish";
  mkSymlink = filename: ''
    sudo -u ${user} ln -sf ${sourcePath}/${filename} ${targetPath}/${filename}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        mkdir -p ${targetPath}
        ${mkSymlink "kubectl_aliases.fish"}
      '';
    };
  };

  home-manager.users.${user} = {
    programs.fish = {
      interactiveShellInit = ''
        source ${targetPath}/kubectl_aliases.fish
      '';
    };
  };
}
