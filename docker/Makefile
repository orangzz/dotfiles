GHCR_REGISTRY ?= ghcr.io
IMAGE_NAME ?= orangzz/dotfiles
IMAGE_VERSION ?= latest

build-and-push:
	podman build --squash --no-cache -t

docker build  \
	--platform ${{ steps.metadata.outputs.docker_platforms }} \
	--output "type=image,push" \
	--tag ${{ ACR_REGISTRY}}/${{ env.IMAGE_NAME }}:${{ env.IMAGE_VERSION }} \
	--tag ${{ ACR_REGISTRY}}/${{ env.IMAGE_NAME }}:latest \
	--file Dockerfile .



# qemu support emulation of various arch, x86,arm
multi-platform-build:
	docker buildx build \
	--platform linux/amd64,linux/arm64/v8 \
	--tag $(GHCR_REGISTRY)/$(IMAGE_NAME):$(IMAGE_VERSION) \
	--tag orangzz/dotfiles:latest \
	--file docker/Dockerfile .
multi-registry-push:
	docker buildx build \
	--push \
	--platform linux/amd64,linux/arm64/v8 \
