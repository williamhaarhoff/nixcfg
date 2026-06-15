{self, inputs, ...}: {

	flake.nixosModules.nvidia = {pkgs, lib, config, ...}: {
		hardware.graphics.enable = true; 
		services.xserver.videoDrivers = ["nvidia"];
		hardware.nvidia = {
			modesetting.enable = true;
			powerManagement.enable = true;
			powerManagement.finegrained = false;
			open = false;
			nvidiaSettings = true;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
		};
	};

	flake.nixosModules.nvidiaLaptop = {pkgs, lib, config, ...}: {
		hardware.graphics.enable = true; 
		hardware.graphics.enable32Bit = true;
		services.xserver.videoDrivers = ["nvidia"];
		hardware.nvidia = {
			modesetting.enable = true;
			open = true;
			nvidiaSettings = true;
			powerManagement.enable = true;
			powerManagement.finegrained = true;

			package = config.boot.kernelPackages.nvidiaPackages.stable;
			prime = {
				offload.enable = true;
				offload.enableOffloadCmd = true;
				nvidiaBusId = "PCI:5:0:0"; # this is hardware specific, todo abstract this away
				amdgpuBusId = "PCI:6:0:0";
			};
		};
	};

}
