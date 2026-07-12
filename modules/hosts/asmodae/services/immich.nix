{ self, inputs, ... }: {
  flake.nixosModules.immich = { ... }: {
    virtualisation.oci-containers.containers."immich" = {
      image = "";
      ports = [ "10004:2283" ];

      volumes = [
        "/vault/photos:/..."
      ];
    };
  };
}
