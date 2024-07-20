# rhubarb-geek-nz/AreYouBeingServed

Demonstration of local server COM object.

[dispsvr.idl](dispsvr/dispsvr.idl) defines the dual-interface for a simple local server.

[dispsvr.c](dispsvr/dispsvr.c) implements the interface.

[dispapp.cpp](dispapp/dispapp.cpp) creates an instance with [CoCreateInstance](https://learn.microsoft.com/en-us/windows/win32/api/combaseapi/nf-combaseapi-cocreateinstance) and uses it to get a message to display.

[dispnet.cs](dispnet/dispnet.cs) demonstrates using [System.Activator.CreateInstance](https://learn.microsoft.com/en-us/dotnet/api/system.activator.createinstance) to create the instance.

[package.ps1](package.ps1) is used to automate the building of multiple architectures.

[dispps1.ps1](dispps1/dispps1.ps1) PowerShell creating and invoking Hello World
