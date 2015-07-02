# README for swift-t deb packages
These deb packages will install the necessary files in `/usr/bin/swift-t` and some shared libraries in `/usr/lib`. They also add a few lines into the `/etc/profile` file to export the paths to the binaries to the $PATH environment variable. Make sure you source the `/etc/profile` for the current shell session after installing these deb packages. When you remove the packages (using `apt-get remove` or something), these export lines will be removed from `/etc/profile` automatically.

# Packages
There is one meta-package named `swift-t_0.8.0`, and it simply depends on (and installs) the four required packages:
* `exm-c-utils_0.4.0`
* `adlb-x_0.6.0`
* `stc_0.6.0`
* `turbine_0.7.0`

# Installation Instructions

Try one of the two methods:

1- Using `apt-get`
* Add swift-t to your sources (TODO), then run `sudo apt-get update`.
* Run `sudo apt-get install swift-t` to install all the four required packages and their dependencies.

2- Download .deb packages
* Download all four .deb packages.
* Install them using `sudo dpkg -i <package_name>`. When it gives you a dependency error, just run `sudo apt-get -f install` to install the required dependencies. Try again and it should work now.
  
**Make sure you source `/etc/profile` directly after installing (only for the first time).**

