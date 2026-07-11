{self, inputs, ...}: {
  flake.nixosModules.nixSettings = {pkgs, lib, config, ...}: {
    nix.settings ={
        access-tokens = [
          "github.com=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"
        ];
    };
  };
}