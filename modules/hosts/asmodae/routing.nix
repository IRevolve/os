{ self, inputs, ... }: {
  flake.nixosModules.routing = {
    services.cloudflared = {
      enable = true;
      tunnels = {
        "15955e1c-25ea-4ae6-aad5-4b37e24829bf" = {
          certificateFile = "/root/.cloudflared/cert.pem";
          credentialsFile = "/root/.cloudflared/15955e1c-25ea-4ae6-aad5-4b37e24829bf.json";
          default = "http_status:404";

          ingress = {
            "photos.atreia.io" = "http://localhost:2283";
            "tv.atreia.io" = "http://localhost:8096";
            "pass.atreia.io" = "http://localhost:8080";
          };
        };
      };
    };
  };
}
