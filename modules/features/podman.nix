{self, inputs, ...}: {
	flake.nixosModules.podman = {pkgs, lib, config, ...}: {
		hardware.nvidia-container-toolkit.enable = true;
		#hardware.nvidia.allowUnfree = true;

		virtualisation.containers.enable = true;
		virtualisation.podman = {
			enable = true;
			dockerCompat = true;
			defaultNetwork.settings.dns_enabled = true;
		};
	};
}
