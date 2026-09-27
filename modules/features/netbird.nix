{self, inputs, ...}: {
	flake.nixosModules.netbird = {pkgs, lib, config, ...}: {
		services.netbird.enable = true;

		systemd.services.netbird-up = {
			description = "Configure NetBird without DNS management";
			after = [ "netbird.service" ];
			requires = [ "netbird.service" ];
			wantedBy = [ "multi-user.target" ];

			serviceConfig = {
				Type = "oneshot";
				ExecStart = "${pkgs.netbird}/bin/netbird up --disable-dns --dns-resolver-address \"127.0.0.1:53\"";
				RemainAfterExit = true;
			};
		};
		environment.systemPackages = [ pkgs.netbird ];
	};
}
