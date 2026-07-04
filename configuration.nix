{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/gpu.nix
    ./modules/locale.nix
    ./modules/desktop.nix
    ./modules/packages.nix
    ./modules/network.nix
    ./modules/audio.nix
    ./modules/settings.nix
    ./modules/user.nix
    ./modules/bluetooth.nix
  ];

  system.stateVersion = "26.05"; 

}

