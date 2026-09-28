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

	flake.nixosModules.nvidia-laptop = {pkgs, lib, config, ...}: {
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
			};
		};
	};

}
