{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./disk.nix
  ];

  # Base profiles enabled here.
  profiles.base.enable = true;
  profiles.base.bootmode = "other";

  boot.loader = {
    grub.enable = true;
    # Both of these *should* have it coexist clean with your Gentoo.
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

  profiles.desktop.backend = "kde";

  # Uncomment to disable flatpak.
  # services.flatpak.enable = false;

  # Your user is largely managed by my RBAC framework.
  users.users.chookalio = {
    isNormalUser = true;
    initialPassword = "1"; # CHANGE TF OUT OF THIS.

    # Throw declared packages here.
    packages = with pkgs; [ ];
  };

  # System wide packages here
  environment.systemPackages = with pkgs; [ ];

  system.stateVersion = "26.05";
}
