{self, inputs, ...}: {
	flake.nixosModules.code = {pkgs, lib, config, ...}: {
		environment.systemPackages = with pkgs; [
			(vscode-with-extensions.override {
				vscodeExtensions = with vscode-extensions; [
					bbenoist.nix
					ms-python.python
					vscodevim.vim
					ms-azuretools.vscode-docker
					ms-vscode-remote.remote-ssh
					ms-vscode-remote.remote-containers
					ms-python.debugpy
					twxs.cmake
					llvm-vs-code-extensions.vscode-clangd
					rust-lang.rust-analyzer
				] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
					{
					name="vscode-just-syntax";
					publisher = "nefrob";
					version = "0.8.0";
					sha256 = "sha256-zuDfIxhiUKRpVRxp9BceW6WPBq5NNCuS1Si0/6kfqF8=";
					}
					{
					name="ruff";
					publisher = "charliermarsh";
					version = "2026.40.0";
					sha256 = "sha256-Qpt4f4vs+R+6WU8kKG3zTD1tbQ1SDAq7VtTEVYlm3gQ=";
					}
				];
			})
		];
	};
}
