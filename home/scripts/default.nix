{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "script-inhibit";
      text = builtins.readFile ./inhibit.sh;
    })
  ];
}
