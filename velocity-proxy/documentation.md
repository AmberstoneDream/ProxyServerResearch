# Creating a Minecraft server network with Velocity

This document summarizes the configuration of the Velocity proxy with Paper Minecraft servers.

You should be able to create servers accessible from a single gateway by following the steps below.

> If you are using a Docker container, make sure to map a port for the Velocity proxy (default is `25577`).

## I. Paper server installation

> This section follows the Paper's [Getting started](https://docs.papermc.io/paper/getting-started) page.

- Download Paper (find the latest build [here](https://papermc.io/downloads/paper)):
  ```shell
  wget -P ~/paper/ https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/84/downloads/paper-mojmap-1.20.1-84.jar
  ```
  > Replace the link with the version you want (probably the latest release).

- Execute downloaded JAR file:
  ```shell
  cd ~/paper/

  java -Xms6G -Xmx6G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -jar paper*.jar --nogui
  ```
  - You can specify the port by adding `--port=<PORT>`, **but we'll define it later** in the `server.properties`.
  - You can edit the initial RAM allocation `-Xms`, and the maximal RAM allocation `-Xmx`, but it is recommended to use at least 6-10GB ([read more about JVM startup flags here](https://docs.papermc.io/paper/aikars-flags#recommended-memory)).

- Accept Minecraft [EULA](https://aka.ms/MinecraftEULA) by setting `eula=true` in `eula.txt`.

- Execute `paper*.jar` again to launch the server:
  ```shell
  java -Xms6G -Xmx6G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -jar paper*.jar --nogui
  ```

- Your Minecraft server is now running on `127.0.0.1:25565`.

> This document is not intended to describe the configuration of a Paper server. Nevertheless, you will find here a detailed explanation of each Paper configuration parameter:
> * [Paper Global Configuration](https://docs.papermc.io/paper/reference/global-configuration)
> * [Paper World Configuration](https://docs.papermc.io/paper/reference/world-configuration)

## II. Velocity proxy installation

> This section follows the Velocity's [Getting started](https://docs.papermc.io/velocity/getting-started) page.

- Download Velocity (find the latest build [here](https://papermc.io/downloads/velocity)):
  ```shell
  wget -P ~/velocity/ https://api.papermc.io/v2/projects/velocity/versions/3.2.0-SNAPSHOT/builds/260/downloads/velocity-3.2.0-SNAPSHOT-260.jar
  ```
  > Replace the link with the version you want (probably the latest release).

- Create the Velocity starter file:
  ```shell
  cd ~/velocity/

  echo -e '#!/bin/sh\n\njava -Xms1G -Xmx1G -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15 -jar velocity*.jar' > start.sh

  chmod +x start.sh
  ```
  > More information about the heap allocation in the [Tuning Velocity](https://docs.papermc.io/velocity/tuning#allocate-enough-heap) page.

- Launch Velocity once:
  ```shell
  ./start.sh
  ```

- Stop the execution by typing:
  ```
  end
  ```

## III. Player information forwarding

> This section follows the [Player information forwarding](https://docs.papermc.io/velocity/player-information-forwarding) page.

You need to configure the player information forwarding.

For this, you could use the BungeeCord or BungeeGuard forwarding because they have better compatibility, **but as they are less secure**, you should use the Velocity modern forwarding.

- Define the modern forwarding mode in `velocity.toml`:
  ```toml
  player-info-forwarding-mode = "modern"
  ```

## IV. Servers configuration

### A. Define server IP address and port

For each new server:

- Open `server.properties`, and update these lines:
  ```properties
  server-ip=127.0.0.1

  server-port=<PORT>
  ```

  > Choose a different port for each server (default is `25565`).

### B. Online-mode server configuration

> This section is the continuation of the Velocity's [Getting started](https://docs.papermc.io/velocity/getting-started) page and [Player information forwarding](https://docs.papermc.io/velocity/player-information-forwarding).

For each new server, please follow these steps:

- Make sure `bungeecord` is disabled in `spigot.yml`:
  ```yml
  settings:
      bungeecord: false
  ```

- Edit the following variables in `config/paper-global.yml`:
  ```yml
  proxies:
      # [...]
      velocity:
          enabled: true # Enable Velocity support
          online-mode: true # Same value as the "online-mode" setting in your velocity.toml
          secret: 'your-secret-here' # Find your secret key in forwarding.secret
  ```

- Disable `online-mode` in `server.properties`:
  ```properties
  online-mode=false
  ```

### C. Adding backend servers to the proxy

> This section follows the server configuration of the Velocity's [Getting started](https://docs.papermc.io/velocity/getting-started) page.

- Add your backend servers (Minecraft servers) in `velocity.toml`:
  ```toml
  [servers]
  hub = "127.0.0.1:25565"
  creative = "127.0.0.1:25566"

  try = [
      "hub"
  ]
  ```

  - `127.0.0.1` because your Minecraft servers are on the same machine as the proxy, and you should have entered it in `server-ip`, in `servers.properties`.
  - The port must be the same as the one you specified in `server-port`, in `servers.properties`
  - `try` is used to specify the order in which Velocity should try servers when a player logs in or is kicked from a server.

### D. Connect to your server

- Start Velocity:
  ```shell
  ./start.sh
  ```

- The proxy is now open on port `25577`, making your Minecraft servers accessible on `127.0.0.1:25577`.

  > To change server in-game, run `/server <SERVER>`.

### E. Other relevant configurations

Here are some other variables that you may want to change:

- If you have a huge map, reduce `max-auto-save-chunks-per-tick` in `config/paper-world-default.yml`:
  ```yml
  max-auto-save-chunks-per-tick: 8
  ```

- Paper adds an efficient Anti X-ray that can be enabled in `anti-xray` in `config/paper-world-default.yml`. <br/>
  For the full configuration, please consult the official documentation: https://docs.papermc.io/paper/anti-xray.

- If your server contains a lot of armor stands , disabling `tick` might slightly boost performance, in `config/paper-world-default.yml`:
  ```yml
  entities:
      armor-stands:
          do-collision-entity-lookups: true
          tick: false
  ```
  
  > Ticking is `true` by default, it is used to check wether armor stands should break because of a water flow.

## V. Securing your server

> This section follows the [Securing your server](https://docs.papermc.io/velocity/security) page.

### A. Velocity proxy and Minecraft servers on the same machine

If you are hosting your proxy (Velocity) on the same machine as all your backend servers (Minecraft servers), you only have to bind your backend servers to `localhost` (or `127.0.0.1`).

- Open the `server.properties` of your server and set this IP address:
  ```properties
  server-ip=127.0.0.1
  ```

This is very simple way of protecting your Minecraft servers from external connections!

With an external proxy, you'd have to configure an encryption tunnel for secured communication to your backend servers, which can be tricky.

### B. Set up a firewall

The Velocity modern forwarding explained above in this document is not a replacement for a firewall.

It is highly recommended to configure a firewall on your server, follow this tutorial to get started with `nftables`: https://linuxhint.com/nftables-tutorial/.

As for `iptables` (which is getting deprecated), you'll need root permissions to configure the firewall.

### C. Other important security advices

- Keep frequent backups of your server.
- Run your servers as an unprivileged user (this means no `root` or `sudo` access for Linux users).
- Update Velocity, your Minecraft servers and their plugins, and your operating system frequently.
- Use strong passwords (for SSH connections, use SSH keys rather than passwords).
- Carefully think about the potential impacts of installing any plugins or software before actually doing so.
- Secure any and all other services you may be running on your server.
- Follow all system hardening advice for your operating system.
