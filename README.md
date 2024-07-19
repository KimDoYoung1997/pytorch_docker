
# PyTorch Docker Environment

This repository contains Docker configurations to set up a development environment for PyTorch with NVIDIA GPU support, ROS, and ROS2.

## Files

- `Dockerfile`: The Dockerfile to build the custom image.
- `build.sh`: Shell script to build the Docker image.
- `run_container.sh`: Shell script to run the Docker container with the necessary configurations.

## Prerequisites

Ensure that you have the following installed on your system:
- Docker
- NVIDIA Docker (nvidia-docker)

## Docker Image Versions

The Dockerfile uses the following base image:
- **PyTorch**: 2.3.1
- **CUDA**: 12.1
- **cuDNN**: 8
- **Development**: devel

You can modify the `Dockerfile` to use different versions of PyTorch, CUDA, or cuDNN by changing the `FROM` line:
```dockerfile
FROM pytorch/pytorch:<pytorch_version>-cuda<cuda_version>-cudnn<cudnn_version>-devel
```
For example, to use PyTorch 2.2.0 with CUDA 11.8 and cuDNN 8, you would update the `FROM` line to:
```dockerfile
FROM pytorch/pytorch:2.2.0-cuda11.8-cudnn8-devel
```

## Building the Docker Image

1. Clone this repository:
    ```sh
    git clone https://github.com/KimDoYoung1997/pytorch_docker.git
    cd pytorch_docker
    ```

2. Make sure `build.sh` is executable:
    ```sh
    chmod +x build.sh
    ```

3. Run the build script to build the Docker image:
    ```sh
    ./build.sh
    ```

## Running the Docker Container

1. Make sure `run_container.sh` is executable:
    ```sh
    chmod +x run_container.sh
    ```

2. Run the container:
    ```sh
    ./run_container.sh
    ```

This script will start a Docker container with the following configurations:
- NVIDIA GPU support
- Shared X11 display for GUI applications
- ROS and ROS2 support
- Shared `/workspace` directory for persistent storage

## Customizing the Environment

If you need to install additional Python packages or system dependencies, you can modify the `Dockerfile` accordingly and rebuild the image using `build.sh`.

## Notes

- The `--privileged` option is used in `run_container.sh` to allow the container to access host devices. Use this option with caution as it grants the container elevated privileges.
- Ensure that you have the necessary permissions to access NVIDIA devices on your host system.

## Troubleshooting

- If you encounter issues with NVIDIA Docker, ensure that your NVIDIA drivers and Docker are properly installed and configured.
- For X11 forwarding issues, ensure that your host system allows connections from Docker containers.

## Contributing

If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
