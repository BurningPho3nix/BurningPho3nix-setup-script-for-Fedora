#!/bin/bash

echo "Welcome to my DNF configuration script!"

PS3="Please select an option: "

options=("Set defaultyes=True" "Set max_parallel_downloads=10" "Set all recommended options" "Add custom option" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Set defaultyes=True")
      sudo dnf config-manager --setopt="defaultyes=True" --save
      echo "defaultyes=True has been set."
      ;;
      
    "Set max_parallel_downloads=10")
      sudo dnf config-manager --setopt="max_parallel_downloads=10" --save
      echo "max_parallel_downloads=10 has been set."
      ;;
      
    "Set all recommended options")
      sudo dnf config-manager --setopt="defaultyes=True" --setopt="max_parallel_downloads=10" --save
      echo "All options have been set."
      ;;
      
    "Add custom option")
      echo "Enter the name of the option you want to add (without any spaces): "
      read option_name
      echo "Enter the value of the option: "
      read option_value
      sudo dnf config-manager --setopt="$option_name=$option_value" --save
      echo "$option_name=$option_value has been added."
      ;;
      
    "Quit")
      if [ -f "start.sh" ]; then
        chmod +x start.sh
        ./start.sh
      else
        echo "The start.sh script does not exist."
      fi
      break
      ;;
      
    *) echo "Invalid option $REPLY";;
  esac
done

echo "Configuration completed!"
