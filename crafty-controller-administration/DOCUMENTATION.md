# Installation and configuration of Crafty

This document summarizes the Getting Started tutorial, starting at https://docs.craftycontrol.com/pages/getting-started/installation/linux/.

> For this installation, I assume you already have a user with sudo privileges (`crafty` in this example).

> If you are using a Docker container, make sure to map the port `8443`.

## I. Installation and startup

- Update packages list and install required dependencies:
    ```shell
    sudo apt-get update
    sudo apt-get install -y git python3 python3-dev python3-pip python3-venv software-properties-common openjdk-17-jdk
    ```
    
- Create a directory for Crafty Control, and another one for your servers. Then set `crafty` as the owner of `/var/opt/minecraft/`, and change directory to `/var/opt/minecraft/crafty/`:
    ```shell
    sudo mkdir -p /var/opt/minecraft/crafty /var/opt/minecraft/server
    sudo chown -R crafty:crafty /var/opt/minecraft
    cd /var/opt/minecraft/crafty
    ```
    
- Clone the [source code of Crafty Control](https://gitlab.com/crafty-controller/crafty-4):
    ```shell
    git clone https://gitlab.com/crafty-controller/crafty-4.git
    ```
    
- Create and activate a new virtual environment `/.venv/`, and change directory to `/var/opt/minecraft/crafty/crafty-4`:
    ```shell
    python3 -m venv .venv
    source .venv/bin/activate
    cd /var/opt/minecraft/crafty/crafty-4
    ```
    
- Install required dependencies (listed in `requirement.txt`, in the cloned source code):
    ```shell
    pip3 install --no-cache-dir -r requirements.txt
    ```

- Start the application:
    ```shell
    python3 main.py
    ```
    > Add the `-d` flag if you want to run Crafty as a daemon.

Crafty Control should now be listening on port `8443`. You can open https://localhost:8443.

> **Crafty makes use of HTTPS to protect your personnal data, not HTTP!**<br/>
> More information here: https://docs.craftycontrol.com/pages/getting-started/access/


## II. First connection on Crafty

Default credential are:
- Username: `admin`
- Password: `crafty`

**Change it immediately after logging in**, in `Panel Config` (cogwheel icon) > Edit `admin`.

<img src="https://docs.craftycontrol.com/img/page-assets/user-guide/settings-pointer.png" height="80px" alt="Panel Config button">

The `admin` is a Super User and has access to all servers, so please be careful and use a very secured password.

> Tip: you can also change your language in this editing interface.

**Don't forget to save your changes.**

## III. Configure Crafty

In `Panel Config` (cogwheel icon), there's a `Config.json` section in which you can configure Crafty just as you like.

<img src="https://docs.craftycontrol.com/img/page-assets/user-guide/settings-pointer.png" height="80px" alt="Panel Config button">

> Description of all settings: https://docs.craftycontrol.com/pages/getting-started/config/#craftys-config-file-configjson

Settings you may want to change now:
- `https_port`
    > If your OS runs in a Docker container and you change this port, make sure it is mapped, otherwise you won't be able to access it on your host, and you'll have to manually reset it in `/var/opt/minecraft/crafty/crafty-4/app/config/config.json`.
- `language`
    > Crafty default language is set to `en_EN`.

**Don't forget to submit your changes.**

## IV. Public status page

The public status page is accessible via the `/satus` route. If you are running Crafty locally, try: https://localhost:8443/status.

Thanks to this feature, players of your server can be informed at any time about:
- Current server status
- Online player count
- Message of the day (MOTD)

> If you don't want a server to be displayed here, you can disable it with `Show On Public Status Page` on the servers configuration page.