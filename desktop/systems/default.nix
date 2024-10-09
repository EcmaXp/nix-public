{ platform, ... }: {
  imports = [
    ./${platform}
  ];

  time.timeZone = "Asia/Seoul";
}
