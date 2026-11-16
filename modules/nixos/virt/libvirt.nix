{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.elliebytes.virt.libvirt.enable = lib.mkEnableOption "virtualization via libvirtd";

  config = lib.mkIf config.elliebytes.virt.libvirt.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };

    programs.virt-manager.enable = true;
    services.spice-vdagentd.enable = lib.mkDefault true;

    user.roles.virt = {
      groups = [
        "libvirtd"
        "kvm"
      ];

      packages = with pkgs; [
        virt-viewer
        spice
        spice-gtk
        win-virtio
        win-spice
      ];
    };

  };
}
