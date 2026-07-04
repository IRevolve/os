{ pkgs, ... }: {
  
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-beta;
      policies.DisableTelemetry = true;
    };

    git = {
      enable = true;
      config = {
        user.name = "Revolve";
	user.email = "revolve@atreia.io";
	init.defaultBranch = "main";
	pull.rebase = true;
      };
    };

    fish = {
      enable = true;
      shellAliases = {};
      shellInit = "fastfetch";
    };

    starship.enable = true;

    steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };

  environment.systemPackages = [
    pkgs.neovim
    pkgs.ripgrep
    pkgs.kitty
    pkgs.fastfetch
    pkgs.lutris
  ];

}
