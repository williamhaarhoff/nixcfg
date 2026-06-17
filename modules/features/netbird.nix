{self, inputs, ...}: {
	flake.nixosModules.netbird = {pkgs, lib, config, ...}: {
		services.netbird.enable = true;
		#services.netbird.clients.wt0 = {
			#login = {
			#	enable = true;
			#	setupKeyFile = "/home/will/netbird-key";
			#};

			#routeTraffic = true;
		#	ui.enable = true;
		#	port=9797;
		#};

		environment.systemPackages = [pkgs.netbird];
	};
}
