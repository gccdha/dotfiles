# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, system, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.nix-minecraft.nixosModules.minecraft-servers
    ];


  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };


  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
	
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # BIOS updates
  # services.fwupd.enable = true;

  networking.hostName = "FW13"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  #hardware.pulseaudio.enable = false;
  #security.rtkit.enable = true;
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  #};

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rr = {
    isNormalUser = true;
    description = "rr";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    inputs.nixvim-flake.packages.${system}.default
    ungoogled-chromium
    tmux
    moonlight-qt
  ];

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.plasma-login-manager.enable = true;
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
    # enable = true;
    # enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  services.fail2ban = {
    enable = true;
    maxretry = 5;
    ignoreIP = [
      "10.0.0.0/8" "172.16.0.0/12" "192.168.0.0/16"
    ];
    bantime = "10m";
    bantime-increment.enable = true;
  };


  # Enable nix-minecraft server stuff
  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers = {
      gameserver = {
        enable = false;
        package = pkgs.fabricServers.fabric-1_21_1;
        serverProperties = {
          difficulty = "hard";
          motd = "Me when the §kuhh is, like §kuhhhh, haha amiright? ";
          snooper-enabled = false;
          simulation-distance = 16;
          view-distance = 20;
          white-list = true;
        };
        #autoStart = true;
        #restart = "always";
        jvmOpts = "-Xmx16G";
        whitelist = {
          realram_ = "65a21f38-fcf2-4bbf-835c-71bd0e931a25";
          potatopco = "65a21f38-fcf2-4bbf-835c-71bd0e931a25";
          damagicmann = "65a21f38-fcf2-4bbf-835c-71bd0e931a25";
        };
        openFirewall = true;
        files = {
          "server-icon.png" = /home/rr/Server/server-icon.png;
        };
        symlinks = {
          "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            AlternateCurrent = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/r0v8vy1s/versions/78P98rac/alternate-current-mc1.21-1.9.0.jar"; sha512 = "8b2899de60af229e911bf45d10f71e624910e8df555aad94cb4e590f052ca5dae102f366a883a0c17a3821fbb086c587b5b9286b70502c09d51f4d60dd02ab77"; };
            BadOptimiations = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/g96Z4WVZ/versions/XYBqWKD2/BadOptimizations-2.1.4-1.21.jar"; sha512 = "6f12d5d7b75ed38f006e4c1e176a2308bf78e6bb5d49601152d7a8fa8e576b3e884bd04fcfb976b82fb67a62408e7efcff3ecc6844cea62b07d4b0538b9f0549"; };
            Carpet = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/f2mvlGrg/fabric-carpet-1.21-1.4.147%2Bv240613.jar"; sha512 = "e6f33d13406796a34e7598d997113f25f7bea3e55f9d334b73842adda52b2c5d0a86b7b12ac812d7e758861e3f468bf201c6c710c40162bb79d6818938204151"; };
            FabricAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/qKPgBeHl/fabric-api-0.104.0%2B1.21.1.jar"; sha512 = "0773f45d364b506b4e5b024aa8f1d498900fcf0a020d2025154e163e50a0eeee1b8296bf29c21df5ced42126ed46635e5ed094df25796ec552eb76399438e7e7"; };
            FerriteCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/wmIZ4wP4/ferritecore-7.0.0-fabric.jar"; sha512 = "0f2f9b5aebd71ef3064fc94df964296ac6ee8ea12221098b9df037bdcaaca7bccd473c981795f4d57ff3d49da3ef81f13a42566880b9f11dc64645e9c8ad5d4f"; };
            Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/5szYtenV/lithium-fabric-mc1.21.1-0.13.0.jar"; sha512 = "d4bd9a9cc37daad8828aa4fa9ca20e4f89d10e30cf6daf4546ef4cf4a684ba21ea0865a9c23cef9d1f4348e9ba4aca9aaca3db9f99534fc610fa78a5ca0bf151"; };
            NoChatReports = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/riMhCAII/NoChatReports-FABRIC-1.21-v2.8.0.jar"; sha512 = "092837afc0fcb5208561062f8e4cd69971efa94c0180ae377e318d35d8f278abbf1552e4a577be882dc7e870f884779bc36caf808c8bc90bb05490f1e034ddb8"; };
            pipeblocker = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/wlRUwo2y/versions/VH4NKOW2/pipeblocker-fabric-1.2.0.jar"; sha512 = "3d15c2076b9eb8b7d698184d9e592dee213b1c089531892142713dd3228f6b48077ceb3337336938e863760bd34e99c8c84525050ebe8c59b70b84774e157b06"; };
          });
        };
      };

      serverserver = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_1;
        serverProperties = {
          difficulty = "hard";
          motd = "Max's §kobfuscatedtext";
          snooper-enabled = false;
          simulation-distance = 16;
          view-distance = 20;
          white-list = true;
        };
        #autoStart = true;
        #restart = "always";
        jvmOpts = "-Xmx16G";
        whitelist = {
          TCAP_ = "6251dda3-d7be-4fad-81d7-05d634a3f84d";
          omega9 = "51148fef-ad00-4235-9ec4-aefba158ed3f";
          Asymmetre = "da7005e8-2e46-4f34-8a9a-196d8c7ce3f8";
          GunterJr = "2460462a-cd21-499d-a4c2-0faed1b99e63";
          PamperedPenguin = "3cbc33db-0084-48c2-b7a7-ab37d8a8f1a4";
          Henrystraw123 = "fe46ad19-f991-494e-a541-bf8220d818ba";
          realram_ = "65a21f38-fcf2-4bbf-835c-71bd0e931a25";
          potatopco = "65a21f38-fcf2-4bbf-835c-71bd0e931a25";
          damagicmann = "65a21f38-fcf2-4bbf-835c-71bd0e931a25";
        };
        openFirewall = true;
        files = {
          "server-icon.png" = /home/rr/Server/server-icon.png;
        };
        symlinks = {
          "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            AlternateCurrent = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/r0v8vy1s/versions/78P98rac/alternate-current-mc1.21-1.9.0.jar"; sha512 = "8b2899de60af229e911bf45d10f71e624910e8df555aad94cb4e590f052ca5dae102f366a883a0c17a3821fbb086c587b5b9286b70502c09d51f4d60dd02ab77"; };
            BadOptimiations = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/g96Z4WVZ/versions/XYBqWKD2/BadOptimizations-2.1.4-1.21.jar"; sha512 = "6f12d5d7b75ed38f006e4c1e176a2308bf78e6bb5d49601152d7a8fa8e576b3e884bd04fcfb976b82fb67a62408e7efcff3ecc6844cea62b07d4b0538b9f0549"; };
            Carpet = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/f2mvlGrg/fabric-carpet-1.21-1.4.147%2Bv240613.jar"; sha512 = "e6f33d13406796a34e7598d997113f25f7bea3e55f9d334b73842adda52b2c5d0a86b7b12ac812d7e758861e3f468bf201c6c710c40162bb79d6818938204151"; };
            FabricAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/qKPgBeHl/fabric-api-0.104.0%2B1.21.1.jar"; sha512 = "0773f45d364b506b4e5b024aa8f1d498900fcf0a020d2025154e163e50a0eeee1b8296bf29c21df5ced42126ed46635e5ed094df25796ec552eb76399438e7e7"; };
            FerriteCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/wmIZ4wP4/ferritecore-7.0.0-fabric.jar"; sha512 = "0f2f9b5aebd71ef3064fc94df964296ac6ee8ea12221098b9df037bdcaaca7bccd473c981795f4d57ff3d49da3ef81f13a42566880b9f11dc64645e9c8ad5d4f"; };
            Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/5szYtenV/lithium-fabric-mc1.21.1-0.13.0.jar"; sha512 = "d4bd9a9cc37daad8828aa4fa9ca20e4f89d10e30cf6daf4546ef4cf4a684ba21ea0865a9c23cef9d1f4348e9ba4aca9aaca3db9f99534fc610fa78a5ca0bf151"; };
            NoChatReports = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/riMhCAII/NoChatReports-FABRIC-1.21-v2.8.0.jar"; sha512 = "092837afc0fcb5208561062f8e4cd69971efa94c0180ae377e318d35d8f278abbf1552e4a577be882dc7e870f884779bc36caf808c8bc90bb05490f1e034ddb8"; };
            pipeblocker = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/wlRUwo2y/versions/VH4NKOW2/pipeblocker-fabric-1.2.0.jar"; sha512 = "3d15c2076b9eb8b7d698184d9e592dee213b1c089531892142713dd3228f6b48077ceb3337336938e863760bd34e99c8c84525050ebe8c59b70b84774e157b06"; };
          });
        };
      };
    };
  };


  #domain = "realram";
  #ipv6Device = "enp0s13f0u2";
  systemd.services.duckdns = {
    description = "Update DuckDNS";
    wantedBy =["multi-user.target"];
    after = ["network-online.target"];
    wants = ["network-online.target"];
    path = with pkgs; [
      curl
      iproute2
    ];
    # script = "echo url=\"https://www.duckdns.org/update?domains=realram&token=ca54bb75-89c9-4a04-a691-294d77e4c566&ip=\" | curl -k -o /dev/null -K -";
    script = ''
          readonly ipv6addr="$(ip addr show dev 'enp0s13f0u2' | \
          sed -e's/^.*inet6 \([^ ]*\)\/.*$/\1/;t;d' | \
          grep -v '^fd' | \
          grep -v '^fe80' | \
          head -1)"

          echo "Got IPv6: $ipv6addr"
        ''
        + ''
          readonly curl_out="$(printf \
          'url="https://www.duckdns.org/update?domains=%s&token=98e51c82-67a3-4d44-adcb-ef0bb61f8f97&ip=&ipv6=%s"' \
          'realram' "''${ipv6addr:-}" \
          | curl --silent --config -)"

          echo "DuckDNS response: $curl_out"
          if [ "$curl_out" == "OK" ]; then
            >&2 echo "Domain updated successfully: $realram"
          else
            >&2 echo "Error while updating domain: $realram"
            exit 1
          fi
        '';
      };

  systemd.timers.duckdns = {
    description = "DuckDns Update Timer";
    timerConfig.onUnitActiveSec = "24h";
    timerConfig.Persistent = true;
  };
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
