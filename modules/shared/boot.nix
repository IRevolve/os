{ self, inputs, ... }: {
  flake.nixosModules.boot = { pkgs, lib, config, ... }: {
    options.atreia.boot = {
      zenKernel.enable = lib.mkEnableOption "Use zen kernel";
      zfs.enable = lib.mkEnableOption "Use zfs";
    };
    
    config = {
      boot.loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
          consoleMode = "max";
          editor = false;
        };

        efi.canTouchEfiVariables = true;
        timeout = 3;
      };

      boot.kernelPackages = lib.mkIf config.atreia.boot.zenKernel.enable pkgs.linuxPackages_zen;
      boot.kernelParams = [
        "quiet"
        "splash"
        "fbcon=map:0" # Limit boot console only to primary display
      ];
      
      boot.supportedFilesystems = lib.mkIf config.atreia.boot.zfs.enable [ "zfs" ];
      networking.hostId = lib.mkIf config.atreia.boot.zfs.enable "8425e349";
    };
  };
}
