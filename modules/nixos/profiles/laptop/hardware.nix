{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.profiles.laptop.enable {
    programs.light.enable = lib.mkDefault true;
    services.actkbd.enable = lib.mkDefault true;
    services.fstrim.enable = lib.mkDefault true;

    services.libinput = {
      enable = true;
      touchpad = {
        tapping = false;
        naturalScrolling = false;
        scrollMethod = "twofinger";
        disableWhileTyping = true;
      };
    };

    environment.systemPackages = with pkgs; [
      brightlight
      cbatticon
      acpi
      powertop
      iw
    ];
  };
}
