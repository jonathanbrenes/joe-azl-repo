# Joe's Own Editor — Azure Linux RPM

Pre-built RPM packages of [Joe's Own Editor](https://joe-editor.sourceforge.io/) for [Azure Linux](https://github.com/microsoft/azurelinux).

## Install

### Option A: Standalone RPM (one-time)

```bash
# Download the latest release
curl -LO https://github.com/jonathanbrenes/joe-azl-repo/releases/latest/download/joe-4.6-24.azl4.x86_64.rpm

# Install
sudo tdnf install ./joe-4.6-24.azl4.x86_64.rpm
```

### Option B: Self-hosted TDNF repo (with updates)

1. Download and extract the repo tarball to a web-accessible location:
   ```bash
   curl -LO https://github.com/jonathanbrenes/joe-azl-repo/releases/latest/download/joe-azl-repo.tar.gz
   mkdir -p /srv/joe-repo
   tar xzf joe-azl-repo.tar.gz -C /srv/joe-repo
   ```

2. Serve it via any HTTP server (nginx, Azure Blob Storage, etc.), then on each client:
   ```bash
   sudo tee /etc/yum.repos.d/joe-editor.repo << 'EOF'
   [joe-editor]
   name=Joe Editor for Azure Linux
   baseurl=https://your-server.example.com/joe-repo/
   enabled=1
   gpgcheck=0
   EOF

   sudo tdnf install joe
   ```

## Build locally

```bash
# Clone Azure Linux
git clone https://github.com/microsoft/azurelinux.git
cd azurelinux

# Add joe component
sed -i '/^\[components\.jo\]$/a [components.joe]' base/comps/components.toml

# Build (requires mock + azldev)
azldev comp update -p joe -q
azldev comp render -p joe
azldev comp build -p joe -q
# RPM is in base/out/rpms/
```

## Rebuild on new release

Push a new tag to trigger the GitHub Actions workflow:

```bash
git tag v4.6-24
git push origin v4.6-24
```

## License

Joe is licensed under [GPL-2.0-or-later](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html).
