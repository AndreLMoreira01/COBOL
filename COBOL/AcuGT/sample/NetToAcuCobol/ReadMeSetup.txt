NetToAcuCobol demonstrates a NET Assembly Calling ACUCOBOL.
The ACUCOBOL interface that accomplishes this task has two parts.

The first is Acugt, ACUCOBOL OLE Automation server, which provides a
COM Interface between the ACUCOBOL Runtime and a program running
outside the runtime.  If you are not familiar with the Automation Server
Interface, reference "OLE Automation server" in the Appendicies documentation.

The second is a .NET proxy for the COM interface called
Interop.AcuGTObjects.dll located in sample\NetToAcuCobol\bin.
This provides all interface and data marshalling between .NET and the
Automation server.  Place this file in the directory where WRUN32.exe
is located.

All source and project information to build NetToAcuCobol.exe sample is in
this directory.  If you have Visual Studio NET you may change and rebuild
the project.  The bin directory contains a built exe, NetToAcuCobol.exe.
  
NetToAcuCobol.exe is a .NET GUI that allows you to enter a Acucobol .acu file
path and up to 14 parameters for the called program.  
You may use sample\autosrv\cobol\astest.cbl as the ACUCOBOL program to call.
It takes 4 parameters, short interger, string, signed interger and a double as
input.  You'll notice the sample code does a toString for all parameters
without casting to a specific type and the return output numerics will be the
original value + 1 except for parameter 2, the string. 

