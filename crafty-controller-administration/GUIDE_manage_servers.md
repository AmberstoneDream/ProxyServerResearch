# Minecraft server administration with Crafty

This document summarizes the Minecraft server guides listed on the left of this page: https://docs.craftycontrol.com/pages/user-guide/server-creation/minecraft/.

> I assume you already have installed Crafty Control, and it is running on https://localhost:8443.

### Table of content

* [A. Server creation](#a)
* [B. Server configuration](#b)
* [C. File management](#c)
* [D. Backup management](#d)
* [E. Task Scheduler](#e)
* [F. Metrics](#f)

### A. Server creation <div id='a'/>

The server creation interface is probably simple enough for you to understand how to handle it, so I'm not going to explain everything but just highlight the important details.

Full explanation on this Crafty documentation: [Minecraft Server Creation](https://docs.craftycontrol.com/pages/user-guide/server-creation/minecraft/).

<img src="https://docs.craftycontrol.com/img/page-assets/user-guide/server-creation/minecraft/server-builder.png" height="500px">

#### 1. Select a server type

There are multiple server types available _(from the [ServersJar API](https://serverjars.com/))_:

* Minecraft-Java: `Paper`, `Purpur`, `Sponge`, Vanilla and Snapchot
* Minecraft-Bedrock: `Pocketmine`
* Modded servers: `Fabric`, `Forge`, `Mohist`, `Catserver`
* Proxies: `Velocity`, `Bungeecord`, `Waterfall`

> In the case of a proxy server, I highly recommend using Velocity, which was designed from scratch and is much safer than Bungeecord. <br/>
> See this documentation: [Minecraft server network with Velocity](../velocity-proxy/DOCUMENTATION.md).

_I choose to create a Velocity server, and two Paper servers (my goal is to get access to all servers using a single IP address, and to be able to change server in-game with `/server <SERVER>`)._

#### 2. Set the minimum and maximum memory (RAM)

As explained in the Velocity documentation, [it is recommended to use at least 6-10GB of memory](https://docs.papermc.io/paper/aikars-flags#recommended-memory).

#### 3. Define the port

**Make sure not to use the same port for your servers, because `25565` is always the default one!**

_I choose `25577` for my Velocity server, `25565` and `25566` for my Paper servers._

#### 4. Run the server

Once imported, run the server with the **Start** button.

As this is your first time starting the server, you will be asked to confirm you have read and agreed with [Minecraft&#39;s EULA](https://www.minecraft.net/en-us/eula).

<img src="https://docs.craftycontrol.com/img/page-assets/user-guide/server-creation/minecraft/minecraft-eula-prompt.png" height="150px">

**Your server is now running!**

### B. Server configuration <div id='b'/>

The Crafty documentation provides the detailed explanation of the global server configuration on this page: [Minecraft Server Configuration](https://docs.craftycontrol.com/pages/user-guide/server-config/minecraft/).

I'm just reusing their table for this section.

#### 1. Options

| Option | Description |
| ---- | ---- |
| Server Name | The display name for your server within Crafty (local to Crafty). |
| Server Working Directory | The directory where your server is stored. This field is view-only, but the master server's storage location can be changed in the panel sings document. |
| Server Log Location | The path to the latest.log file of your server. This path can be relative to the server's working directory. |
| Server Executable | The name of the executable file that Crafty will launch when you press the start button. |
| Server Execution Command | The command used by Crafty to start your server. |
| Server Stop Command | The command used by Crafty to stop your server. |
| Server Auto Start Delay | The delay duration in seconds before Crafty automatically starts your server after Crafty starts (if enabled). |
| Server Executable Update URL | The direct download link for updating the server executable file. Only applicable to Minecraft Java servers. |
| Server IP | The IP address that Crafty will use to poll your server's statistics. |
| Server Port | The port number that Crafty will use to poll your server's statistics. |
| Shutdown Timeout | The maximum time in seconds that Crafty will wait for your server to shut down before declaring it as hung and terminating the process. |
| Ignored Crash Exit Codes | The exit codes that Crafty's crash detection feature will ignore, treating them as "normal" exits. |
| Remove Old Logs After | The number of days Crafty should keep server log files before automatically removing them (use 0 to disable this option). |

#### 2. Switch buttons

| Switch button | Description |
| ---- | ---- |
| Server Auto Start | Whether Crafty should automatically start your server when Crafty starts. |
| Server Crash Detection | Whether Crafty should attempt to restart your server after a crash. |
| Show On Public Status Page | Whether Crafty should display this server on the public status page (accessible at https://YOUR-IP:8443/status). |

> **Starting a proxy server will not start your Minecraft servers automatically**, `Server Auto Start` is used to start a server on Crafty startup.

#### 3. Buttons

| Button | Description |
| ---- | ---- |
| Update Executable | This button updates the server executable file, including a backup. For Minecraft Java, a direct download link must be provided. See the Server Executable Update URL option. |
| Delete | This button deletes your server. It prompts for confirmation and offers to delete associated files and backups. |

### C. File management <div id='c'/>

Full explanation on this Crafty documentation: [Server File Manager](https://docs.craftycontrol.com/pages/user-guide/file-manager/).

Crafty comes with a file manager in which you can do everything without the need for external software such as FileZilla or WinSCP.

> You could manage your servers with SCP, SFTP, etc. **but this is not recommended** as you will have to manage multiple users and permissions on your linux server and **this could increase security risks.**


#### 1. Context menu

The context menu is the pop-up displaying when you right click a file or a directory.

* File context menu options are `Rename`, `Download` and `Delete`.
* Directory context menu options are `Create file`, `Create directory`,`Rename` and `Upload`.
* `.zip` files have an additional `Unzip` button.

#### 2. Uploading files

Here are a few notes on uploading files that you may want to know about:
* You can upload multiple files at once.
* You can drag and drop the files you may want to upload (by aiming at the "Select files" button).
* **It's not possible to upload a directory, BUT** you can upload a `.zip` of that directory, then right-click and unzip.

#### 3. Edit files

You don't have to download your files to edit them, Crafty comes with an embedded file editor.

To expand the file editor click on the `Toggle Editor Size` button, and adjust the size using the chevrons in the bottom right of the editor.

Make sure to `Save` or to `CTRL`+`S` your file before leaving.

### D. Backup management <div id='d'/>

The backup manager interface is quite self explanitory.

This section is also based on this Crafty documentation: [Server Backup Manager](https://docs.craftycontrol.com/pages/user-guide/backup-manager/).

For each step below, don't forget to hit `Save` after modification before exiting the interface.

#### 1. Max backups

You can set the maximum number of backups to avoid overloading your SSD. Set `0` if you don't want any limit.

#### 2. Compress backup

This option allows you to compress your backups, but **Crafty recommends NOT using it ✖️** as this could lead to unintended side effects such as chunk corruption or artifacting.

#### 3. Shutdown During Backup

This option allows you to stop your server for the duration of your backups, and then restart it. **Crafty recommends using it ✔️**, because if changes are actively made during the backup, this could lead to data loss or corruption.

#### 4. Run command before/after backups

This option allows you to run commands before and after backups. The main use would be to inform your players that the server is about to go into maintenance for a few minutes, to kick them with a message, etc.

#### 5. Backup Exclusions

This option can be a very useful option, as you'll probably want not to backup some voluminous data, such as all your plugins which you may already have in another backup, your dynmap-rendered tile data, etc.

#### 6. Schedule Backups

**You'll probably want to schedule backups, this can be done with the task scheduler.** It is explained in [the next paragraph](#e).

### E. Task Scheduler <div id='e'/>

As all the above paragraphs, this section is based on this Crafty documentation: [Server Task Scheduler](https://docs.craftycontrol.com/pages/user-guide/task-scheduler/).

The task scheduler allows you to set up complex schedules easily,  specifying intervals in an advanced way, and to chain them.

#### 1. Tasks

Here is the list of possible tasks:
- Start a server
- Restart a server
- Stop a server
- Backup a server
- Run a Minecraft command (do not include the '/')

#### 2. Basic Scheduler

With the "Basic" scheduler, you can specify the interval between executions of your schedule, in days, hours or minutes.

If you select "days" it will ask for a time (hh:mm).

#### 3. Cron Scheduler

With the cron scheduler, specify the interval with a cron string.

Due to the way Crafty scheduling module works, **the last value in the cron string that determines the day is offset by one**. So `0` is `Monday` and not `Sunday`. But note that using day abbreviations still works just fine (MON-SUN).

Take a look at this website if you want to learn cron strings: https://www.geeksforgeeks.org/crontab-in-linux-with-examples/.

> Crafty recommends using https://crontab.guru/ to generate cron strings easily.

#### 4. Reaction (trigger)

This schedule is triggered when the parent schedule completes.

You can add a delay in seconds before its execution.

### F. Metrics <div id='f'/>

This intuitive interface shows the CPU and RAM usage over the selected period, as well as the number of online players.

<img src="https://docs.craftycontrol.com/img/page-assets/user-guide/server-metrics-overview.png" width="600px">

* Hold `Shift` to zoom with your scroll whell.
* Or hold `Shift`, then left-click and drag the area you'd like to zoom in on.