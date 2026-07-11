{ self, inputs, ... }: {
  flake.nixosModules.vaultwarden = { ... }: {
    virtualisation.oci-containers.containers."vaultwarden" = {
      image = "vaultwarden/server:latest";

      ports = [ "8080:80" ];

      volumes = [
        "/vault/credentials:/data"
      ];

      environment = {
        SIGNUPS_ALLOWED = "true";
      };
    };
  };
}
