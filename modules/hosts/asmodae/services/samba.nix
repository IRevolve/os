{ self, inputs, ... }: {
  flake.nixosModules.samba = { ... }: {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          workgroup = "WORKGROUP";
          "server string" = "asmodae SMB Server";
          "netbios name" = "asmodae";
          "security" = "user";
          "map to guest" = "Bad User";
          "min protocol" = "SMB3";
          "ea support" = "yes";
        };

        vault = {
          path = "/vault/data";
          browsable = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "revolve";
        };
      };
    };

    # Discoverability
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
      };
    };
  };
}

