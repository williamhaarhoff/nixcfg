{self, inputs, ...}: {
	flake.nixosModules.pragmatism = {pkgs, lib, config, ...}: {
        programs.nix-ld.enable = true;
        programs.nix-ld.libraries = with pkgs; [ 
            stdenv.cc.cc 
            zlib 
            openssl
        ];
	};
}
