# Crafty user guide

This document summarizes this guide: https://docs.craftycontrol.com/pages/user-guide/user-role-config/.

> I assume you already have installed Crafty Control, and it is running on https://localhost:8443.

## I. User/Role configuration

Open the `Panel Config`, here you can manage users and roles if you have the permission.

<img src="https://docs.craftycontrol.com/img/page-assets/user-guide/settings-pointer.png" height="80px">

> It is very easy to use, but if you need a more detailed explanation, please refer to the full documentation: https://docs.craftycontrol.com/pages/user-guide/user-role-config/

### A. Advices for creating users

- **Do NOT create any Super User, because they have access on EVERYTHING.**
- Set a secure password, you can use website like https://passwordsgenerator.net/ to automate this.
- Define a manager for the user, to maintain a hierarchy.
- Be careful on permissions you are giving to users:
    - `SERVER_CREATION` allows the user to create servers.
    - `USER_CONFIG` allows the user to create a user account.
    - `ROLES_CONFIG` allows the user to create a role.

### B. Advices for creating roles

- Define a manager for the role, to maintain a hierarchy.
- Carefully select the role permissions:
    - `COMMANDS` allows role to start/stop/restart server.
    - `TERMINAL` allows role to access the terminal.
    - `LOGS` allows role to access server logs.
    - `SCHEDULE` allows role to be able to create/delete/edit and access schedules.
    - `BACKUP` allows role to be able to create/delete/download/restore and access backups.
    - `FILES` allows role to access files. This includes uploading/downloading/deleting/unzipping/renaming/creating/etc.
    - `CONFIG` allows role to access server config. As a basic user this only gives them access to minimal configurations.
    - `PLAYERS` allows role to access player config. This allows them to OP, Kick, Ban, etc.