{self, inputs, ...}: {
	flake.nixosModules.hosts = {pkgs, lib, config, ...}: {
		networking.hosts = {
            #"cr.seespider.com" = ["gthqb.netbird.cloud"];
        };
	};
}