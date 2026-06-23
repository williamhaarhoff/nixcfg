{self, inputs, ...}: {
	flake.nixosModules.filemanager = {pkgs, lib, config, ...}: {
		xdg.portal = {
			enable = true;
			extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
			config.niri = { 
				#default = ["gtk"];
				"org.freedesktop.impl.portal.FileChooser" = "gtk";
			};
		};

		# automount external drives
		services.gvfs.enable = true;
		services.udisks2.enable = true;

		environment.systemPackages = [
			pkgs.udiskie
		];
	};
}
