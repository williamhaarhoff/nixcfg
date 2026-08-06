{self, inputs, ...}: {

	flake.nixosModules.bambu-studio = {pkgs, lib, ...}: 

	let
		cached-bambu-pkgs = import (builtins.fetchTree {
			type = "github";
			owner = "NixOS";
			repo = "nixpkgs";
			rev = "705e9929918b43bd7b715dc0a878ac870449bb03"; # hydra-check bambu-studio -channel 26.05
		}) {
			system = pkgs.system;
			config.allowUnfreePredicate = pkg:
			builtins.elem (lib.getName pkg) [ "bambu-studio" ];
		};
	in {
		environment.systemPackages = [
			cached-bambu-pkgs.bambu-studio
		];
	};
}
