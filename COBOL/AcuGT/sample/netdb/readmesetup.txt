NetDB demonstrates the use of an ACUCOBOL program accesing database fields using
a NET Control.

The NameSpace, NetDBcontains A Class , NetDB_MGR

NetDB.cbl uses the class, NetDB_MGR, to retrieve database fields and populate an
ACUCOBOL Grid Control.  This is a modification to sample control gridctl.cbl.

---------------- Steps to building and deploying the projects. ---------------------

The C# project is built, the copyfile is generated.
However, if you have Microsoft Visual Studio Net you may rebuild it by selecting
NetDB.sln.
Also, you may rebuild the copyfile with NetDefGen.exe
using NetDB.dll as the input assembly.

NetDB.dll is loacted in the NetDB\bin directory.

The copyfile, NetDB.def, is located in NetDB\Cobol.

NetDB.cbl is located in NetDB\Cobol.

(1) compile NetDB.cbl - it uses NetDB.def (see above)
    It expects NetDB.Def to be located in Sample/DEF.
    It gridctl.cpy to be located in the same directory as NetCbl.cbl.
    Feel free to change NetDB.Cbl to suit your needs.
   
    NetDB.CBL has a hard coded path e:\NETDB\NETDB.MDB
    for the location of the ACCESS database.  SEE 77  DB-PATH...

(2) Enter NetDB.dll in the NET cache or place it in the same directory
    where WRUN32.EXE and AcuToNet.dll reside.

(4) Execute  WRUN32.EXE NetDB.acu         