{ inputs, ... }:

{
  namespace = "nixosModules";

  extraModules = [
    inputs.lanzaboote.nixosModules.default
    inputs.nix-mineral.nixosModules.default
  ];
}
