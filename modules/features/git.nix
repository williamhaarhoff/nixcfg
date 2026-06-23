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

		# todo - ssh agent does not add the keys on startup - need a solution
		#programs.ssh.enable = true; # todo - split out ssh enable
		#programs.ssh.startAgent = true;
		programs.ssh.extraConfig = ''
			Host will-personal
				HostName github.com
				User git 
				IdentityFile ~/.ssh/will-personal
				IdentitiesOnly yes
			Host will
				HostName bitbucket.org
				User git 
				IdentityFile ~/.ssh/will
				IdentitiesOnly yes
			'';

		environment.systemPackages = [
			pkgs.lazygit
			pkgs.gitkraken
		];
	};
}




				
