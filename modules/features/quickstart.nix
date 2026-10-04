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
			dnsmasq
			sqlite
			rtklib-ex
			psmisc
			pciutils
			lsof
			uv
		];
	};
}
