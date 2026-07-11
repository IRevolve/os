{ self, inputs, ... }: {
  flake.nixosModules.vaultwarden = { ... }: {
    virtualisation.oci-containers.containers."vaultwarden" = {
      image = "vaultwarden/server:latest";

      ports = [ "10002:80" ];

      volumes = [
        "/vault/credentials:/data"
      ];

      environment = {
        SIGNUPS_ALLOWED = "true";
      };
    };

    services.cloudflared.tunnels."15955e1c-25ea-4ae6-aad5-4b37e24829bf".ingress = {
      "pass.atreia.io" = "http://127.0.0.1:10002";
    };
  };
}
