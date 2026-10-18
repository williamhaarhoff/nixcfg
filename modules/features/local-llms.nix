{self, inputs, ...}: {
	flake.nixosModules.vllm-server = {pkgs, lib, config, ...}: {
        virtualisation.podman.enable = lib.mkDefault true;
        hardware.nvidia-container-toolkit.enable = lib.mkDefault true;

        systemd.tmpfiles.rules = [
            "d /var/lib/vllm/huggingface 0755 root root -"
            "d /var/lib/vllm/compute 0755 root root -"
        ];

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
                    "/var/lib/vllm/huggingface:/root/.cache/huggingface"
                    "/var/lib/vllm/compute:/root/.cache/vllm"
                ];
            };
        };
	};

    flake.nixosModules.llama-server = {pkgs, lib, config, ...}: 
    let 
        llama = pkgs.llama-cpp.override {
            cudaSupport = true;
        };
    in 
    {
        systemd.tmpfiles.rules = [
            "d /var/lib/llama 0755 root root -"
            "d /var/lib/llama/models 0755 root root -"
        ];

        systemd.services.llama-server = {
            description = "llama.cpp inference server";

            wantedBy = [ "multi-user.target" ];
            after = [ "network-online.target" ];
            wants = [ "network-online.target" ];

            serviceConfig = {
                Type = "simple";
                User = "root";
                Restart = "on-failure";
                RestartSec = 5;

                ExecStart = ''
                    "${llama}/bin/llama-server \
                    --model /var/lib/llama/models/model.gguf \
                    --device CUDA0 \
                    --host 0.0.0.0 \
                    --port 8001
                '';
            };
        };

        networking.firewall.allowedTCPPorts = [8001];
    };
}
