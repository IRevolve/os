{ self, inputs, ... }: {
  flake.nixosModules.desktop = { pkgs, inputs, ... }: {
    imports = [
      inputs.qylock.nixosModules.default
    ];

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    services.upower.enable = true;
    services.tuned.enable = true;

    programs.qylock = {
      enable = true;
      theme = "nier-automata";
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.xwayland-satellite
    ];

    home-manager.users.revolve = {
      home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.apple-cursor;
        name = "macOS";
        size = 24;
      };
    };

    environment.variables = {
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "macOS";
      GTK_CURSOR_SIZE = "24";
      GTK_CURSOR_THEME = "macOS";
    };
  };
}
