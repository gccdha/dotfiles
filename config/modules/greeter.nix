{pkgs,...}:
{
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session";
  #       user = "realram";
  #     };
  #   };
  # };
  services.displayManager.sddm = {
    enable = true;
    #wayland.compositor = "kwin";
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = [
      pkgs.kdePackages.qt5compat
    ];
  };

  services.displayManager.defaultSession = "hyprland";

  #enable hyprland support for Universal Wayland Session Manager
  #the wayland modules will do the rest of the work (exept the HM stuff)
  programs.hyprland.withUWSM = false;
}
