{self, inputs, ...}: {
    flake.nixosModules.power-management = {pkgs, lib, config, ...}: {
        
        services.tlp = {
            pd.enable = true;
            enable = true;
            extraConfig = ''
                TLP_PROFILE_AC=BAL
                TLP_PROFILE_BAT=SAV
                PCIE_ASPM_ON_AC=default
                PCIE_ASPM_ON_BAT=powersave
            '';
        };

		environment.systemPackages = with pkgs; [
            nvtopPackages.full
            powertop 
        ];
    };
}