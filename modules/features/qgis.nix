{self, inputs, ...}: {
	flake.nixosModules.qgis = {pkgs, ...}: {
		environment.systemPackages = [inputs.nixpkgs-stable.legacyPackages.${pkgs.system}.qgis];
	};
}
