{ self, inputs, ... }: {
  flake.nixosModules.asmodaeConfig = { pkgs, ... }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.supportedFilesystems = [ "zfs" ];

    networking.hostId = "8425e349";
    networking.hostName = "asmodae";
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Berlin";

    i18n.defaultLocale = "de_DE.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "de";
    };

    users.users = {
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAd7kjEdXf/tomwYJcMIrtyP3qI8w1OyfaDtGZ+mg1aD revolve@atreia.io"
        ];
      };
      revolve = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };
    };

    environment.systemPackages = with pkgs; [
      neovim
      git
    ];

    services.openssh.enable = true;

    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          workgroup = "WORKGROUP";
          "server string" = "asmodae SMB Server";
          "netbios name" = "asmodae";
          "security" = "user";
          "map to guest" = "Bad User";
          "min protocol" = "SMB3";
          "ea support" = "yes";
        };

        vault = {
          path = "/vault/data";
          browsable = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "revolve";
        };
      };
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
      };
    };

    services.immich = {
      enable = true;
      mediaLocation = "/vault/photos";

      database.enable = true;
      redis.enable = true;
      machine-learning.enable = true;
    };
  };
}

