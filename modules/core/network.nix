{ self, inputs, ... }: {
  flake.nixosModules.network = { ... }: {
    networking.hostName = "asmodae";
    networking.networkmanager.enable = true;
  };
}
