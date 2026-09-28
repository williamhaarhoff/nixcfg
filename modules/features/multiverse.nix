{self, inputs, ...}: {
	flake.nixosModules.multiverse = {pkgs, lib, config, ...}: {
		imports = [ inputs.multiverse.nixosModules.default ];
        multiverse.enable = true;
	};
}

