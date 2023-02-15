.assembly extern wrunnet
{
  .ver 1:0:0:0
}
.assembly extern mscorlib
{
  .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
}
.assembly extern System
{
  .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
}
.module AcuFramework.netmodule

.namespace AcuFramework
{
  .class public auto ansi beforefieldinit AcuFramework
         extends [wrunnet]acucobol.CVM
  {
  } // end of class AcuFramework

} // end of namespace AcuFramework


// =============================================================


// =============== GLOBAL FIELDS AND METHODS ===================


// =============================================================


// =============== CLASS MEMBERS DECLARATION ===================
//   note that class flags, 'extends' and 'implements' clauses
//          are provided here for information only

.namespace AcuFramework
{
  .class public auto ansi beforefieldinit AcuFramework
         extends [wrunnet]acucobol.CVM
  {
    .field private class [mscorlib]System.IO.Stream acuObject
    .field private unsigned int8[] buf
    .field private class [System]System.CodeDom.Compiler.TempFileCollection tmpFile
    .field private string acuFileName
    .field private class [mscorlib]System.IO.FileStream fs
    .field private class [mscorlib]System.IO.BinaryWriter writeObj
    .field private int32 lastRead
    .method public hidebysig specialname rtspecialname 
            instance void  .ctor() cil managed
    {
      // Code size       210 (0xd2)
      .maxstack  4
      .locals init ([0] class [mscorlib]System.Exception e,
               [1] class [mscorlib]System.Exception innerE)
      IL_0000:  ldarg.0
      IL_0001:  call       instance void [wrunnet]acucobol.CVM::.ctor()
      IL_0006:  ldarg.0
      IL_0007:  ldstr      ""
      IL_000c:  stfld      string [wrunnet]acucobol.CVM::error_msg
      .try
      {
        IL_0011:  ldarg.0
        IL_0012:  ldc.i4     0x2000
        IL_0017:  newarr     [mscorlib]System.Byte
        IL_001c:  stfld      unsigned int8[] AcuFramework.AcuFramework::buf
        IL_0021:  ldarg.0
        IL_0022:  newobj     instance void [System]System.CodeDom.Compiler.TempFileCollection::.ctor()
        IL_0027:  stfld      class [System]System.CodeDom.Compiler.TempFileCollection AcuFramework.AcuFramework::tmpFile
        IL_002c:  ldarg.0
        IL_002d:  ldarg.0
        IL_002e:  ldfld      class [System]System.CodeDom.Compiler.TempFileCollection AcuFramework.AcuFramework::tmpFile
        IL_0033:  ldstr      "acu"
        IL_0038:  ldc.i4.1
        IL_0039:  callvirt   instance string [System]System.CodeDom.Compiler.TempFileCollection::AddExtension(string,
                                                                                                              bool)
        IL_003e:  stfld      string AcuFramework.AcuFramework::acuFileName
        IL_0043:  ldarg.0
        IL_0044:  ldarg.0
        IL_0045:  ldfld      string AcuFramework.AcuFramework::acuFileName
        IL_004a:  ldc.i4.1
        IL_004b:  newobj     instance void [mscorlib]System.IO.FileStream::.ctor(string,
                                                                                 valuetype [mscorlib]System.IO.FileMode)
        IL_0050:  stfld      class [mscorlib]System.IO.FileStream AcuFramework.AcuFramework::fs
        IL_0055:  ldarg.0
        IL_0056:  ldarg.0
        IL_0057:  ldfld      class [mscorlib]System.IO.FileStream AcuFramework.AcuFramework::fs
        IL_005c:  newobj     instance void [mscorlib]System.IO.BinaryWriter::.ctor(class [mscorlib]System.IO.Stream)
        IL_0061:  stfld      class [mscorlib]System.IO.BinaryWriter AcuFramework.AcuFramework::writeObj
        IL_0066:  leave.s    IL_00b8

      }  // end .try
      catch [mscorlib]System.Exception 
      {
        IL_0068:  stloc.0
        IL_0069:  ldloc.0
        IL_006a:  callvirt   instance class [mscorlib]System.Exception [mscorlib]System.Exception::get_InnerException()
        IL_006f:  stloc.1
        IL_0070:  ldloc.1
        IL_0071:  brfalse.s  IL_008f

        IL_0073:  ldloc.1
        IL_0074:  callvirt   instance string [mscorlib]System.Exception::get_Message()
        IL_0079:  callvirt   instance int32 [mscorlib]System.String::get_Length()
        IL_007e:  ldc.i4.0
        IL_007f:  ble.s      IL_008f

        IL_0081:  ldarg.0
        IL_0082:  ldloc.1
        IL_0083:  callvirt   instance string [mscorlib]System.Exception::get_Message()
        IL_0088:  stfld      string [wrunnet]acucobol.CVM::error_msg
        IL_008d:  br.s       IL_00b6

        IL_008f:  ldloc.0
        IL_0090:  callvirt   instance string [mscorlib]System.Exception::get_Message()
        IL_0095:  callvirt   instance int32 [mscorlib]System.String::get_Length()
        IL_009a:  ldc.i4.0
        IL_009b:  ble.s      IL_00ab

        IL_009d:  ldarg.0
        IL_009e:  ldloc.0
        IL_009f:  callvirt   instance string [mscorlib]System.Exception::get_Message()
        IL_00a4:  stfld      string [wrunnet]acucobol.CVM::error_msg
        IL_00a9:  br.s       IL_00b6

        IL_00ab:  ldarg.0
        IL_00ac:  ldstr      "AcuNet Temp Object Create Error"
        IL_00b1:  stfld      string [wrunnet]acucobol.CVM::error_msg
        IL_00b6:  leave.s    IL_00d1

      }  // end handler
      IL_00b8:  ldarg.0
      IL_00b9:  ldarg.0
      IL_00ba:  ldfld      string AcuFramework.AcuFramework::acuFileName
      IL_00bf:  call       instance void [wrunnet]acucobol.CVM::set_ObjLib(string)
      IL_00c4:  ldarg.0
      IL_00c5:  ldc.i4.1
      IL_00c6:  stfld      int32 AcuFramework.AcuFramework::lastRead
      IL_00cb:  ldarg.0
      IL_00cc:  call       instance void AcuFramework.AcuFramework::loadWrunnet()
      IL_00d1:  ret
    } // end of method AcuFramework::.ctor

    .method family hidebysig virtual instance void 
            Finalize() cil managed
    {
      // Code size       21 (0x15)
      .maxstack  1
      .try
      {
        IL_0000:  ldarg.0
        IL_0001:  ldfld      string AcuFramework.AcuFramework::acuFileName
        IL_0006:  call       void [mscorlib]System.IO.File::Delete(string)
        IL_000b:  leave.s    IL_0014

      }  // end .try
      finally
      {
        IL_000d:  ldarg.0
        IL_000e:  call       instance void [wrunnet]acucobol.CVM::Finalize()
        IL_0013:  endfinally
      }  // end handler
      IL_0014:  ret
    } // end of method AcuFramework::Finalize

    .method private hidebysig instance void 
            loadWrunnet() cil managed
    {
      // Code size       209 (0xd1)
      .maxstack  5
      .locals init ([0] class [mscorlib]System.Reflection.Assembly thisExe,
               [1] class [mscorlib]System.Exception e,
               [2] class [mscorlib]System.Exception innerE)
      IL_0000:  call       class [mscorlib]System.Reflection.Assembly [mscorlib]System.Reflection.Assembly::GetExecutingAssembly()
      IL_0005:  stloc.0
      IL_0006:  ldarg.0
      IL_0007:  ldloc.0
      IL_0008:  ldstr      "AcuNet"
      IL_000d:  callvirt   instance class [mscorlib]System.IO.Stream [mscorlib]System.Reflection.Assembly::GetManifestResourceStream(string)
      IL_0012:  stfld      class [mscorlib]System.IO.Stream AcuFramework.AcuFramework::acuObject
      IL_0017:  br         IL_00ac

      .try
      {
        IL_001c:  ldarg.0
        IL_001d:  ldarg.0
        IL_001e:  ldfld      class [mscorlib]System.IO.Stream AcuFramework.AcuFramework::acuObject
        IL_0023:  ldarg.0
        IL_0024:  ldfld      unsigned int8[] AcuFramework.AcuFramework::buf
        IL_0029:  ldc.i4.0
        IL_002a:  ldc.i4     0x2000
        IL_002f:  callvirt   instance int32 [mscorlib]System.IO.Stream::Read(unsigned int8[],
                                                                             int32,
                                                                             int32)
        IL_0034:  stfld      int32 AcuFramework.AcuFramework::lastRead
        IL_0039:  ldarg.0
        IL_003a:  ldfld      int32 AcuFramework.AcuFramework::lastRead
        IL_003f:  ldc.i4.0
        IL_0040:  ble.s      IL_005a

        IL_0042:  ldarg.0
        IL_0043:  ldfld      class [mscorlib]System.IO.BinaryWriter AcuFramework.AcuFramework::writeObj
        IL_0048:  ldarg.0
        IL_0049:  ldfld      unsigned int8[] AcuFramework.AcuFramework::buf
        IL_004e:  ldc.i4.0
        IL_004f:  ldarg.0
        IL_0050:  ldfld      int32 AcuFramework.AcuFramework::lastRead
        IL_0055:  callvirt   instance void [mscorlib]System.IO.BinaryWriter::Write(unsigned int8[],
                                                                                   int32,
                                                                                   int32)
        IL_005a:  leave.s    IL_00ac

      }  // end .try
      catch [mscorlib]System.Exception 
      {
        IL_005c:  stloc.1
        IL_005d:  ldloc.1
        IL_005e:  callvirt   instance class [mscorlib]System.Exception [mscorlib]System.Exception::get_InnerException()
        IL_0063:  stloc.2
        IL_0064:  ldloc.2
        IL_0065:  brfalse.s  IL_0083

        IL_0067:  ldloc.2
        IL_0068:  callvirt   instance string [mscorlib]System.Exception::get_Message()
        IL_006d:  callvirt   instance int32 [mscorlib]System.String::get_Length()
        IL_0072:  ldc.i4.0
        IL_0073:  ble.s      IL_0083

        IL_0075:  ldarg.0
        IL_0076:  ldloc.2
        IL_0077:  callvirt   instance string [mscorlib]System.Exception::get_Message()
        IL_007c:  stfld      string [wrunnet]acucobol.CVM::error_msg
        IL_0081:  br.s       IL_00aa

        IL_0083:  ldloc.1
        IL_0084:  callvirt   instance string [mscorlib]System.Exception::get_Message()
        IL_0089:  callvirt   instance int32 [mscorlib]System.String::get_Length()
        IL_008e:  ldc.i4.0
        IL_008f:  ble.s      IL_009f

        IL_0091:  ldarg.0
        IL_0092:  ldloc.1
        IL_0093:  callvirt   instance string [mscorlib]System.Exception::get_Message()
        IL_0098:  stfld      string [wrunnet]acucobol.CVM::error_msg
        IL_009d:  br.s       IL_00aa

        IL_009f:  ldarg.0
        IL_00a0:  ldstr      "AcuNet Resource Read Error"
        IL_00a5:  stfld      string [wrunnet]acucobol.CVM::error_msg
        IL_00aa:  leave.s    IL_00d0

      }  // end handler
      IL_00ac:  ldarg.0
      IL_00ad:  ldfld      int32 AcuFramework.AcuFramework::lastRead
      IL_00b2:  ldc.i4.0
      IL_00b3:  bgt        IL_001c

      IL_00b8:  ldarg.0
      IL_00b9:  ldfld      class [mscorlib]System.IO.BinaryWriter AcuFramework.AcuFramework::writeObj
      IL_00be:  callvirt   instance void [mscorlib]System.IO.BinaryWriter::Close()
      IL_00c3:  ldarg.0
      IL_00c4:  ldfld      class [mscorlib]System.IO.FileStream AcuFramework.AcuFramework::fs
      IL_00c9:  callvirt   instance void [mscorlib]System.IO.Stream::Close()
      IL_00ce:  br.s       IL_00d0

      IL_00d0:  ret
    } // end of method AcuFramework::loadWrunnet
  } // end of class AcuFramework                                                                                                                               bool) = ( 01 00 01 01 00 00 ) 
} // end of namespace AcuFramework
