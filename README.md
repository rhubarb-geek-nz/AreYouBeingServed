# rhubarb-geek-nz/AreYouBeingServed

Demonstration of local server COM object.

```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\RhubarbGeekNz.AreYouBeingServed\CLSID]
@="{CDC09DA3-850A-45A3-B5A3-729A2D11E73D}"

[HKEY_CLASSES_ROOT\CLSID\{CDC09DA3-850A-45A3-B5A3-729A2D11E73D}\LocalServer32]
@="C:\\PROGRA~1\\RHUBAR~1\\AREYOU~1\\x64\\RHUBAR~1.EXE"
```

[dispsvr.idl](dispsvr/dispsvr.idl) defines the dual-interface for a simple local server.

[dispsvr.c](dispsvr/dispsvr.c) implements the interface.

[dispapp.cpp](dispapp/dispapp.cpp) creates an instance with [CoCreateInstance](https://learn.microsoft.com/en-us/windows/win32/api/combaseapi/nf-combaseapi-cocreateinstance) and uses it to get a message to display.

[dispnet.cs](dispnet/dispnet.cs) demonstrates using import library.

[package.ps1](package.ps1) is used to automate the building of multiple architectures.

[dispps1.ps1](dispps1/dispps1.ps1) PowerShell creating and invoking Hello World
