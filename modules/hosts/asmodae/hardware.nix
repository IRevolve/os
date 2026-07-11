{ self, inputs, ... }: {
  flake.nixosModules.asmodaeHardware = { config, lib, modulesPath, ... }: {
    imports = [ 
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems = {
      "/" = { 
        device = "/dev/disk/by-uuid/0775686d-a515-4243-88de-58b047f7f010";
        fsType = "btrfs";
        options = [ "subvol=@" ];
      };

      "/nix" = {
        device = "/dev/disk/by-uuid/0775686d-a515-4243-88de-58b047f7f010";
        fsType = "btrfs";
        options = [ "subvol=@nix" ];
      };

      "/boot" = { 
        device = "/dev/disk/by-uuid/31C1-C511";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };

      "/vault" = { 
        device = "vault";
        fsType = "zfs";
      };

      "/vault/config" = { 
        device = "vault/config";
        fsType = "zfs";
      };

      "/vault/credentials" = { 
        device = "vault/credentials";
        fsType = "zfs";
      };

      "/vault/photos" = { 
        device = "vault/photos";
        fsType = "zfs";
      };

      "/vault/media" = { 
        device = "vault/media";
        fsType = "zfs";
      };

      "/vault/data" = { 
        device = "vault/data";
        fsType = "zfs";
      };

      "/vault/media/cache" = { 
        device = "vault/media/cache";
        fsType = "zfs";
      };

      "/vault/media/anime" = { 
        device = "vault/media/anime";
        fsType = "zfs";
      };

      "/vault/media/movies" = { 
        device = "vault/media/movies";
        fsType = "zfs";
      };

      "/vault/media/shows" = { 
        device = "vault/media/shows";
        fsType = "zfs";
      };
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
