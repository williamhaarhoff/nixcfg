{self, inputs, ...}: {
	flake.nixosModules.qgis = {pkgs, ...}: {
		environment.systemPackages = [pkgs.qgis];
	};
}
