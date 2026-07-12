{ self, inputs, ... }: {
  flake.nixosModules.immich = { pkgs, ... }: {
    virtualisation.oci-containers.containers = {
      "immich" = {
        image = "ghcr.io/immich-app/immich-server:release";
        ports = [ "0.0.0.0:10004:2283" ];

        volumes = [
          "/vault/photos:/usr/src/app/upload"
        ];

        environment = {
          DB_HOSTNAME = "immich-postgres";
          DB_USERNAME = "postgres";
          DB_DATABASE_NAME = "immich";
          DB_PASSWORD = "test123!!!@@@";
          REDIS_HOSTNAME = "immich-redis";
        };

        extraOptions = [
          "--network=immich-net"
          "--device=/dev/dri:/dev/dri"
        ];

        dependsOn = [
          "immich-postgres"
          "immich-redis"
        ];
      };

      "immich-machine-learning" = {
        image = "ghcr.io/immich-app/immich-machine-learning:release";

        volumes = [
          "/vault/config/immich/ml-cache:/cache"
        ];

        extraOptions = [
          "--network=immich-net"
          "--device=/dev/dri:/dev/dri"
        ];

        dependsOn = [
          "immich-postgres"
          "immich-redis"
        ];
      };

      "immich-postgres" = {
        image = "ghcr.io/immich-app/postgres:14-vectorchord0.4.3-pgvectors0.2.0@sha256:bcf63357191b76a916ae5eb93464d65c07511da41e3bf7a8416db519b40b1c23";

        volumes = [
          "/vault/config/immich/postgres:/var/lib/postgresql/data"
        ];

        environment = {
          POSTGRES_USER = "postgres";
          POSTGRES_DB = "immich";
          POSTGRES_PASSWORD = "test123!!!@@@";
        };

        extraOptions = [
          "--network=immich-net"
        ];
      };

      "immich-redis" = {
        image = "redis:7-alpine";

        volumes = [
          "/vault/config/immich/redis:/data"
        ];

        extraOptions = [
          "--network=immich-net"
        ];
      };
    };

    systemd.services.create-podman-immich-net = {
      description = "Create Podman networ for Immich";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.podman}/bin/podman network create --ignore immich-net";
      };
    };

    services.cloudflared.tunnels."15955e1c-25ea-4ae6-aad5-4b37e24829bf".ingress = {
      "photos.atreia.io" = "http://127.0.0.1:10004";
    };
  };
}
