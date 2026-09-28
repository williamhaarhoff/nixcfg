{self, inputs, ...}: {

	flake.nixosModules.fhs-compat = {pkgs, lib, config, ...}: 

    let deps = p : with p; [
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
        
        libXcomposite
        libXtst
        libXrandr
        libXext
        libX11
        libXfixes
        libGL
        libva
        pipewire
        libxcb
        libXdamage
        libxshmfence
        libXxf86vm
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
    ]; 
    in
    {
        # nix-ld for general binary compatibility
        programs.nix-ld.enable = true;
        programs.nix-ld.libraries = deps pkgs;

        # for running random app images 
        programs.appimage = {
            enable = true;
            binfmt = true;
            package = pkgs.appimage-run.override {
                extraPkgs = deps;
            };
        };
    };
}
