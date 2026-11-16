{
  user.roles.admin = {
    groups = [
      "wheel"
      "nix"
      "adm"
      "systemd-journal"
    ];

  };

  user.roles.base = {
    groups = [
      "dialout"
      "plugdev"
      "storage"
      "optical"
    ];
  };

  user.commonRoles = [ "base" ];
}
