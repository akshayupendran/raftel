# WSL2 with Ubuntu

## Winget

Get the windows package manager from [GitHub](https://github.com/microsoft/winget-cli/releases)

## Terminal

- Install [Terminal](https://github.com/Microsoft/Terminal) via WinGet
- Change terminal settings as per [docs](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes)
- My settings is archived at [Terminal Configuration File](./terminal_settings.json)

## WSL2

- Manually install apx from [microsoft](https://docs.microsoft.com/en-us/windows/wsl/install-manual#downloading-distributions) as store is not available in Visteon.
- Update the local packages.
- Upgrade the local packages.
- Install man-db.
- Install tree.

## Adding WSL Distro to Terminal (Already completed if you have copied [Terminal Configuration File](./terminal_settings.json))

- If WSL2 terminal not default,
  - Generate a new guid via power shell as ```[guid]::NewGuid()```.
  - Add the following snippet:

  ```json
  "commandline": "debian.exe",
  "guid": "{c857f6d0-5d4b-45e3-9bb0-a13e19bc1628}",
  "hidden": false,
  "name": "Debian"
  ```

## Git

- Install Git
- Configure global user name via ```git config --global user.name "Foo Bar"```
- Configure global user email via ```git config --global user.email foo@bar.com"```
- git clone [Akshay's Wiki](https://github.com/akshayupendran/wsl-setup.git)

## Adding DotFiles

- Copy the folder [Bash Git Prompt](./.bash-git-prompt/) to Home folder. Forked from ```https://github.com/magicmonty/bash-git-prompt```
- Copy the [Bash Aliases](./.bash_aliases) to home folder.
- Change the user specific shortcuts as per your pc.
- Compare and merge the [Bash RC](./.bashrc) to home folder.
- Copy the [LS Colors](./.dircolors) to home folder. Forked from ```https://github.com/trapd00r/LS_COLORS```.
- Copy the [Functions](./.functions) to home folder.
- Source the bashrc.
- Open [Git Config](./gitconfig)

## Ctags

- Install universal-ctags.

## NEOVIM





- Dotfiles archived at [dotfiles](./dotfiles/) 
- sudo apt install net-tools
- sudo apt install ghostscript
- sudo apt install tree
- sudo apt install python3-pip
- git config --global user.name akrish10
- git config --global user.email akrish10@visteon.com
- sudo groupadd conan_user 
- sudo usermod akrish10 -aG conan_user -g conan_user
- sudo mkdir /home/conan
- sudo chown -R root:conan_user /home/conan/
- sudo chmod 770 /home/conan/
- sudo adduser anamica
- sudo usermod anamica -aG conan_user -g conan_user
- export location="chennai"
- pip install devNext -extra-index-url https://jfrog.${location}.visteon.com/artifactory/api/pypi/pypi-virtual/simple --trusted-host jfrog.${location}.visteon.com --no-cache-dir --user
- make sure to remove dist in devNext file if required (2 places).

## 32 bit binaries in focal

- sudo dpkg --add-architecture i386
- sudo apt-get update
- sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386


## Podman

[podman on wsl2](https://www.redhat.com/sysadmin/podman-windows-wsl2)
- . /etc/os-release
- sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/x${NAME}_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
- wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/x${NAME}_${VERSION_ID}/Release.key -O Release.key
- sudo apt-key add - < Release.key
- sudo apt-get update -qq
- sudo apt-get -qq -y install podman
- sudo mkdir -p /etc/containers
- echo -e "[registries.search]\nregistries = ['docker.io', 'quay.io']" | sudo tee /etc/containers/registries.conf
- Download and copy the Zscaler root certificate from visteon.service-now.com and run sudo cp ~/ZscalerRootCertificate-2048-SHA256.crt /etc/ssl/certs/
- Download and copy the Visteon_Root_CA.crt from jfrog/DevOpsApplicationEngineer/GIT/ and run above command.
- podman pull jfrog.chennai.visteon.com/docker-local/vbuild_linux_devenv:devNext

## System Requirements for build

- sudo apt install srecord
- sudo apt install doxygen
- sudo apt install graphviz
- sudo apt install genisoimage
- pip install pycryptodome
- copy qnx license`
