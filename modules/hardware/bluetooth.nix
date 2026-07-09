{ self, inputs, ... }: {
  flake.nixosModules.bluetooth = { ... }: {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    # Fix Xbox-Controller disconnect
    boot.extraModprobeConfig = ''
      options bluetooth disable_etrm=1
    '';
  };
}
