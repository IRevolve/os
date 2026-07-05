{ self, inputs, ... }: {
  flake.nixosModules.bluetooth = { ... }: {
    hardware.bluetooth.enable = true;
  };
}
