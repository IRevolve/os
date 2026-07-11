{ self, inputs, ... }: {
  flake.nixosModules.nextcloud = { ... }: {
    virtualisation.oci-containers.containers."nextcloud" = {
      image = "docker.io/library/nextcloud:stable";
      ports = [ "10001:80" ];

      volumes = [
        "/vault/config/nextcloud:/var/www/html"
        "/vault/data:/var/www/html/data"
      ];

      environment = {
        POSTGRES_HOST = "127.0.0.1";
        POSTGRES_DB = "nextcloud";
        POSTGRES_USER = "";
        POSTGRES_PASSWORD = "";
      };

      extraOptions = [
        "--network=host"
        "--device=/dev/dri:/dev/dri"
      ];
    };

    services.postgresql = {
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [
        {
          name = "nextcloud";
          ensureDBOwnership = true;
        }
      ];
    };

    services.cloudflared.tunnels."15955e1c-25ea-4ae6-aad5-4b37e24829bf".ingress = {
      "cloud.atreia.io" = "http://127.0.0.1:10001";
    };
  };
}
