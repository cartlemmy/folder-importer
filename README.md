# pali-folder-importer

## Dependencies
* curl
* imagemagick

## Install

### Mac Specific
Install homebrew, curl, and imagemagick
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew install git curl imagemagick
```

### Debian-based Specfic (Ubuntu, Linux Mint, etc...)
```
sudo apt-get update
sudo apt-get install git curl imagemagick
```

### Install Folder Importer
```
cd ~

git clone https://github.com/cartlemmy/folder-importer

cd folder-importer
```

### Run setup.sh
```
ls -l /Volumes # List harddrives to find name of drive to use in ./setup.sh

#Run ./setup.sh
```

Good luck
