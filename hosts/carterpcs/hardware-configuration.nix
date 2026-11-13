{ config, lib, pkgs, ... }:

{
  # Built with HEAVY assumptions.

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "sd_mod"

    "hp-wmi"
    "hp-wmi-sensors"
    "hp-bioscfg"
  ];

  # nvidia
  nixpkgs.config.allowUnfree = true;

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
    };
  };

  boot.kernelModules = [ "kvm-intel" ];
  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
}
