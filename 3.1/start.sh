#!/bin/bash

echo "Welcome to the my repository installer!"

PS3='Please enter your choice: '
options=("Modify dnf.conf" "Install RPM Fusion Free" "Install RPM Fusion Free Tainted" "Install RPM Fusion Non-Free" "Install RPM Fusion Non-Free Tainted" "DVD Compatibility" "Install All" "Update" "Quit" "Reboot system")
select opt in "${options[@]}"
do
    case $opt in
        "Modify dnf.conf")
            echo "opening dnf modification"
             if [ -f "dnf-mod.sh" ]; then
                chmod +x dnf-mod.sh
            sudo ./dnf-mod.sh
            else
            echo "The dnf-mod.sh script does not exist."
            fi
            ;;
        "Install RPM Fusion Free")
            sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
            sudo dnf groupupdate -y core
            if [ $? -eq 0 ]; then
    echo "Successfully installed RPM"
  else
    echo "Failed to install RPM"
    exit 1
  fi
            ;;
        "Install RPM Fusion Free Tainted")
            sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
            sudo dnf groupupdate -y sound-and-video
            sudo dnf install -y rpmfusion-free-release-tainted
            if [ $? -eq 0 ]; then
    echo "Successfully installed RPMs"
  else
    echo "Failed to install RPMs"
    exit 1
  fi
            ;;
        "Install RPM Fusion Non-Free")
            sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
            sudo dnf groupupdate -y core
            if [ $? -eq 0 ]; then
    echo "Successfully installed RPM"
  else
    echo "Failed to install RPM"
    exit 1
  fi
            ;;
        "Install RPM Fusion Non-Free Tainted")
            sudo dnf install -y rpmfusion-nonfree-release-tainted
            if [ $? -eq 0 ]; then
    echo "Successfully installed RPM"
  else
    echo "Failed to install RPM"
    exit 1
  fi
            ;;
            "DVD Compatibility")
            sudo dnf install -y libdvdcss
             if [ $? -eq 0 ]; then
    echo "Successfully installed RPM"
  else
    echo "Failed to install RPM"
    exit 1
  fi
            ;;
        "Install All")
            sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
            sudo dnf groupupdate -y core
            sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
            sudo dnf groupupdate -y sound-and-video
            sudo dnf install -y rpmfusion-free-release-tainted
            sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
            sudo dnf install -y rpmfusion-nonfree-release-tainted
            sudo dnf install -y libdvdcss
            if [ $? -eq 0 ]; then
    echo "Successfully installed RPMs"
  else
    echo "Failed to install RPMs"
    exit 1
  fi
            ;;
        "Update")
            sudo dnf update -y && flatpak update -y
            if [ $? -eq 0 ]; then
    echo "Successfully installed updates"
  else
    echo "Failed to install updates"
    exit 1
  fi
            ;;
        "Reboot system")
      echo "Rebooting system..."
      reboot
            ;;
        "Quit")
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

echo "Thank you for using the my repository installer! Goodbye."
