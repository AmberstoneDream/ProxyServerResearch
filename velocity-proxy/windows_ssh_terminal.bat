set "chars=0123456789ABCDEF"
set "color="
setlocal enabledelayedexpansion

for /l %%i in (1,1,6) do (
  set /a "rand=!random! %% 16"
  for %%j in (!rand!) do set "color=!color!!chars:~%%j,1!"
)

wt -w 0 nt --tabColor=#%color% cmd /k ssh -t crafty@localhost -p 22

REM - A terminal will open in a new colored tab, asking for the password defined in the Dockerfile.



REM - If you can't connect, try deleting [localhost]:22 from C:\Users\<USER>\.ssh\known_hosts
REM - /!\ But make sure you know what you're doing before editing this file.