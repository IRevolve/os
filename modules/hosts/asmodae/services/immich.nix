{ self, inputs, ... }: {
  flake.nixosModules.immich = { ... }: {
    services.immich = {
      enable = true;
      mediaLocation = "/vault/photos";

      database.enable = true;
      redis.enable = true;
      machine-learning.enable = true;
    };
  };
}
