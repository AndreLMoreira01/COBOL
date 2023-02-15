AmortControl demonstrates the use of a .NET Composite User Control with Acucobol.

The NameSpace, AmortControl contains A GUI Class , USerControl1.

AmortControl.cbl uses the GUI class, UserControl1, in an AcuCobol screen containing
WIN32 Textboxes and a WIN32 exit button.  When a user presses the calculate button
in the control, the .NET UserControl1 throws an event which in turn is
captured by AmortControl.cbl. AmortControl.cbl then retrieves financial data,
stored in properties, using the INQUIRE statement.

---------------- Steps to building and deploying the projects. ---------------------

The C# project is built, the copyfile and event handlers are generated.
However, if you have Microsoft Visual Studio Net you may rebuild it by selecting
AmortControl.sln.
Also, you may rebuild the copyfile and event handlers with NetDefGen.exe
using AmortControl.dll as the input assembly.

AmortControl.dll is loacted in the AmortControl\bin directory.

The copyfile, AmortControl.def, and event handler, AmortControl.USerControl1.dll, 
are located in AmortControl\Events.

AmortControl.cbl is located in AmortControl\Cobol.

(1) compile AmortControl.cbl - it uses AmortControl.def (see above)

(2) Place the event handlers in the Acucobol directory where the runtime
    is located or update NetEvents.ini with the directory path of the event
    handlers.  NetEvents.ini must be in the same directory where WRUN32.EXE
    is located. 
    An example entry in NetEvents.ini might be E:\AmortControl\Events.
(3) Enter AmortControl.dll in the NET cache or place it in the same directory
    where WRUN32.EXE and AcuToNet.dll reside.

(4) Execute  WRUN32.EXE AmortControl.acu         