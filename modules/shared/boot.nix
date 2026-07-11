{ self, inputs, ... }: {
  flake.nixosModules.boot = { pkgs, lib, config, ... }: {
    options.atreia.boot = {
      zenKernel = lib.mkEnableOption "Use zen kernel";
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

      boot.kernelPackages = lib.mkIf config.atreia.boot.zenKernel pkgs.linuxPackages_zen;
      boot.kernelParams = [
        "quiet"
        "splash"
        "fbcon=map:0" # Limit boot console only to primary display
      ];
    };
  };
}
