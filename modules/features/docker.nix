{self, inputs, ...}: {
	flake.nixosModules.docker = {pkgs, lib, config, ...}: {
		hardware.nvidia-container-toolkit.enable = true;
		virtualisation.containers.enable = true;
		virtualisation.docker = {
			enable = true;
		};
	};
}
