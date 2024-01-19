#!/bin/bash
#In order for this script to work you should have a fresh install of Debian that is ssh'able into.
#You should also have a premade mount point for your storage.  If you do not know how to do that google "how to automatically mount harddrive on boot in debian linux".
echo " ▄▄▄·▄• ▄▄▄▄▄▄    • ▌ ▄ ·. ▄▄▄▄▄▄▄▄▄▄ ·▄▄▄▄       ▄▄▄·▄▄▄ ▄▄▄      .▄▄ ·▄▄▄ ▄▄▄  ▌ ▐▄▄▄ ▄▄▄  ";
echo "▐█ ▀██▪██•██ ▪    ·██ ▐███▐█ ▀•██ ▀▄.▀██▪ ██     ▐█ ▀█▀▄ █▀▄ █·    ▐█ ▀.▀▄.▀▀▄ █▪█·█▀▄.▀▀▄ █·";
echo "▄█▀▀██▌▐█▌▐█.▪▄█▀▄▐█ ▌▐▌▐█▄█▀▀█▐█.▐▀▀▪▐█· ▐█▌    ▄█▀▀█▐▀▀▄▐▀▀▄     ▄▀▀▀█▐▀▀▪▐▀▀▄▐█▐█▐▀▀▪▐▀▀▄ ";
echo "▐█ ▪▐▐█▄█▌▐█▌▐█▌.▐██ ██▌▐█▐█ ▪▐▐█▌▐█▄▄██. ██     ▐█ ▪▐▐█•█▐█•█▌    ▐█▄▪▐▐█▄▄▐█•█▌███▐█▄▄▐█•█▌";
echo " ▀  ▀▄▄▄·▄•▀▄▄▄▄▄▄▀▀  ▪▪•▀▌▀▄ ·.•▀▌▀▄▀·.▄•▀▄▌▐ ▄▄▄▄ .▀.▀  .▀  ▀     ▀▀▀▀ ▀▀▀.▀  . ▀  ▀▀▀.▀  ▀";
echo "    ▐█ ▀██▪██•██ ▪    ██·██ ▐███·██ ▐████▪██•█▌▐▀▄.▀·                                        ";
echo "    ▄█▀▀██▌▐█▌▐█.▪▄█▀▄▐█▐█ ▌▐▌▐█▐█ ▌▐▌▐██▌▐█▐█▐▐▐▀▀▪▄                                        ";
echo "    ▐█ ▪▐▐█▄█▌▐█▌▐█▌.▐▐███ ██▌▐███ ██▌▐█▐█▄███▐█▐█▄▄▌                                        ";
echo "     ▀  ▀ ▀▀▀ ▀▀▀ ▀█▄▀▀▀▀▀  █▪▀▀▀▀  █▪▀▀▀▀▀▀▀▀ █▪▀▀▀                                         ";

function setup() {
    # Check if Python is installed
if command -v python3 &> /dev/null; then
    echo "Python is installed"
else
    echo "Python is not installed"
fi

# Check if Pip is installed
if command -v pip &> /dev/null; then
    echo "Pip is installed"
else
    echo "Pip is not installed"
fi

echo "Updating and upgrading..."

sudo apt install software-properties-common -y

sudo add-apt-repository ppa:deadsnakes/ppa 

sudo apt update

sudo apt upgrade -y

sudo apt install python3.8

sudo apt install python3-pip 

sudo apt install python3-venv

python3 -m venv env

source env/bin/activate

python3 -m pip install ansible-core

python3 -m pip install --upgrade ansible
}

function server_info() {
echo 'Please input server ip address'
read -r ip
echo 'Please input server ssh username'
read -r username
echo 'Please input server ssh password'
read -r password
echo 'You have input:' ip - $ip, username - $username, password - $password.
echo -n "Is the information correct it's case sensitive. [y/n]: "
read answer


function tweak() {
    ansible_cfg="ansible.cfg"
    inventory="inventory.yaml"
    sed -i "s/IPADDRESS/${ip}/g" "$ansible_cfg"
    sed -i "s/USERNAME/${username}/g" "$inventory"
    sed -i "s/PASSWORD/${password}/g" "$inventory"
    echo "Configuration tweaked successfully."
}

if [ "$answer" == "y" ]; then
    tweak
    echo "Information saved"
    # Add your code here for when the user chooses 'y'
elif [ "$answer" == "n" ]; then
    server_info
    # Add your code here for when the user chooses 'n'
else
    echo "Invalid choice. Please enter 'y' or 'n'."
fi
}

setup
server_info