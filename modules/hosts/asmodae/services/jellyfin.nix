{ self, inputs, ... }: {
  flake.nixosModules.jellyfin = { ... }: {
    virtualisation.oci-containers.containers."jellyfin" = {
      image = "docker.io/jellyfin/jellyfin:latest";
      ports = [ "10003:8096" ];
      
      volumes = [
        "/vault/config/jellyfin:/config"
        "/vault/media:/vault/media"
      ];
      
      extraOptions = [
        "--device=/dev/dri:/dev/dri"
      ];
    };
    
    services.cloudflared.tunnels."15955e1c-25ea-4ae6-aad5-4b37e24829bf".ingress = {
      "tv.atreia.io" = "http://127.0.0.1:10003";
    };
  };
}
