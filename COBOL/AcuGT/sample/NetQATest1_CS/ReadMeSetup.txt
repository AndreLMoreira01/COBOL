NetQATest1_CS demonstrates the use of a .NET User Control with Acucobol.

The NameSpace, NetQATest1_CS, contains three classes.

The first two, CAnimals and CCars, in CLass1.cs are non gui classes and can
be instantiated separately using ACUCOBOL CREATE statements.  This test is
a GUI test only and does not do this.

The third class, UserControl1, in UserControl1.cs instantiates CAnimals and
CCars, Collects events thrown by each and in turn throws an event containing
a data string of either an animal or car selection.

NetQaTest.cbl uses the GUI class, UserControl1, in an AcuCobol screen containing
a WIN32 Textbox and WIN32 exit button.  When a user selects an animal or car from
their respective list boxes, the .NET UserControl1 throws an event which in turn is
captured by NetQaTest.cbl.  NetQaTest.cbl then retrieves the event data and displays
it in a textbox.

---------------- Steps to building and deploying the projects. ---------------------

The C# project is built, the copyfile and event handlers are generated.
However if you have Microsoft Visual Studio Net you may rebuild it by selecting
NetQATest1_CS.sln.
Also, you may rebuild the copyfile and event handlers with NetDefGen.exe
using NetQATest1_CS.dll as the input assembly.

NetQATest1_CS.dll is loacted in the NetQATest1_CS\bin directory.

The copyfile, NetQATest1.def, and event handlers, NetQATest1_CS.CAnimals.dll,
NetQATest1_CS.CCars.dll, NetQATest1_CS.UserControl1.dll,  
are located in NetQATest1_CS\Events.

NetQaTest.cbl is located in NetQATest1_CS\Cobol.

(1) compile NetQaTest.cbl - it uses NetQATest1.def (see above)

(2) Place the event handlers in the Acucobol directory where the runtime
    is located or update NetEvents.ini with the directory path of the event
    handlers.  NetEvents.ini must be in the same directory where WRUN32.EXE
    is located. 
    An example entry in NetEvents.ini might be E:\NetQATest1_CS\Events.
(3) Enter NetQATest1_CS.dll in the NET cache or place it in the same directory
    where WRUN32.EXE and AcuToNet.dll reside.

(4) Execute  WRUN32.EXE NetQATest.acu         