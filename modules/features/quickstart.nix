{self, inputs, ...}: {
	flake.nixosModules.quickstart = {pkgs, lib, config, ...}: {
		# this file is to absorb all the jank required to get my system functional
		environment.systemPackages = with pkgs; [
			nautilus
			nemo
			thunar
			htop
			brave
			usbutils
			nfs-utils
			iptables
			fzf
			bind
			clang-tools
			just
			picocom
			fd
			kicad
			networkmanager
		];



		fileSystems."/mnt/my-drive" = {
			device = "/dev/disk/by-uuid/45fff69b-fb23-4b95-bf06-bb6bb0d4d3a3";
			fsType = "ext4";
		};
	};
}
