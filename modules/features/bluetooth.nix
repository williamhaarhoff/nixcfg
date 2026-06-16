{self, inputs, ...}: {
	flake.nixosModules.bluetooth = {pkgs, lib, config, ...}: {
		hardware.bluetooth = {
			enable = true;
			powerOnBoot = false;
		};
	};
}
