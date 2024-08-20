{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "script-nolock";
      text = builtins.readFile ./nolock.sh;
    })
  ];
}
