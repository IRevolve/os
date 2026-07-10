{ self, inputs, ... }: {
  flake.nixosModules.network = { ... }: {
    networking.hostName = "elysea";
    networking.networkmanager.enable = true;
  };
}
