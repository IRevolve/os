{ self, inputs, ... }: {
  flake.nixosModules.boot = { pkgs, ... }: {
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;

      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [
        "fbcon=map:0" # Limit boot console only to primary display
      ];
    };
  };
}
