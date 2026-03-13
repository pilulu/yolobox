# Customizing the Image

## Building the Base Image

```bash
make image
```

This builds `ghcr.io/finbarr/yolobox:latest` locally, overriding the remote image.

## Creating a Custom Image

Want to pre-install additional packages or tools?

### 1. Clone and modify

```bash
git clone https://github.com/finbarr/yolobox.git
cd yolobox
# Edit the Dockerfile to add your packages
```

### 2. Build with a custom name

```bash
make image IMAGE=my-yolobox:latest
```

### 3. Configure yolobox to use it

```bash
mkdir -p ~/.config/yolobox
echo 'image = "my-yolobox:latest"' > ~/.config/yolobox/config.toml
```

::: tip
Using a custom image name means `yolobox upgrade` won't overwrite your customization. When you update your Dockerfile, just rebuild with the same command.
:::
