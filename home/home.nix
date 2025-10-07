{ config, pkgs, inputs, system, nix-colors, ...}: {
  imports = [
    ./config
    ./scripts
    nix-colors.homeManagerModule
  ];

  colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;

  systemd.user.services.taskwarrior-backup = {
  Unit.Description = "Backup Taskwarrior data to GitHub";
    Service = {
      Type = "oneshot";
      ExecStart = ''
        /bin/sh -c 'cd ~/.local/share/task && git add . && git commit -m "Auto backup $(date)" && git push'
      '';
    };
  };

  systemd.user.timers.taskwarrior-backup = {
    Unit.Description = "Run Taskwarrior backup daily";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };


  home = {
    username = "realram";
    homeDirectory = "/home/realram";
    packages = [];
    stateVersion = "23.11"; #no touchy touchy
  };
}
