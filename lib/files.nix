_:

let
  inherit (builtins) elem readDir filter;

  ignoreFiles = [
    "default.nix"
    "meta.nix"
  ];
in
{
  scanPath =
    dir: map (name: dir + "/${name}") (filter (name: !elem name ignoreFiles) (readDir (readDir dir)));
}
