{self, inputs, ...}: {

	# flake.nixosModules.claude = {pkgs, lib, config, ...}: {
    #     nixpkgs.overlays = [ inputs.claude-code.overlays.default ];
    #     environment.systemPackages = [ pkgs.claude-code ];
    # };

    flake.nixosModules.codex = {pkgs, lib, config, ...}: {
        environment.systemPackages = [ 
            self.packages.${pkgs.system}.codex-wrapped
            self.packages.${pkgs.system}.codex-sandbox 
        ];
    };

	perSystem = { pkgs, lib, self', ... }: 

    
    let 
        sandbox = ''
            bwrap \
            --bind / / \
            --tmpfs /home \
            --bind /proc /proc \
            --dev /dev \
            --dir /home/codex \
            --setenv HOME /home/codex \
            --bind "$HOME/.codex" /home/codex/.codex \
        '';
    in
    {
        packages.codex-sandbox = pkgs.writeShellApplication {
            name = "codex-sandbox";

            runtimeInputs = [
                pkgs.bubblewrap
                pkgs.codex
            ];

            text = '' ${sandbox} bash "$@" '';
        }; 

        packages.codex-wrapped = pkgs.writeShellApplication {
            name = "codex-wrapped";

            runtimeInputs = [
                pkgs.bubblewrap
                pkgs.codex
            ];

            text = '' ${sandbox} -- codex "!@" '';
       };
    };
}