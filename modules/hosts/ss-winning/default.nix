{self, inputs, ...}: {
  
  flake.nixosConfigurations.ss-winning = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.ssWinningConfiguration ];
  };

}

