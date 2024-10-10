{ pkgs, ... }:{
  # BOOTLOADER

  # boot.loader.systemd-boot.enable = true; # DEFAULT

  boot = {
    # GRUB CONFIG
    loader = {
      grub.device = "nodev";
      grub.efiSupport = true;
      grub2-theme = {
        enable = true;
        theme = "whitesur";
        footer = true;
      };
      efi.canTouchEfiVariables = true;
    };

    # DISK ENCRYPTION
    initrd.luks.devices."luks-66f1cdfb-d50f-4982-abfb-8ffe49797927".device = "/dev/disk/by-uuid/66f1cdfb-d50f-4982-abfb-8ffe49797927";

    # SPLASH
    plymouth = {
      enable = true;
      theme = "sphere";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "sphere" ];
        })
      ];
    };

    # STARTUP LOG SETTINGS
    consoleLogLevel = 0;
    initrd.verbose = false;
    initrd.systemd.enable = true;

    # KERNEL (some settings required for the splash, grub, etc.)
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

  };

}
