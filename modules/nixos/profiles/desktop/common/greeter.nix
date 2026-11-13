{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.profiles.desktop.enable {
    services.displayManager.sddm = {
      enable = lib.mkDefault true;
      theme = lib.mkDefault "elegant-sddm";
      settings.General.InputMethod = lib.mkDefault "";

      extraPackages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
        elegant-sddm
      ];
    };
  };
}
