_:

let
  inherit (builtins)
    attrNames
    elem
    readDir
    filter
    ;

  ignoreFiles = [
    "default.nix"
    "meta.nix"
  ];
in
rec {
  namesToPath = dir: map (name: dir + "/${name}");

  scanPath = dir: (namesToPath dir) (filter (name: !elem name ignoreFiles) (attrNames (readDir dir)));

  scanPathExcept =
    except: dir: (namesToPath dir) (filter (name: !elem name except) (attrNames (readDir dir)));
}
