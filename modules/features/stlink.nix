{self, inputs, ...}: {
	flake.nixosModules.stlink = {pkgs, lib, config, ...}: {
		  services.udev.packages = [ 
			pkgs.probe-rs-tools
			pkgs.stlink 
			(pkgs.writeTextFile {
			name = "99-stlink.rules";
			destination = "/etc/udev/rules.d/99-stlink.rules";
			text = ''
				# ST-Link v2
				SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="0666", GROUP="plugdev"
				# ST-Link v2-1
				SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374b", MODE="0666", GROUP="plugdev"
				# ST-Link v3
				SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374d", MODE="0666", GROUP="plugdev"
			'';
			})
		];
	};
}
