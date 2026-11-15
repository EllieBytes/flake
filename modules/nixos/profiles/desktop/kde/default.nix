{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.profiles.desktop.enable && config.profiles.desktop.backend == "kde") {
    services.desktopManager.plasma6 = {
      enable = true;
      enableQt5Integration = true;
    };

    services.xserver.enable = lib.mkDefault true;

    # Exclude things I dislike
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      konqueror
      konversation
      akregator
      juk
      dragon
    ];

    environment.systemPackages = with pkgs; [
      kdePackages.discover
      kdePackages.dolphin
    ];
  };
}
