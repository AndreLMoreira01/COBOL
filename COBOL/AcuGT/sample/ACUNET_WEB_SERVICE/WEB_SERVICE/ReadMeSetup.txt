WEB_SERVICE demonstrates the use of a .NET Remoting Service with Acucobol.
The project consists of a .NET WEB service, WEB_SERVICE, a NET control client,
WEB_CLIENT and an ACUCOBOL program WebService.cbl.
The client, WEB_CLIENT, makes remote method calls to the service, WEB_SERVICE,
passing message strings and retrieving a response from the service.  The client
fires events with event data from the service which are consumed by WebService.cbl
and displayed in a list box.
    

---------------- Steps to building and deploying the projects. ---------------------

The C# projects are built, the copyfile and event handlers are generated.
However, if you have Microsoft Visual Studio Net you may rebuild them by selecting
WEB_CLIENT.sln.
Also, you may rebuild the copyfile and event handlers with NetDefGen.exe
using WEB_CLIENT.dll as the input assembly.

WEB_CLIENT.dll is loacted in the WEB_CLIENT\bin directory.

The copyfile, WebClient.def, and event handler, WebClient.dll, 
are located in WEB_CLIENT\Events.

WebService.cbl is located in WEB_CLIENT\Cobol.

(1) compile WebService.cbl - it uses WebClient.def (see above)

(2) Place the event handlers in the ACUCOBOL directory where the runtime
    is located or update NetEvents.ini with the directory path of the event
    handlers.  NetEvents.ini must be in the same directory where WRUN32.EXE
    is located. 
    An example entry in NetEvents.ini might be E:\WEB_CLIENT\Events.

(3) Enter WEB_CLIENT.dll in the NET cache or place it in the same directory
    where WRUN32.EXE and AcuToNet.dll reside.
    You must also place WEB_SERVICE.dll in the same directory where WEB_CLIENT.dll
    is located.  When WEB_CLIENT.dll is loaded it resolves all references to
    WEB_SERVICE using this copy of WEB_SERVICE.dll but it does not actually
    execute any methods in it.  Intead all references are marshalled to the
    WEB_SERVICE.DLL residing at the location of the IIS web server.

(4) If you have recompiled WEB_SERVICE.dll copy it to the bin directory under
    the WEB_SERVICE folder.    

(5) Register the service with IIS.

    Start Internet Services Manager and select Default Web Site under the 
    server node. Select Action, New, Virtual Directory on the menu and
    click Next to continue.

    Enter WEB_SERVICE as the alias and press Next.

    Enter the directory where the service is located.
    Enter the full path up to but excluding the bin directory where the DLL
    in step 4 was copied to. For example: E:\ACUNET_WEB_SERVICE\WEB_SERVICE
    
    Press Next. Accept the defaults presented and press Next again. Press Finish.
    The service has now been registered and will appear under the list of
    Default Web Sites in the Internet Services Manager window.

    Check that there is a web.config file in the directory where the service
    was registered. This file describes WEB_SERVICE.dll service and will
    automatically be loaded when the client, WEB_CLIENT.dll, attempts an access 
    using the HTTP channel on port 80.
    
(6) Check WebClient.config, which contains configuration information in XML format,
    for the client's connection with the service.  It is shipped with a connection
    to "localhost", <client url="HTTP://localhost/WEB_SERVICE">.
    Change this to correspond to where WEB_SERVICE.dll is located and then
    place WebClient.config in the same directory where WEB_CLIENT.dll is located.
    see step 3 above.  
    
(7) Execute  WRUN32.EXE WebService.acu