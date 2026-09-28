{ self, inputs, ... }: {
  flake.nixosModules.bambu-studio = { pkgs, ... }:
    let
		system = "x86_64-linux";
		mv = inputs.multiverse.lib.mkMultiverse {
			inherit system;
			#config.allowUnfree = true;
		};
    in
    {
      environment.systemPackages = [
        (mv.version "bambu-studio" "02.04.00.70")
      ];
    };
}