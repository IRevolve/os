{ self, inputs, ... }: {
  flake.nixosModules.network = { ... }: {
    networking.hostName = "sanctum";
    networking.networkmanager.enable = true;
  };
}
