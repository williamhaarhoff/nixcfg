{self, inputs, ...}: {
	flake.nixosModules.myGit = {pkgs, lib, config, ...}: {
		programs.git = {
			enable = true;
			config = {
				init.defaultBranch = "main";

				user = {
					name = "will";
					email = "williamhaarhoff@gmail.com";
				};
			};
		};

		#programs.ssh.enable = true; # todo - split out ssh enable
		programs.ssh.extraConfig = ''
			Host will-personal
				HostName github.com
				User git 
				IdentityFile ~/.ssh/will-personal
				IdentitesOnly yes
			Host will
				HostName bitbucket.org
				User git 
				IdentityFile ~/.ssh/will
				IdentitesOnly yes
			'';

		environment.systemPackages = [pkgs.lazygit];
	};
}




				
