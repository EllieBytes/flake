{ config, lib, pkgs, inputs, ... }:

{
  options.profiles.desktop = {
    excludeCommonPackages = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = ''
        Whether to exclude the common package bundle
      '';
    };
  };

  config = lib.mkIf config.profiles.desktop.enable {
    services.flatpak.enable = lib.mkDefault true;

    environment.systemPackages = (
      if config.profiles.desktop.excludeCommonPackages then
        []
      else
        with pkgs; [
          keepassxc
          kitty
          bazaar
          gparted
          inputs.zen-browser.pacakges."${config.hostPlatform.system}".twilight-official
          timeshift
          vlc
          onlyoffice-desktopeditors
          gimp
          home-manager
        ]
    );
  };
}
