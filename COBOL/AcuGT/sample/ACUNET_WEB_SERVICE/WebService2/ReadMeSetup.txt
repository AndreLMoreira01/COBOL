WebService2 demonstrates the use of an ASP.NET Service with Acucobol.
The project consists of a .NET WEB service, WebService2 a NET control client,
WebClient2 and an ACUCOBOL program WebService2.cbl.
The client, WebClient2, makes method calls using SOAP to the service, WebService2,
passing message strings and retrieving a response from the service.  The client
fires events with event data from the service which are consumed by WebService2.cbl
and displayed in a list box.
    

---------------- Steps to building and deploying the projects. ---------------------

The C# projects are built, the copybook and event handlers are generated.
However, if you have Microsoft Visual Studio Net you may rebuild them by selecting
WebService2.sln.  The WebService2.csproj.webinfo contains the following code.
If you receive project open errors change the web URLPath to where your project is
located.
	<VisualStudioUNCWeb>
    		<Web URLPath = "http://localhost/WebService2/WebService2.csproj" />
	</VisualStudioUNCWeb>
Also, you may rebuild the copyfile and event handlers with NetDefGen.exe
using WebClient2.dll as the input assembly.

WebClient2.dll is loacted in the WebClient2\bin directory.

The copyfile, WebClient2.def, and event handler, WebClient2.WebClient2.dll, 
are located in WebClient2\Events.

WebService2.cbl is located in WebClient2\Cobol.

(1) compile WebService2.cbl - it uses WebClient2.def (see above)

(2) Place the event handlers in the ACUCOBOL directory where the runtime
    is located or update NetEvents.ini with the directory path of the event
    handlers.  NetEvents.ini must be in the same directory where WRUN32.EXE
    is located. 
    An example entry in NetEvents.ini might be E:\WebClient2\Events.
(3) Enter WebClient2.dll in the NET cache or place it in the same directory
    where WRUN32.EXE and AcuToNet.dll reside.

(4) If you have recompiled WebService2.dll copy it to the bin directory under
    the WebService2 folder.    

(5) Register the service with IIS.

    Start Internet Services Manager and select Default Web Site under the 
    server node. Select Action, New, Virtual Directory on the menu and
    click Next to continue.

    Enter WebService2 as the alias and press Next.

    Enter the directory where the service is located.
    Enter the full path up to but excluding the bin directory where the DLL
    in step 4 was copied to. For example: E:\ACUNET_WEB_SERVICE\WebService2
    
    Press Next. Accept the defaults presented and press Next again. Press Finish.
    The service has now been registered and will appear under the list of
    Default Web Sites in the Internet Services Manager window.

    Check that there is a web.config file in the directory where the service
    was registered. This file describes WebService2.dll service and will
    automatically be loaded when the client, WebClient2.dll, attempts an access 
    using the SOAP proxy.  The SOAP proxy was generated from WebService2.asmx
    and included as part of the WebClient2 project.  If you change the WebService2
    project be sure to generate another proxy for the client using WSDL.exe.
    The proxy shipped with this example is Service2.cs. and contains the following

	public Service2()
	{
        	this.Url = "http://localhost/WebService2/WebService2.asmx";
        }

    If you are connecting to other than "lacalhost" change this line and rebuild 
    WebClient2.     
    
    
(7) Execute  WRUN32.EXE WebService2.acu