{self, inputs, ...}: 
  let
    revision = "2026-08-30";
    system = "x86_64-linux";
    mv = inputs.multiverse.multiverse.${system};
    nixpkgs = mv.flakeAt revision;
    pkgs = mv.at revision;
  in 
{
  perSystem._module.args.pkgs = pkgs;
  flake.nixosConfigurations.ss-winning = nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.ss-winning-configuration ];
  };
}

