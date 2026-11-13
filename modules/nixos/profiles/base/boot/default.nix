{ config, lib, ... }:

let
  inherit (builtins) head attrNames hasAttr;
  inherit (lib) filterAttrs mkOption types;
  inherit (types) enum;

  inferredESP =
    let
      vfatMounts = lib.filterAttrs (mp: fs: fs.fsType == "vfat") config.fileSystems;
    in
      if hasAttr "/efi" vfatMounts then "/efi"
      else if hasAttr "/boot/efi" vfatMounts then "/boot/efi"
      else if hasAttr "/boot" vfatMounts then "/boot"
      else lib.warn "No guaranteed ESP found. Using `${head (attrNames vfatMounts)}`" (head (attrNames vfatMounts));
in
{
  imports = [
    ./lanzaboote.nix
    ./uefi.nix
    ./legacy.nix
  ];

  options.profiles.base = {
    bootmode = mkOption {
      type = enum [
        "lanzaboote"
        "uefi"
        "legacy"
        "other" # Thanks carter :3
      ];
      default = "uefi";
      description = ''
        Which boot setup to place the system in
        lanzaboote is special, but extends UEFI
      '';
    };

    inferredESP = mkOption {
      type = types.str;
      default = inferredESP;
      readOnly = true;
      description = ''
        the detected ESP, falls back to the first vFAT filesystem if no 100% guarantee was yielded.
        Will find any of the following vFAT filesystems.

        * /boot
        * /boot/efi
        * /efi
      '';
    };
  };
}
