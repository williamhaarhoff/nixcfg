{ self, inputs, ...}: {

	flake.nixosModules.niri = {pkgs, lib, ...}: {
		programs.niri = {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
		};
	};

	perSystem = { pkgs, lib, self', ... }: {
		packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
			inherit pkgs;
			settings = {
				spawn-at-startup = [
					(lib.getExe self'.packages.myNoctalia)
				];
				input.keyboard = {
					xkb.layout = "us,ua";
				};

				xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
			
				window-rule = [ {
						geometry-corner-radius = 6;
						clip-to-geometry = true;
				} ];

				layout = {
					gaps = 6;
					focus-ring.width = 2;

					preset-column-widths = [
					 { proportion = 0.33; }
					 { proportion = 0.5; }
					 { proportion = 0.66; }
					];

					preset-window-heights = [
					 { proportion = 0.33; }
					 { proportion = 0.5; }
					 { proportion = 0.66; }
					];

					default-column-width = {
						proportion = 0.5;
					};
				};
				
				binds = {
					"Mod+Return".spawn-sh = lib.getExe pkgs.kitty;

					"Mod+Shift+Return".spawn-sh = 
						"${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";

					"Mod+Q".close-window = {};

          "Mod+F".maximize-column = {};
          "Mod+G".fullscreen-window = {};
          "Mod+Shift+F".toggle-window-floating = {};
          "Mod+C".center-column = {};

					# preset select
					"Mod+R".switch-preset-column-width = {};
					"Mod+Shift+R".switch-preset-column-width-back = {};

					# inter monitor focus
					"Mod+Y".focus-monitor-left = {};
					"Mod+Home".focus-monitor-left = {};
          "Mod+O".focus-monitor-right = {};
          "Mod+End".focus-monitor-right = {};

					# intra monitor focus
          "Mod+H".focus-column-left = {};
          "Mod+L".focus-column-right = {};
          "Mod+K".focus-window-up = {};
          "Mod+J".focus-window-down = {};
          "Mod+Left".focus-column-left = {};
          "Mod+Right".focus-column-right = {};
          "Mod+Up".focus-window-up = {};
          "Mod+Down".focus-window-down = {};

					# inter workspace focus
					"Mod+U".focus-workspace-down = {};
					"Mod+I".focus-workspace-up = {};
					"Mod+Page_Down".focus-workspace-down = {};
					"Mod+Page_Up".focus-workspace-up = {};

					# intra monitor movement
					"Mod+BracketLeft".consume-or-expel-window-left = {};
					"Mod+BracketRight".consume-or-expel-window-right = {};
					"Mod+Comma".consume-window-into-column = {};
					"Mod+Period".expel-window-from-column = {};

          "Mod+Shift+H".move-column-left = {};
          "Mod+Shift+L".move-column-right = {};
          "Mod+Shift+K".move-window-up = {};
          "Mod+Shift+J".move-window-down = {};
					"Mod+Shift+Left".move-column-left = {};
          "Mod+Shift+Right".move-column-right = {};
          "Mod+Shift+Up".move-window-up = {};
          "Mod+Shift+Down".move-window-down = {};

					# inter monitor movement
          "Mod+Shift+Y".move-column-to-monitor-left = {};
          "Mod+Shift+O".move-column-to-monitor-right = {};

					# inter workspace movement
          "Mod+Shift+U".move-column-to-workspace-down = {};
          "Mod+Shift+I".move-column-to-workspace-up = {};


          "Mod+1".focus-workspace = "w0";
          "Mod+2".focus-workspace = "w1";
          "Mod+3".focus-workspace = "w2";
          "Mod+4".focus-workspace = "w3";
          "Mod+5".focus-workspace = "w4";
          "Mod+6".focus-workspace = "w5";
          "Mod+7".focus-workspace = "w6";
          "Mod+8".focus-workspace = "w7";
          "Mod+9".focus-workspace = "w8";
          "Mod+0".focus-workspace = "w9";

          "Mod+Shift+1".move-column-to-workspace = "w0";
          "Mod+Shift+2".move-column-to-workspace = "w1";
          "Mod+Shift+3".move-column-to-workspace = "w2";
          "Mod+Shift+4".move-column-to-workspace = "w3";
          "Mod+Shift+5".move-column-to-workspace = "w4";
          "Mod+Shift+6".move-column-to-workspace = "w5";
          "Mod+Shift+7".move-column-to-workspace = "w6";
          "Mod+Shift+8".move-column-to-workspace = "w7";
          "Mod+Shift+9".move-column-to-workspace = "w8";
          "Mod+Shift+0".move-column-to-workspace = "w9";

				};
			};
		};
	};

}




