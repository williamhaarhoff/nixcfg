{self, inputs, ...}: {
	flake.nixosModules.vllm-container = {pkgs, lib, config, ...}: {
        virtualisation.podman.enable = lib.mkDefault true;
        hardware.nvidia-container-toolkit.enable = lib.mkDefault true;

        virtualisation.oci-containers = {
            backend = lib.mkDefault "podman";
            containers.vllm = {
                image = "docker.io/vllm/vllm-openai:v0.11.0";
                extraOptions = [
                    "--device=nvidia.com/gpu=all"
                    "--ipc=host"
                    "--network=host"
                ];

                cmd = [
                    "--model=Qwen/Qwen3-0.6B"
                    "--host=0.0.0.0"
                    "--tensor-parallel-size=1"
                    "--port=8000"
                ];

                volumes = [
                    "/var/lib/vllm/huggingfaace:/root/.cache/huggingface"
                    "/var/lib/vllm/compule:/root/.cache/vllm"
                ];
            };
        };
	};
}
