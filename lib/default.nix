{
  flake,
  lib,
  inputs,
  ...
}:

let
  ignore = [ "default.nix" ];
  inherit (builtins)
    attrNames
    elem
    filter
    foldl'
    match
    readDir
    ;

  files = map (p: ./. + "/${p}") (
    filter (x: (!isNull (match ".*\\.nix$" x) && (!elem x ignore))) attrNames (readDir ./.)
  );
in
lib.extend (
  final: prev: {
    elliebytes = lib.fix (
      self:
      foldl' lib.recursiveUpdate { } (
        map (
          p:
          import p {
            inherit
              lib
              self
              inputs
              flake
              ;
          }
        ) files
      )
    );
  }
)
