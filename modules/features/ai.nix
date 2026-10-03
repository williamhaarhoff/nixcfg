{self, inputs, ...}: {

	# flake.nixosModules.claude = {pkgs, lib, config, ...}: {
    #     nixpkgs.overlays = [ inputs.claude-code.overlays.default ];
    #     environment.systemPackages = [ pkgs.claude-code ];
    # };

    flake.nixosModules.codex = {pkgs, lib, config, ...}: {
        environment.systemPackages = [ pkgs.codex self.packages.${pkgs.system}.codex-wrapped ];
    };

	perSystem = { pkgs, lib, self', ... }: {
        
        packages.codex-wrapped = pkgs.writeShellApplication {
        name = "codex-wrapped";

        runtimeInputs = [
            pkgs.bubblewrap
            pkgs.codex
            pkgs.cacert
        ];

        text = ''
            exec bwrap \
            --ro-bind /nix/store /nix/store \
            --ro-bind /etc/resolv.conf /etc/resolv.conf \
            --setenv SSL_CERT_FILE ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt \
            --setenv NIX_SSL_CERT_FILE ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt \
            --proc /proc \
            --dev /dev \
            --tmpfs /tmp \
            --tmpfs /home \
            --dir /home/codex \
            --setenv HOME /home/codex \
            --bind "$HOME/.codex" /home/codex/.codex \
            --bind "$PWD" /workspace \
            --chdir /workspace \
            --share-net \
            --new-session \
            --die-with-parent \
            codex "$@"
        '';
        };
    };
}