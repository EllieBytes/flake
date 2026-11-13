{ outputs, lib, ... }:

{
  extraModules = lib.mkBefore [
    outputs.nixosModules.default
  ];
}
