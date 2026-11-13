{
  disko.devices.disk = {
    main = {
      name = "main";
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            name = "ESP";
            start = "1M";
            size = "4G"; # Lanzaboote the storage hog. >:Y
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          swap-enc = {
            size = "1G";
            content = {
              type = "swap";
              randomEncryption = true;
              priority = 100;
            };
          };

          swap = {
            size = "17G";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true;
            };
          };

          crypt = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";

              settings = {
                allowDiscards = true;
              };

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
    };

    data = {
      name = "data";
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "gpt";
        partitions = {
          public = {
            size = "50%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/mnt/public";
            };
          };
          private = {
            size = "100%";
            content = {
              type = "luks";
              name = "data-priv";
              settings.allowDiscards = true;
              content = {
                type = "filesystem";
                format = "ext4";
              };
            };
          };
        };
      };
    };
  };
}
