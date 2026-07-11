{ self, inputs, ... }: {
  flake.nixosModules.immich = { ... }: {
    services.immich = {
      enable = true;
      host = "0.0.0.0";
      port = 2283;
      mediaLocation = "/vault/photos";
      
      openFirewall = true;

      database.enable = true;
      redis.enable = true;
      machine-learning.enable = true;
    };
  };
}
