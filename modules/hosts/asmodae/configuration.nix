{ self, inputs, ... }: {
  flake.nixosModules.asmodaeConfig = { pkgs, ... }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest.zfs.latestCompatibleLinuxPackages;
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
  };
}

