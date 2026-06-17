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
	};
}
