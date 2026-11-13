{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-26.05-small";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    burrow.url = "github:EllieBytes/burrow";
    burrow.inputs.flake-parts.follows = "flake-parts";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-unstable.url = "github:nix-community/home-manager/master";
    home-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";

    lanzaboote.url = "github:nix-community/lanzaboote/v1.2.0";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    shb.url = "github:ibizaman/selfhostblocks";
    shb.inputs.nixpkgs.follows = "nixpkgs";

    nix-mineral.url = "github:nix-community/nix-mineral";
    nix-mineral.inputs.nixpkgs.follows = "nixpkgs";
    nix-mineral.inputs.flake-parts.follows = "flake-parts";
  };

  outputs = inputs@{ flake-parts, burrow, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ burrow.flakeModule ];
      systems = [ "x86_64-linux" "aarch64-linux" ];

      burrow.root = ./.;
    };
}
