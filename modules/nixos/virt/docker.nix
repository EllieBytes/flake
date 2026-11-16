{
  config,
  lib,
  ...
}:

# Docker has its merits. (I prefer using native NixOS `systemd-nspawn` containers.)
let
  inherit (lib) mkEnableOption mkDefault mkIf;
in
{
  options.elliebytes.virt.docker = {
    enable = mkEnableOption "Docker";
  };

  config = mkIf config.elliebytes.virt.docker.enable {
    virtualisation.docker = {
      enable = config.elliebytes.virt.docker.enable;
      autoPrune.enable = true;
      enableOnBoot = mkDefault false;
    };

    user.roles.admin.groups = [ "docker" ];
  };
}
