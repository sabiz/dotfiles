@ECHO off
@ECHO;
@ECHO;
@ECHO 88""Yb 88""Yb 888888     88 88b 88 .dP"Y8 888888    db    88     88     888888 88""Yb 
@ECHO 88__dP 88__dP 88__       88 88Yb88 `Ybo."   88     dPYb   88     88     88__   88__dP 
@ECHO 88"""  88"Yb  88""       88 88 Y88 o.`Y8b   88    dP__Yb  88  .o 88  .o 88""   88"Yb  
@ECHO 88     88  Yb 888888     88 88  Y8 8bodP'   88   dP""""Yb 88ood8 88ood8 888888 88  Yb 
@ECHO ---------------------------------------------------------------------------------------- v0.1.0
@ECHO;
@ECHO;

WHERE /Q winget || ECHO Need [winget]... && exit /B 1

winget install Microsoft.PowerShell

winget install Microsoft.WindowsTerminal

@ECHO;
@ECHO;
@ECHO You need sign out.

PAUSE