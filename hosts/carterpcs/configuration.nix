{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Base profiles enabled here.
  profiles.base.enable = true;
  profiles.base.bootmode = "other";

  boot.loader = {
    grub.enable = true;
    # Bothe of these *should* have it coexist clean with your Gentoo.
    grub.device = "nodev";
    grub.efiInstallAsRemovable = true;
    grub.useOSProber = true;
    grub.efiSupport = true;

    # Only change this if you have issues.
    # This will auto-detect your EFI System Partition.
    efi.efiSysMountPoint = config.profiles.base.inferredESP;
    efi.canTouchEfiVariables = true;
  };

  profiles.desktop.enable = true;
  profiles.laptop.enable = true;

  # Disabled by default, this enables my systems' security policies.
  # I do not know if you want that so I'll disable it here.
  nix-mineral.enable = false;

  # KDE setup
  # SwayFX is also bundled with the `desktop` profile by default.
  # If it drops you there make sure you have KDE selected in SDDM.
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Uncomment to disable SwayFX
  # programs.sway.enable = false;

  services.xserver.enable = true;

  # Uncomment to disable flatpak.
  # services.flatpak.enable = false;

  # Your user is largely managed by my RBAC framework.
  users.users.chookalio = {
    isNormalUser = true;
    initialPassword = "1"; # CHANGE TF OUT OF THIS.

    # Throw declared packages here.
    packages = with pkgs; [
    ];
  };
}
