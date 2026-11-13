{
  disko.devices.disk.main = {
    name = "main";
    type = "disk";
    device = "/dev/sda";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          priority = 1;
          name = "ESP";
          start = "1M";
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        swap-enc = {
          size = "512M";
          content = {
            type = "swap";
            randomEncryption = true;
            priority = 100;
          };
        };

        swap = {
          size = "4G";
          content = {
            type = "swap";
            discardPolicy = "both";
          };
        };

        root = {
          size = "100%";

          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/rootfs" = {
                mountpoint = "/";
              };

              "/home" = {
                mountOptions = [ "compress=zstd" ];
                mountpoint = "/home";
              };

              "/nix" = {
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
                mountpoint = "/nix";
              };
            };
          };
        };
      };
    };
  };
}
