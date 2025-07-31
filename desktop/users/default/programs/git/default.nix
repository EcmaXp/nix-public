{
  platform,
  lib,
  ...
}:
{
  programs.git = {
    signing.signByDefault = true;
    delta = {
      enable = true;
      # https://github.com/zed-industries/zed/issues/11700
      options.dark = true;
    };
    extraConfig = {
      branch.sort = "-committerdate";
      column.ui = "auto";
      commit.verbose = "true";
      core.fsmonitor = lib.mkIf (platform != "darwin") "true";
      core.untrackedCache = "true";
      credential.helper = lib.mkIf (platform == "darwin") "osxkeychain";
      diff.algorithm = "histogram";
      diff.colorMoved = "plain";
      diff.mnemonicPrefix = "true";
      diff.renames = "true";
      fetch.all = "true";
      fetch.prune = "true";
      fetch.pruneTags = "true";
      help.autocorrect = "prompt";
      pull.rebase = "true";
      push.autoSetupRemote = "true";
      push.default = "simple";
      push.followTags = "true";
      rebase.autoSquash = "true";
      rebase.autoStash = "true";
      rebase.updateRefs = "true";
      rerere.autoupdate = "true";
      rerere.enabled = "true";
      tag.sort = "version:refname";
    };
  };
}
