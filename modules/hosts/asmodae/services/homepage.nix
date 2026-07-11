{ self, inputs, ... }: {
  flake.nixosModules.homepage = { ... }: {
    virtualisation.oci-containers.containers."homepage" = {
      image = "ghcr.io/gethomepage/homepage:latest";
      
      ports = [ "10000:3000" ];

      volumes = [
        "/vault/config/homepage:/app/config"
        "/run/podman/podman.sock:/var/run/docker.sock:ro"
      ];

      environment = {
        HOMEPAGE_ALLOWED_HOSTS = "10.0.0.2:10000";
      };
    };
  };
}
