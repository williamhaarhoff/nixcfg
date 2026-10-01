{ self, inputs, ... }: {
	flake.nixosModules.ss-winning-hardware = { config, lib, pkgs, modulesPath, ... }: {
        imports =
		[ (modulesPath + "/installer/scan/not-detected.nix")
		];
        config = {
            boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
            boot.initrd.kernelModules = [ ];
            boot.kernelModules = [ "kvm-amd" ];
            boot.extraModulePackages = [ ];

            fileSystems."/" =
                { device = "/dev/mapper/luks-a80365c3-336f-4237-8ee2-d954e1b62d6e";
                    fsType = "ext4";
                };

            boot.initrd.luks.devices."luks-a80365c3-336f-4237-8ee2-d954e1b62d6e".device = "/dev/disk/by-uuid/a80365c3-336f-4237-8ee2-d954e1b62d6e";

            fileSystems."/boot" =
                { device = "/dev/disk/by-uuid/E962-7452";
                    fsType = "vfat";
                    options = [ "fmask=0077" "dmask=0077" ];
                };

            swapDevices =
                [ { device = "/dev/mapper/luks-0e1995d3-ba0e-40f9-bdaa-c405d243d4f5"; }
                ];


            # power module updates
            nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
            hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
            # external ssd 
            fileSystems."/mnt/my-drive" = {
                device = "/dev/disk/by-uuid/45fff69b-fb23-4b95-bf06-bb6bb0d4d3a3";
                fsType = "ext4";
            };

            # nvidia settings
            hardware.nvidia.prime = {
                nvidiaBusId = lib.mkDefault "PCI:5:0:0";
                amdgpuBusId = lib.mkDefault "PCI:6:0:0";
            };
        };

        options.my.hardware.graphics.igpu.drm = lib.mkOption {
            type = lib.types.str;
            description = "DRM rendering device for the integrated GPU.";
            default = "/dev/dri/by-path/pci-0000:06:00.0-render";
        };

        options.my.hardware.graphics.dgpu.drm = lib.mkOption {
            type = lib.types.str;
            description = "DRM rendering device for the discrete GPU.";
            default = "/dev/dri/by-path/pci-0000:05:00.0-render";
        };
    };
}
