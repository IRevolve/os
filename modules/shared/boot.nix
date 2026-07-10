{ self, inputs, ... }: {
  flake.nixosModules.boot = { pkgs, ... }: {
    boot = {
      loader.limine = {
        enable = true;
        efiSupport = true;

        style = {
          interface.branding = "NixOS";
          interface.helpHidden = true;

          # Fullscreen
          graphicalTerminal.font.scale = "2x2";
          graphicalTerminal.margin = 0;
          graphicalTerminal.marginGradient = 0;

          graphicalTerminal.palette = "1a1b26;f7768e;9ece6a;e0af68;7aa2f7;bb9af7;7dcfff;a9b1d6";
          graphicalTerminal.brightPalette = "414868;f7768e;9ece6a;e0af68;7aa2f7;bb9af7;7dcfff;c0caf5";

          graphicalTerminal.background = "ffffffff";
          graphicalTerminal.foreground = "a9b1d6";
          graphicalTerminal.brightForeground = "ffffffff";
        };
      };

      loader.efi.canTouchEfiVariables = true;

      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [
        "fbcon=map:0" # Limit boot console only to primary display
      ];
    };
  };
}
