{self, inputs, ...}: {
	flake.nixosModules.fhs-compat = {pkgs, lib, config, ...}: {
        programs.nix-ld.enable = true;
        programs.nix-ld.libraries = with pkgs; [ 
            zstd
            stdenv.cc.cc
            curl
            openssl
            attr
            libssh
            bzip2
            libxml2
            acl
            libsodium
            util-linux
            xz
            systemd
            libz

            cups
            freetype
            sane-backends
            zlib
            stdenv.cc.cc
            pkcs11helper

            qt6Packages.qtbase
            qt6Packages.qtsvg
            qt6Packages.qtdeclarative
            qt6Packages.qt5compat

            libxkbcommon

            
            xorg.libXcomposite
            xorg.libXtst
            xorg.libXrandr
            xorg.libXext
            xorg.libX11
            xorg.libXfixes
            libGL
            libva
            pipewire
            xorg.libxcb
            xorg.libXdamage
            xorg.libxshmfence
            xorg.libXxf86vm
            libelf

            glib
            gtk2

            networkmanager      
            vulkan-loader
            libgbm
            libdrm
            libxcrypt
            coreutils
            pciutils
            #zenityl
        ];
	};
}
