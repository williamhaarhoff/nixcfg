{self, inputs, ...}: {
    # { pkgs, lib, config, ... } : { 
    #     imports = [ inputs.multiverse.nixosModules.default ];
    #     multiverse.enable = true;
    # };
}

# {self, inputs, ...}: {
#     perSystem = { pkgs, lib, self', config, ... } : { 
#         imports = [ inputs.multiverse.nixosModules.default ];
#         multiverse.enable = true;
#     };
# }

