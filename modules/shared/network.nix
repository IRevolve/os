{ self, inputs, ... }: {
  flake.nixosModules.network = { lib, config, ... }: {
    options.atreia.network = {
      hostName = lib.mkOption {
        type = lib.types.str;
      };
    };

    config = {
      networking.networkmanager.enable = true;
      networking.hostName = config.atreia.network.hostName;
    };
  };
}
