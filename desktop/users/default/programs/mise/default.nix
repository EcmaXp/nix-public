{
  programs.mise = {
    enable = true;
    globalConfig = {
      settings = {
        legacy_version_file_disable_tools = [
          "terraform"
        ];
        idiomatic_version_file_enable_tools = [
          "node"
          "python"
        ];
      };
    };
  };
}
