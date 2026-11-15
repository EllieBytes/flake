{ config, lib, ... }:

{
  imports = [
    ./base
    ./desktop
    ./server
    ./laptop
  ];

  profiles.base.enable = lib.mkDefault true;
}
