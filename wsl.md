# WSL2 Setup

## Author: Akshay Krishna Upendran

## Winget (Optional)

- Get the windows package manager from [GitHub](https://github.com/microsoft/winget-cli/releases)
- Get latest from assets and install.

## Install fonts (Optional)

I prefer the FiraCode Nerd Font Mono (or)
Install (FantasqueSansMono Nerd Font) [https://github.com/ryanoasis/nerd-fonts]

## Terminal (Optional)

- Install [Terminal](https://github.com/Microsoft/Terminal) via WinGet
- Change terminal settings as per [docs](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes)
- My settings is archived at [Terminal Configuration File](./terminal_settings.json)

## WSL2

- Manually install apx from [microsoft](https://docs.microsoft.com/en-us/windows/wsl/install-manual#downloading-distributions) as store is not available in Visteon.
- Update the local packages. (sudo apt update)
- Upgrade the local packages. (sudo apt -y upgrade)
- Install man-db. (sudo apt -y install man-db)
- Install tree. (sudo apt -y install tree)
- Install Git. (sudo apt -y install git)
- Install python3-pip. (sudo apt -y install python3-pip)

## Adding WSL Distro to Terminal (Optional){Already completed if you have copied [Terminal Configuration File](./terminal_settings.json)}

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

- git clone [Akshay's Wiki](https://github.com/akshayupendran/raftel.git)

## Adding and editing DotFiles

- Compare and merge the [Bash RC](./.bashrc) to home folder.
- Change the theme in Bash RC as per your needs. The list of theme names are available in the folder ```./.bash-git-prompt/themes```. It will be found by searching for ```-------------------- USER BASED SETTINGS ---------------------```.
- Source the bashrc.

- Copy the folder [Bash Git Prompt](./.bash-git-prompt/) to Home folder.
- The above git prompt is Forked from ```https://github.com/magicmonty/bash-git-prompt```

- Copy the [Bash Aliases](./.bash_aliases) to home folder.
- Change the user specific shortcuts as per your pc. It will be found by searching for ```-------------------- USER BASED SETTINGS ---------------------```.
- The aliases are documented in [Functions and Aliases](./functions_aliases.md)

- Copy the [LS Colors](./.dircolors) to home folder. Forked from ```https://github.com/trapd00r/LS_COLORS```.
- Copy the following files forked from ```https://github.com/mathiasbynens/dotfiles```:

1. .curlrc
2. .editorconfig
3. .exports
4. .functions
5. .gdbinit
6. .gitconfig
7. .gitignore
8. .gvimrc
9. .hushlogin
10. .inputrc
11. .path
12. .screenrc
13. .tmux.conf
14. .vimrc
15. .vim/
16. .wgetrc
17. .gitmessage

- Configure global user name via ```git config --global user.name "Foo Bar"```
- Configure global user email via ```git config --global user.email foo@bar.com"``

## Vscode terminal (Optional)

- In settings change font terminal to 'FantasqueSansMono Nerd Font'.
- Install it from ```https://github.com/ryanoasis/nerd-fonts```

## Git related help

- ```git_prompt_help``` will show how the command prompt is organised.
- ```git aliases``` will show the various aliases in git.

## Ctags (Optional)

- Install universal-ctags.
- This section will be filled in the future {TBD}.

## NEOVIM (Optional)

- This section will be filled in the future {TBD}.

### Conan Server Install test (Optional)

- sudo groupadd conan_user
- sudo usermod akrish10 -aG conan_user -g conan_user
- sudo mkdir /home/conan
- sudo chown -R root:conan_user /home/conan/
- sudo chmod 770 /home/conan/
- sudo adduser anamica
- sudo usermod anamica -aG conan_user -g conan_user

### DevNext3 Install

- Edit the `location` in .exports.
- ```python3 -m pip install devNext --extra-index-url https://jfrog.${location}.visteon.com/artifactory/api/pypi/pypi-virtual/simple --trusted-host jfrog.${location}.visteon.com --no-cache-dir --user```
- Optionally make sure to remove dist in devNext file if required (3 places). In $HOME/.local/lib/python3.8/site-packages/devNext/utils/aptutil/apt.py.

## 32 bit binaries in 64-bit focal

- sudo dpkg --add-architecture i386
- sudo apt-get update
- sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386

## Podman

[podman on wsl2](https://www.redhat.com/sysadmin/podman-windows-wsl2)

```bash
. /etc/os-release
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/x${NAME}_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/x${NAME}_${VERSION_ID}/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update
sudo apt-get -y install podman
sudo mkdir -p /etc/containers
echo -e "[registries.search]\nregistries = ['docker.io', 'quay.io']" | sudo tee /etc/containers/registries.conf
Download and copy the Zscaler root certificate from visteon.service-now.com and run sudo cp ~/ZscalerRootCertificate-2048-SHA256.crt /etc/ssl/certs/
Download and copy the Visteon_Root_CA.crt from jfrog/DevOpsApplicationEngineer/GIT/ and run above command.
podman pull jfrog.chennai.visteon.com/docker-local/vbuild_linux_devenv:devNext
```

## System Requirements for build (Optional)

- sudo apt install srecord
- sudo apt install doxygen
- sudo apt install graphviz
- sudo apt install genisoimage
- pip install pycryptodome
- copy qnx license

## Author: Akshay Krishna
