{ self, inputs, ... }: {
  flake.nixosModules.database = { pkgs, ... }: {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_17;

      settings.listen_addresses = pkgs.lib.mkForce "127.0.0.1,10.88.0.1";

      # Erlaubt lokalen Verbindungen via 127.0.0.1 den Zugriff ohne Passwort
      authentication = pkgs.lib.mkOverride 10 ''
        # TYPE  DATABASE        USER            ADDRESS                 METHOD
        local   all             all                                     trust
        host    all             all             127.0.0.1/32            trust
      '';
    };
  };
}
