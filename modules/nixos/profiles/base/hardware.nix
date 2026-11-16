{ config, lib, ... }:

{
  config = lib.mkIf config.profiles.base.enable {
    hardware.enableRedistributableFirmware = true;

    boot.kernelModules = [
      "sg"
      "nvme"
      "ahci"
      "xhci_pci"
      "sd_mod"
    ];
  };
}
