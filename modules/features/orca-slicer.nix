{ self, inputs, ...}:
{

	flake.nixosModules.orca-slicer = { pkgs, lib, config, ... }: {
		environment.systemPackages = [pkgs.orca-slicer];
	};

}
