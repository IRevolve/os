{ self, inputs, ... }: {
  flake.nixosModules.shell = { pkgs, lib, ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = lib.getExe pkgs.fastfetch;
    };

    programs.starship.enable = true;
  };
}
