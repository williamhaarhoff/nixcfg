{self, inputs, ...}: {

	flake.nixosModules.bambu-studio = {pkgs, lib, ...}: {
		environment.systemPackages = [pkgs.bambu-studio];
	};
}
