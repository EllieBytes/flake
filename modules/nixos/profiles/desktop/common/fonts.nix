{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.profiles.desktop.enable {
    fonts.fontconfig.enable = true;
    fonts.fontDir.enable = true;
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      liberation_ttf
      cantarell-fonts
      fira-code
      hack-font
      nerd-fonts.iosveka
      nerd-fonts.fira-code
      font-awesome
      vista-fonts
      corefonts
    ];
  };
}
