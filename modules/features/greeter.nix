{self, inputs, ...}: {
    flake.nixosModules.greeter = {pkgs, lib, config, ...}: {
		services.greetd = {
			enable = true;
			settings = {
				default_session = {
					user = "will";	
					command = "${pkgs.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
				};	
			};	
		};	

		systemd.services.greetd = {
			unitConfig = {
				After = [ "multi-user.target" ]; # Ensures crucial logs finish first
			};
			serviceConfig = {
				Type = "idle"; # Waits for systemd to finish printing all queue logs
				StandardInput = "tty";
				StandardOutput = "null"; # Silences standard system output over the greeter
				StandardError = "journal"; # Routes errors safely to journald instead of the screen
				TTYReset = true;
				TTYVHangup = true;
				TTYVTDisallocate = true;
			};
		};
    };
}