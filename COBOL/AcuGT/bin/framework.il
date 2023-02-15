.module extern wrun32.dll
.module extern Kernel32.dll
.assembly extern mscorlib
{
  .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
}
.assembly extern System
{
  .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
}
.assembly extern System.Windows.Forms
{
  .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
}
.assembly wrunnet
{
  .ver 1:0:0:0
}
.module wrunnet.dll
.namespace acucobol
{
  .class public auto ansi sealed defines
         extends [mscorlib]System.Enum
  {
  } // end of class defines

  .class public auto ansi sealed compilerTypes
         extends [mscorlib]System.Enum
  {
  } // end of class compilerTypes

  .class public auto ansi sealed cobolTypes
         extends [mscorlib]System.Enum
  {
  } // end of class cobolTypes

  .class public auto ansi sealed cobol_exit
         extends [mscorlib]System.Enum
  {
  } // end of class cobol_exit

  .class public auto ansi sealed errorTypes
         extends [mscorlib]System.Enum
  {
  } // end of class errorTypes

  .class public auto ansi sealed CobolCallErrors
         extends [mscorlib]System.Enum
  {
  } // end of class CobolCallErrors

  .class public auto ansi sealed DEBUG_METHODS
         extends [mscorlib]System.Enum
  {
  } // end of class DEBUG_METHODS

  .class public sequential ansi sealed beforefieldinit AcuInitArgs
         extends [mscorlib]System.ValueType
  {
  } // end of class AcuInitArgs

  .class public sequential ansi sealed beforefieldinit ARGUMENT_ENTRY
         extends [mscorlib]System.ValueType
  {
  } // end of class ARGUMENT_ENTRY

  .class public sequential ansi sealed beforefieldinit a_cobol_info
         extends [mscorlib]System.ValueType
  {
  } // end of class a_cobol_info

  .class public auto ansi beforefieldinit CVM
         extends [mscorlib]System.Object
         implements [mscorlib]System.IDisposable
  {
  } // end of class CVM

} // end of namespace acucobol


// =============================================================


// =============== GLOBAL FIELDS AND METHODS ===================


// =============================================================


// =============== CLASS MEMBERS DECLARATION ===================
//   note that class flags, 'extends' and 'implements' clauses
//          are provided here for information only

.namespace acucobol
{
  .class public auto ansi sealed defines
         extends [mscorlib]System.Enum
  {
    .field public specialname rtspecialname int32 value__
    .field public static literal valuetype acucobol.defines CALL_ERROR_BASE = int32(0x00000028)
    .field public static literal valuetype acucobol.defines MAX_OBJ_LIBS = int32(0x00000020)
  } // end of class defines

  .class public auto ansi sealed compilerTypes
         extends [mscorlib]System.Enum
  {
    .field public specialname rtspecialname unsigned int8 value__
    .field public static literal valuetype acucobol.compilerTypes NSE = int8(0x00)
    .field public static literal valuetype acucobol.compilerTypes NSEZ = int8(0x01)
    .field public static literal valuetype acucobol.compilerTypes CONS = int8(0x02)
    .field public static literal valuetype acucobol.compilerTypes ANL = int8(0x03)
    .field public static literal valuetype acucobol.compilerTypes ABS = int8(0x04)
    .field public static literal valuetype acucobol.compilerTypes ABSJ = int8(0x05)
    .field public static literal valuetype acucobol.compilerTypes PARAM = int8(0x06)
    .field public static literal valuetype acucobol.compilerTypes GRPL = int8(0x07)
    .field public static literal valuetype acucobol.compilerTypes ANSE = int8(0x08)
    .field public static literal valuetype acucobol.compilerTypes GRPVL = int8(0x09)
    .field public static literal valuetype acucobol.compilerTypes ANS = int8(0x0A)
    .field public static literal valuetype acucobol.compilerTypes ANSJ = int8(0x0B)
    .field public static literal valuetype acucobol.compilerTypes GRP = int8(0x0C)
    .field public static literal valuetype acucobol.compilerTypes GRPV = int8(0x0D)
    .field public static literal valuetype acucobol.compilerTypes NPU = int8(0x0E)
    .field public static literal valuetype acucobol.compilerTypes NNCU = int8(0x0F)
    .field public static literal valuetype acucobol.compilerTypes NSU = int8(0x10)
    .field public static literal valuetype acucobol.compilerTypes NNU = int8(0x11)
    .field public static literal valuetype acucobol.compilerTypes NSS = int8(0x12)
    .field public static literal valuetype acucobol.compilerTypes NSSL = int8(0x13)
    .field public static literal valuetype acucobol.compilerTypes NCU = int8(0x14)
    .field public static literal valuetype acucobol.compilerTypes NBU = int8(0x15)
    .field public static literal valuetype acucobol.compilerTypes NCS = int8(0x16)
    .field public static literal valuetype acucobol.compilerTypes NNCS = int8(0x17)
    .field public static literal valuetype acucobol.compilerTypes NIS = int8(0x18)
    .field public static literal valuetype acucobol.compilerTypes NISL = int8(0x19)
    .field public static literal valuetype acucobol.compilerTypes NPS = int8(0x1A)
    .field public static literal valuetype acucobol.compilerTypes NFP = int8(0x1B)
    .field public static literal valuetype acucobol.compilerTypes TEMP = int8(0x1C)
    .field public static literal valuetype acucobol.compilerTypes NPP = int8(0x1D)
    .field public static literal valuetype acucobol.compilerTypes NBS = int8(0x1E)
    .field public static literal valuetype acucobol.compilerTypes NNS = int8(0x1F)
    .field public static literal valuetype acucobol.compilerTypes NAT = int8(0x20)
    .field public static literal valuetype acucobol.compilerTypes NATJ = int8(0x21)
    .field public static literal valuetype acucobol.compilerTypes NATE = int8(0x22)
    .field public static literal valuetype acucobol.compilerTypes WID = int8(0x23)
    .field public static literal valuetype acucobol.compilerTypes WIDJ = int8(0x24)
    .field public static literal valuetype acucobol.compilerTypes EWID = int8(0x25)
    .field public static literal valuetype acucobol.compilerTypes TMP_PFX = int8(0x26)
    .field public static literal valuetype acucobol.compilerTypes NEFP = int8(0x27)
    .field public static literal valuetype acucobol.compilerTypes NBFP = int8(0x28)
  } // end of class compilerTypes

  .class public auto ansi sealed cobolTypes
         extends [mscorlib]System.Enum
  {
    .field public specialname rtspecialname int16 value__
    .field public static literal valuetype acucobol.cobolTypes NumEdited = int16(0x0000)
    .field public static literal valuetype acucobol.cobolTypes NumUnsigned = int16(0x0001)
    .field public static literal valuetype acucobol.cobolTypes NumSignSep = int16(0x0002)
    .field public static literal valuetype acucobol.cobolTypes NumSigned = int16(0x0003)
    .field public static literal valuetype acucobol.cobolTypes NumSepLead = int16(0x0004)
    .field public static literal valuetype acucobol.cobolTypes NumLeading = int16(0x0005)
    .field public static literal valuetype acucobol.cobolTypes CompSigned = int16(0x0006)
    .field public static literal valuetype acucobol.cobolTypes CompUnsigned = int16(0x0007)
    .field public static literal valuetype acucobol.cobolTypes PackedPositive = int16(0x0008)
    .field public static literal valuetype acucobol.cobolTypes PackedSigned = int16(0x0009)
    .field public static literal valuetype acucobol.cobolTypes PackedUnsigned = int16(0x000A)
    .field public static literal valuetype acucobol.cobolTypes BinarySigned = int16(0x000B)
    .field public static literal valuetype acucobol.cobolTypes BinaryUnsigned = int16(0x000C)
    .field public static literal valuetype acucobol.cobolTypes NativeSigned = int16(0x000D)
    .field public static literal valuetype acucobol.cobolTypes NativeUnsigned = int16(0x000E)
    .field public static literal valuetype acucobol.cobolTypes Alphanum = int16(0x0010)
    .field public static literal valuetype acucobol.cobolTypes JustAN = int16(0x0011)
    .field public static literal valuetype acucobol.cobolTypes Alphabetic = int16(0x0012)
    .field public static literal valuetype acucobol.cobolTypes JustAlpha = int16(0x0013)
    .field public static literal valuetype acucobol.cobolTypes AlphaEdited = int16(0x0014)
    .field public static literal valuetype acucobol.cobolTypes Group = int16(0x0016)
    .field public static literal valuetype acucobol.cobolTypes Float = int16(0x0017)
    .field public static literal valuetype acucobol.cobolTypes National = int16(0x0018)
    .field public static literal valuetype acucobol.cobolTypes JustNat = int16(0x0019)
    .field public static literal valuetype acucobol.cobolTypes NatEdited = int16(0x001A)
    .field public static literal valuetype acucobol.cobolTypes Wide = int16(0x001B)
    .field public static literal valuetype acucobol.cobolTypes JustWide = int16(0x001C)
    .field public static literal valuetype acucobol.cobolTypes WideEdited = int16(0x001D)
    .field public static literal valuetype acucobol.cobolTypes NativeVSigned = int16(0x001E)
    .field public static literal valuetype acucobol.cobolTypes NativeVUnsigned = int16(0x001F)
    .field public static literal valuetype acucobol.cobolTypes ExternalFloat = int16(0x0020)
    .field public static literal valuetype acucobol.cobolTypes BigFloat = int16(0x0021)
  } // end of class cobolTypes

  .class public auto ansi sealed cobol_exit
         extends [mscorlib]System.Enum
  {
    .field public specialname rtspecialname int32 value__
    .field public static literal valuetype acucobol.cobol_exit COBOL_EXIT_PROGRAM = int32(0x00000001)
    .field public static literal valuetype acucobol.cobol_exit COBOL_REMOTE_CALL = int32(0x00000002)
    .field public static literal valuetype acucobol.cobol_exit COBOL_STOP_RUN = int32(0x00000003)
    .field public static literal valuetype acucobol.cobol_exit COBOL_CALL_ERROR = int32(0x00000004)
    .field public static literal valuetype acucobol.cobol_exit COBOL_SIGNAL = int32(0x00000005)
    .field public static literal valuetype acucobol.cobol_exit COBOL_FATAL_ERROR = int32(0x00000006)
    .field public static literal valuetype acucobol.cobol_exit COBOL_NONFATAL_ERROR = int32(0x00000007)
    .field public static literal valuetype acucobol.cobol_exit COBOL_DEBUGGER = int32(0x00000008)
  } // end of class cobol_exit

  .class public auto ansi sealed errorTypes
         extends [mscorlib]System.Enum
  {
    .field public specialname rtspecialname int32 value__
    .field public static literal valuetype acucobol.errorTypes CS_MULTIPLE_OS_THREADS = int32(0xFFFFFFFC)
    .field public static literal valuetype acucobol.errorTypes CS_WIN_INIT_FAILED = int32(0xFFFFFFFD)
    .field public static literal valuetype acucobol.errorTypes CS_STOP_RUN = int32(0xFFFFFFFE)
    .field public static literal valuetype acucobol.errorTypes CS_CONT = int32(0xFFFFFFFF)
    .field public static literal valuetype acucobol.errorTypes CS_OK = int32(0x00000000)
    .field public static literal valuetype acucobol.errorTypes CS_MISSING = int32(0x00000001)
    .field public static literal valuetype acucobol.errorTypes CS_NOT_COBOL = int32(0x00000002)
    .field public static literal valuetype acucobol.errorTypes CS_INTERNAL = int32(0x00000003)
    .field public static literal valuetype acucobol.errorTypes CS_MEMORY = int32(0x00000004)
    .field public static literal valuetype acucobol.errorTypes CS_VERSION = int32(0x00000005)
    .field public static literal valuetype acucobol.errorTypes CS_RECURSIVE = int32(0x00000006)
    .field public static literal valuetype acucobol.errorTypes CS_EXTERNAL = int32(0x00000007)
    .field public static literal valuetype acucobol.errorTypes CS_LARGE_MODEL = int32(0x00000008)
    .field public static literal valuetype acucobol.errorTypes CS_JAPANESE = int32(0x0000000E)
    .field public static literal valuetype acucobol.errorTypes CS_MULTITHREADED = int32(0x00000016)
    .field public static literal valuetype acucobol.errorTypes CS_AUTHORIZATION = int32(0x00000017)
    .field public static literal valuetype acucobol.errorTypes CS_CONNECT_REFUSED = int32(0x00000019)
    .field public static literal valuetype acucobol.errorTypes CS_MISMATCHED_CPU = int32(0x0000001B)
    .field public static literal valuetype acucobol.errorTypes CS_SERIAL_NUMBER = int32(0x0000001C)
    .field public static literal valuetype acucobol.errorTypes CS_USER_COUNT_EXCEEDED = int32(0x0000001D)
    .field public static literal valuetype acucobol.errorTypes CS_LICENSE = int32(0x0000001E)
    .field public static literal valuetype acucobol.errorTypes CS_UNSUPPORTED_PARAM = int32(0x0000001F)
    .field public static literal valuetype acucobol.errorTypes CS_INVALID_HANDLE = int32(0x00000020)
    .field public static literal valuetype acucobol.errorTypes CS_COBOL_SIGNAL = int32(0x00000041)
    .field public static literal valuetype acucobol.errorTypes CS_COBOL_FATAL_ERROR = int32(0x00000042)
  } // end of class errorTypes

  .class public auto ansi sealed CobolCallErrors
         extends [mscorlib]System.Enum
  {
    .field public specialname rtspecialname int32 value__
    .field public static literal valuetype acucobol.CobolCallErrors COBOL_EXIT_PROGRAM = int32(0x00000001)
    .field public static literal valuetype acucobol.CobolCallErrors COBOL_REMOTE_CALL = int32(0x00000002)
    .field public static literal valuetype acucobol.CobolCallErrors COBOL_STOP_RUN = int32(0x00000003)
    .field public static literal valuetype acucobol.CobolCallErrors COBOL_CALL_ERROR = int32(0x00000004)
    .field public static literal valuetype acucobol.CobolCallErrors COBOL_SIGNAL = int32(0x00000005)
    .field public static literal valuetype acucobol.CobolCallErrors COBOL_FATAL_ERROR = int32(0x00000006)
    .field public static literal valuetype acucobol.CobolCallErrors COBOL_NONFATAL_ERROR = int32(0x00000007)
    .field public static literal valuetype acucobol.CobolCallErrors COBOL_DEBUGGER = int32(0x00000008)
  } // end of class CobolCallErrors

  .class public auto ansi sealed DEBUG_METHODS
         extends [mscorlib]System.Enum
  {
    .field public specialname rtspecialname int32 value__
    .field public static literal valuetype acucobol.DEBUG_METHODS ADM_NONE = int32(0x00000000)
    .field public static literal valuetype acucobol.DEBUG_METHODS ADM_XTERM = int32(0x00000001)
    .field public static literal valuetype acucobol.DEBUG_METHODS ADM_TERMINAL = int32(0x00000002)
    .field public static literal valuetype acucobol.DEBUG_METHODS ADM_THINCLIENT = int32(0x00000003)
    .field public static literal valuetype acucobol.DEBUG_METHODS ADM_ACUBENCH = int32(0x00000004)
  } // end of class DEBUG_METHODS

  .class public sequential ansi sealed beforefieldinit AcuInitArgs
         extends [mscorlib]System.ValueType
  {
    .field public void* pAcuInitArg1
    .field public void* pAcuInitArg2
  } // end of class AcuInitArgs

  .class public sequential ansi sealed beforefieldinit ARGUMENT_ENTRY
         extends [mscorlib]System.ValueType
  {
    .field public void* a_address
    .field public int32 a_length
    .field public valuetype acucobol.cobolTypes a_type
    .field public unsigned int8 a_digits
    .field public unsigned int8 a_scale
    .field public void* p_a_picture
  } // end of class ARGUMENT_ENTRY

  .class public sequential ansi sealed beforefieldinit a_cobol_info
         extends [mscorlib]System.ValueType
  {
    .field public unsigned int32 a_cobol_info_size
    .field public void* pgm_name
    .field public int32 num_params
    .field public valuetype acucobol.ARGUMENT_ENTRY* p_params
    .field public int32 exit_code
    .field public unsigned int8* p_exit_msg
    .field public int32 signal_number
    .field public valuetype acucobol.errorTypes call_error
    .field public int32 cobol_return_code
    .field public unsigned int32 no_stop_cache
    .field public valuetype acucobol.DEBUG_METHODS debug_methods
    .field public void* debugger
  } // end of class a_cobol_info

  .class public auto ansi beforefieldinit CVM
         extends [mscorlib]System.Object
         implements [mscorlib]System.IDisposable
  {
    .field private int32 Objidx
    .field private bool disposed
    .field private string oldRuntimePath
    .field private bool Initialized
    .field public string error_msg
    .field private string RuntimePath
    .field private string propSwitches
    .field private string propConfigFile
    .field private string propErrorsOut
    .field private string propErrorsAppend
    .field private string propKeyFile
    .field private string propImport
    .field private string propPlays
    .field private string propDisplayOut
    .field private string propDisplayAppend
    .field private string propDebugCmds
    .field private string propTerminalOut
    .field private string[] propObjLib
    .field private string propEmbeddedLib
    .field private bool propDebug
    .field private bool propUniCode
    .field private bool propWide
    .field private bool propNoStop
    .field private bool propCache
    .field private bool propShowError
    .field private bool propTerminalInit
    .field private bool propCGIWarnings
    .field private bool propIgnoreSignals
    .field private bool propListConfig
    .field private bool propNoSaveDebug
    .field private bool propSafeMode
    .field private bool propNonNumeric
    .field private bool propExtendedError
    .field private bool propDumpMem
    .field private bool propCharToGui
    .field private bool propZipErrorFile
    .field private bool propLinkageLength
    .method private hidebysig static pinvokeimpl("wrun32.dll" ansi cdecl) 
            int32  AcuInitialize(char* cmdline) cil managed preservesig
    {
    }
    .method private hidebysig static pinvokeimpl("wrun32.dll" ansi cdecl) 
            void  acu_shutdown(int32 msg) cil managed preservesig
    {
    }
    .method private hidebysig static pinvokeimpl("wrun32.dll" ansi cdecl) 
            int32  acu_cobol(valuetype acucobol.a_cobol_info* pInfo) cil managed preservesig
    {
    }
    .method private hidebysig static pinvokeimpl("wrun32.dll" ansi cdecl) 
            void  AcuShutdown() cil managed preservesig
    {
    }
    .method private hidebysig static pinvokeimpl("wrun32.dll" ansi cdecl) 
            void  acu_unload(char* program,
                             int32 called_programs) cil managed preservesig
    {
    }
    .method private hidebysig static pinvokeimpl("wrun32.dll" ansi cdecl) 
            void  acu_unload_all() cil managed preservesig
    {
    }
    .method private hidebysig static pinvokeimpl("wrun32.dll" ansi cdecl) 
            void  acu_cancel(char* program) cil managed preservesig
    {
    }
    .method private hidebysig static pinvokeimpl("wrun32.dll" ansi cdecl) 
            void  acu_cancel_all() cil managed preservesig
    {
    }
    .method private hidebysig static pinvokeimpl("Kernel32.dll" ansi cdecl) 
            int32  CreateMutex(void* lpMutexAttributes,
                               int32 bInitialOwner,
                               char* lpName) cil managed preservesig
    {
    }
    .method private hidebysig static pinvokeimpl("Kernel32.dll" ansi cdecl) 
            int32  GetLastError() cil managed preservesig
    {
    }
    .method public hidebysig specialname 
            instance void  set_Debug(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propDebug
      IL_0007:  ret
    } // end of method CVM::set_Debug

    .method public hidebysig specialname 
            instance void  set_Unicode(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propUniCode
      IL_0007:  ret
    } // end of method CVM::set_Unicode

    .method public hidebysig specialname 
            instance void  set_Wide(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propWide
      IL_0007:  ret
    } // end of method CVM::set_Wide

    .method public hidebysig specialname 
            instance void  set_NoStop(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propNoStop
      IL_0007:  ret
    } // end of method CVM::set_NoStop

    .method public hidebysig specialname 
            instance void  set_Cache(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propCache
      IL_0007:  ret
    } // end of method CVM::set_Cache

    .method public hidebysig specialname 
            instance void  set_TerminalInit(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propTerminalInit
      IL_0007:  ret
    } // end of method CVM::set_TerminalInit

    .method public hidebysig specialname 
            instance void  set_CGIWarnings(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propCGIWarnings
      IL_0007:  ret
    } // end of method CVM::set_CGIWarnings

    .method public hidebysig specialname 
            instance void  set_IgnoreSignals(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propIgnoreSignals
      IL_0007:  ret
    } // end of method CVM::set_IgnoreSignals

    .method public hidebysig specialname 
            instance void  set_ListConfig(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propListConfig
      IL_0007:  ret
    } // end of method CVM::set_ListConfig

    .method public hidebysig specialname 
            instance void  set_NoSaveDebug(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propNoSaveDebug
      IL_0007:  ret
    } // end of method CVM::set_NoSaveDebug

    .method public hidebysig specialname 
            instance void  set_SafeMode(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propSafeMode
      IL_0007:  ret
    } // end of method CVM::set_SafeMode

    .method public hidebysig specialname 
            instance void  set_NonNumeric(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propNonNumeric
      IL_0007:  ret
    } // end of method CVM::set_NonNumeric

    .method public hidebysig specialname 
            instance void  set_ExtendedError(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propExtendedError
      IL_0007:  ret
    } // end of method CVM::set_ExtendedError

    .method public hidebysig specialname 
            instance void  set_DumpMem(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propDumpMem
      IL_0007:  ret
    } // end of method CVM::set_DumpMem

    .method public hidebysig specialname 
            instance void  set_ShowError(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propShowError
      IL_0007:  ret
    } // end of method CVM::set_ShowError

    .method public hidebysig specialname 
            instance void  set_CharToGui(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propCharToGui
      IL_0007:  ret
    } // end of method CVM::set_CharToGui

    .method public hidebysig specialname 
            instance void  set_ZipErrorFile(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propZipErrorFile
      IL_0007:  ret
    } // end of method CVM::set_ZipErrorFile

    .method public hidebysig specialname 
            instance void  set_LinkageLength(bool 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      bool acucobol.CVM::propLinkageLength
      IL_0007:  ret
    } // end of method CVM::set_LinkageLength

    .method public hidebysig specialname 
            instance void  set_EmbeddedLib(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::propEmbeddedLib
      IL_0007:  ret
    } // end of method CVM::set_EmbeddedLib

    .method public hidebysig specialname 
            instance string  get_LastErrorMsg() cil managed
    {
      // Code size       11 (0xb)
      .maxstack  1
      .locals ([0] string CS$00000003$00000000)
      IL_0000:  ldarg.0
      IL_0001:  ldfld      string acucobol.CVM::error_msg
      IL_0006:  stloc.0
      IL_0007:  br.s       IL_0009

      IL_0009:  ldloc.0
      IL_000a:  ret
    } // end of method CVM::get_LastErrorMsg

    .method public hidebysig specialname 
            instance void  set_RunPath(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::RuntimePath
      IL_0007:  ret
    } // end of method CVM::set_RunPath

    .method public hidebysig specialname 
            instance void  set_Switches(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::propSwitches
      IL_0007:  ret
    } // end of method CVM::set_Switches

    .method public hidebysig specialname 
            instance void  set_ConfigFile(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::propConfigFile
      IL_0007:  ret
    } // end of method CVM::set_ConfigFile

    .method public hidebysig specialname 
            instance void  set_ErrorsOut(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::propErrorsOut
      IL_0007:  ret
    } // end of method CVM::set_ErrorsOut

    .method public hidebysig specialname 
            instance void  set_ErrorsAppend(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::propErrorsAppend
      IL_0007:  ret
    } // end of method CVM::set_ErrorsAppend

    .method public hidebysig specialname 
            instance void  set_KeyFile(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::propKeyFile
      IL_0007:  ret
    } // end of method CVM::set_KeyFile

    .method public hidebysig specialname 
            instance void  set_Import(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::propImport
      IL_0007:  ret
    } // end of method CVM::set_Import

    .method public hidebysig specialname 
            instance void  set_Plays(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::propPlays
      IL_0007:  ret
    } // end of method CVM::set_Plays

    .method public hidebysig specialname 
            instance void  set_DisplayOut(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::propDisplayOut
      IL_0007:  ret
    } // end of method CVM::set_DisplayOut

    .method public hidebysig specialname 
            instance void  set_DisplayAppend(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::propDisplayAppend
      IL_0007:  ret
    } // end of method CVM::set_DisplayAppend

    .method public hidebysig specialname 
            instance void  set_DebugCmds(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::propDebugCmds
      IL_0007:  ret
    } // end of method CVM::set_DebugCmds

    .method public hidebysig specialname 
            instance void  set_TerminalOut(string 'value') cil managed
    {
      // Code size       8 (0x8)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldarg.1
      IL_0002:  stfld      string acucobol.CVM::propTerminalOut
      IL_0007:  ret
    } // end of method CVM::set_TerminalOut

    .method public hidebysig specialname 
            instance void  set_ObjLib(string 'value') cil managed
    {
      // Code size       50 (0x32)
      .maxstack  4
      .locals ([0] int32 CS$00000002$00000000)
      IL_0000:  ldarg.0
      IL_0001:  ldfld      string[] acucobol.CVM::propObjLib
      IL_0006:  ldarg.0
      IL_0007:  dup
      IL_0008:  ldfld      int32 acucobol.CVM::Objidx
      IL_000d:  dup
      IL_000e:  stloc.0
      IL_000f:  ldc.i4.1
      IL_0010:  add
      IL_0011:  stfld      int32 acucobol.CVM::Objidx
      IL_0016:  ldloc.0
      IL_0017:  ldarg.1
      IL_0018:  stelem.ref
      IL_0019:  ldarg.0
      IL_001a:  ldfld      int32 acucobol.CVM::Objidx
      IL_001f:  ldc.i4.s   32
      IL_0021:  bne.un.s   IL_0031

      IL_0023:  ldarg.0
      IL_0024:  dup
      IL_0025:  ldfld      int32 acucobol.CVM::Objidx
      IL_002a:  ldc.i4.1
      IL_002b:  sub
      IL_002c:  stfld      int32 acucobol.CVM::Objidx
      IL_0031:  ret
    } // end of method CVM::set_ObjLib

    .method public hidebysig specialname rtspecialname 
            instance void  .ctor() cil managed
    {
      // Code size       276 (0x114)
      .maxstack  2
      IL_0000:  ldarg.0
      IL_0001:  call       instance void [mscorlib]System.Object::.ctor()
      IL_0006:  ldarg.0
      IL_0007:  ldc.i4.0
      IL_0008:  stfld      bool acucobol.CVM::disposed
      IL_000d:  ldarg.0
      IL_000e:  ldnull
      IL_000f:  stfld      string acucobol.CVM::oldRuntimePath
      IL_0014:  ldarg.0
      IL_0015:  ldc.i4.0
      IL_0016:  stfld      bool acucobol.CVM::Initialized
      IL_001b:  ldarg.0
      IL_001c:  ldstr      ""
      IL_0021:  stfld      string acucobol.CVM::error_msg
      IL_0026:  ldarg.0
      IL_0027:  ldnull
      IL_0028:  stfld      string acucobol.CVM::RuntimePath
      IL_002d:  ldarg.0
      IL_002e:  ldc.i4.0
      IL_002f:  stfld      bool acucobol.CVM::propDebug
      IL_0034:  ldarg.0
      IL_0035:  ldc.i4.0
      IL_0036:  stfld      bool acucobol.CVM::propUniCode
      IL_003b:  ldarg.0
      IL_003c:  ldc.i4.0
      IL_003d:  stfld      bool acucobol.CVM::propWide
      IL_0042:  ldarg.0
      IL_0043:  ldc.i4.0
      IL_0044:  stfld      bool acucobol.CVM::propNoStop
      IL_0049:  ldarg.0
      IL_004a:  ldc.i4.0
      IL_004b:  stfld      bool acucobol.CVM::propCache
      IL_0050:  ldarg.0
      IL_0051:  ldc.i4.0
      IL_0052:  stfld      bool acucobol.CVM::propShowError
      IL_0057:  ldarg.0
      IL_0058:  ldnull
      IL_0059:  stfld      string acucobol.CVM::propSwitches
      IL_005e:  ldarg.0
      IL_005f:  ldnull
      IL_0060:  stfld      string acucobol.CVM::propConfigFile
      IL_0065:  ldarg.0
      IL_0066:  ldnull
      IL_0067:  stfld      string acucobol.CVM::propErrorsOut
      IL_006c:  ldarg.0
      IL_006d:  ldnull
      IL_006e:  stfld      string acucobol.CVM::propErrorsAppend
      IL_0073:  ldarg.0
      IL_0074:  ldnull
      IL_0075:  stfld      string acucobol.CVM::propKeyFile
      IL_007a:  ldarg.0
      IL_007b:  ldnull
      IL_007c:  stfld      string acucobol.CVM::propImport
      IL_0081:  ldarg.0
      IL_0082:  ldnull
      IL_0083:  stfld      string acucobol.CVM::propPlays
      IL_0088:  ldarg.0
      IL_0089:  ldnull
      IL_008a:  stfld      string acucobol.CVM::propDisplayOut
      IL_008f:  ldarg.0
      IL_0090:  ldnull
      IL_0091:  stfld      string acucobol.CVM::propDisplayAppend
      IL_0096:  ldarg.0
      IL_0097:  ldnull
      IL_0098:  stfld      string acucobol.CVM::propDebugCmds
      IL_009d:  ldarg.0
      IL_009e:  ldnull
      IL_009f:  stfld      string acucobol.CVM::propTerminalOut
      IL_00a4:  ldarg.0
      IL_00a5:  ldc.i4.0
      IL_00a6:  stfld      bool acucobol.CVM::propTerminalInit
      IL_00ab:  ldarg.0
      IL_00ac:  ldc.i4.0
      IL_00ad:  stfld      bool acucobol.CVM::propCGIWarnings
      IL_00b2:  ldarg.0
      IL_00b3:  ldc.i4.0
      IL_00b4:  stfld      bool acucobol.CVM::propIgnoreSignals
      IL_00b9:  ldarg.0
      IL_00ba:  ldc.i4.0
      IL_00bb:  stfld      bool acucobol.CVM::propListConfig
      IL_00c0:  ldarg.0
      IL_00c1:  ldc.i4.0
      IL_00c2:  stfld      bool acucobol.CVM::propNoSaveDebug
      IL_00c7:  ldarg.0
      IL_00c8:  ldc.i4.0
      IL_00c9:  stfld      bool acucobol.CVM::propSafeMode
      IL_00ce:  ldarg.0
      IL_00cf:  ldc.i4.0
      IL_00d0:  stfld      bool acucobol.CVM::propNonNumeric
      IL_00d5:  ldarg.0
      IL_00d6:  ldc.i4.0
      IL_00d7:  stfld      bool acucobol.CVM::propExtendedError
      IL_00dc:  ldarg.0
      IL_00dd:  ldc.i4.0
      IL_00de:  stfld      bool acucobol.CVM::propDumpMem
      IL_00e3:  ldarg.0
      IL_00e4:  ldc.i4.0
      IL_00e5:  stfld      bool acucobol.CVM::propCharToGui
      IL_00ea:  ldarg.0
      IL_00eb:  ldnull
      IL_00ec:  stfld      string acucobol.CVM::propEmbeddedLib
      IL_00f1:  ldarg.0
      IL_00f2:  ldc.i4.0
      IL_00f3:  stfld      bool acucobol.CVM::propZipErrorFile
      IL_00f8:  ldarg.0
      IL_00f9:  ldc.i4.0
      IL_00fa:  stfld      bool acucobol.CVM::propLinkageLength
      IL_00ff:  ldarg.0
      IL_0100:  ldc.i4.0
      IL_0101:  stfld      int32 acucobol.CVM::Objidx
      IL_0106:  ldarg.0
      IL_0107:  ldc.i4.s   32
      IL_0109:  newarr     [mscorlib]System.String
      IL_010e:  stfld      string[] acucobol.CVM::propObjLib
      IL_0113:  ret
    } // end of method CVM::.ctor

    .method public hidebysig newslot virtual final 
            instance void  Dispose() cil managed
    {
      // Code size       14 (0xe)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldc.i4.1
      IL_0002:  call       instance void acucobol.CVM::Dispose(bool)
      IL_0007:  ldarg.0
      IL_0008:  call       void [mscorlib]System.GC::SuppressFinalize(object)
      IL_000d:  ret
    } // end of method CVM::Dispose

    .method private hidebysig instance void 
            Dispose(bool disposing) cil managed
    {
      // Code size       19 (0x13)
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  ldfld      bool acucobol.CVM::disposed
      IL_0006:  brtrue.s   IL_000b

      IL_0008:  ldarg.1
      IL_0009:  brfalse.s  IL_000b

      IL_000b:  ldarg.0
      IL_000c:  ldc.i4.1
      IL_000d:  stfld      bool acucobol.CVM::disposed
      IL_0012:  ret
    } // end of method CVM::Dispose

    .method family hidebysig virtual instance void 
            Finalize() cil managed
    {
      // Code size       17 (0x11)
      .maxstack  2
      .try
      {
        IL_0000:  ldarg.0
        IL_0001:  ldc.i4.0
        IL_0002:  call       instance void acucobol.CVM::Dispose(bool)
        IL_0007:  leave.s    IL_0010

      }  // end .try
      finally
      {
        IL_0009:  ldarg.0
        IL_000a:  call       instance void [mscorlib]System.Object::Finalize()
        IL_000f:  endfinally
      }  // end handler
      IL_0010:  ret
    } // end of method CVM::Finalize

    .method private hidebysig instance valuetype acucobol.a_cobol_info* 
            AllocInfo() cil managed
    {
      // Code size       109 (0x6d)
      .maxstack  2
      .locals ([0] valuetype acucobol.a_cobol_info* pInfoStruct,
               [1] valuetype acucobol.a_cobol_info* CS$00000003$00000000)
      IL_0000:  sizeof     acucobol.a_cobol_info
      IL_0006:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::AllocCoTaskMem(int32)
      IL_000b:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_0010:  stloc.0
      IL_0011:  ldloc.0
      IL_0012:  sizeof     acucobol.a_cobol_info
      IL_0018:  stfld      unsigned int32 acucobol.a_cobol_info::a_cobol_info_size
      IL_001d:  ldloc.0
      IL_001e:  ldc.i4.0
      IL_001f:  conv.u
      IL_0020:  stfld      void* acucobol.a_cobol_info::pgm_name
      IL_0025:  ldloc.0
      IL_0026:  ldc.i4.0
      IL_0027:  stfld      int32 acucobol.a_cobol_info::num_params
      IL_002c:  ldloc.0
      IL_002d:  ldc.i4.0
      IL_002e:  stfld      int32 acucobol.a_cobol_info::exit_code
      IL_0033:  ldloc.0
      IL_0034:  ldc.i4.0
      IL_0035:  conv.u
      IL_0036:  stfld      unsigned int8* acucobol.a_cobol_info::p_exit_msg
      IL_003b:  ldloc.0
      IL_003c:  ldc.i4.0
      IL_003d:  stfld      int32 acucobol.a_cobol_info::signal_number
      IL_0042:  ldloc.0
      IL_0043:  ldc.i4.0
      IL_0044:  stfld      valuetype acucobol.errorTypes acucobol.a_cobol_info::call_error
      IL_0049:  ldloc.0
      IL_004a:  ldc.i4.0
      IL_004b:  conv.u
      IL_004c:  stfld      void* acucobol.a_cobol_info::debugger
      IL_0051:  ldloc.0
      IL_0052:  ldc.i4.0
      IL_0053:  stfld      unsigned int32 acucobol.a_cobol_info::no_stop_cache
      IL_0058:  ldloc.0
      IL_0059:  ldc.i4.0
      IL_005a:  conv.u
      IL_005b:  stfld      valuetype acucobol.ARGUMENT_ENTRY* acucobol.a_cobol_info::p_params
      IL_0060:  ldloc.0
      IL_0061:  ldc.i4.0
      IL_0062:  stfld      valuetype acucobol.DEBUG_METHODS acucobol.a_cobol_info::debug_methods
      IL_0067:  ldloc.0
      IL_0068:  stloc.1
      IL_0069:  br.s       IL_006b

      IL_006b:  ldloc.1
      IL_006c:  ret
    } // end of method CVM::AllocInfo

    .method public hidebysig instance valuetype acucobol.errorTypes 
            FreeInfo(valuetype acucobol.a_cobol_info* pInfoStruct) cil managed
    {
      // Code size       118 (0x76)
      .maxstack  2
      .locals ([0] valuetype acucobol.ARGUMENT_ENTRY* pArg,
               [1] int32 j,
               [2] valuetype acucobol.errorTypes CS$00000003$00000000)
      IL_0000:  ldarg.1
      IL_0001:  ldfld      valuetype acucobol.ARGUMENT_ENTRY* acucobol.a_cobol_info::p_params
      IL_0006:  stloc.0
      IL_0007:  ldc.i4.0
      IL_0008:  stloc.1
      IL_0009:  br.s       IL_0032

      IL_000b:  ldloc.0
      IL_000c:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0011:  ldc.i4.0
      IL_0012:  conv.u
      IL_0013:  beq.s      IL_002e

      IL_0015:  ldloc.0
      IL_0016:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_001b:  call       native int [mscorlib]System.IntPtr::op_Explicit(void*)
      IL_0020:  call       void [mscorlib]System.Runtime.InteropServices.Marshal::FreeCoTaskMem(native int)
      IL_0025:  ldloc.0
      IL_0026:  sizeof     acucobol.ARGUMENT_ENTRY
      IL_002c:  add
      IL_002d:  stloc.0
      IL_002e:  ldloc.1
      IL_002f:  ldc.i4.1
      IL_0030:  add
      IL_0031:  stloc.1
      IL_0032:  ldloc.1
      IL_0033:  ldarg.1
      IL_0034:  ldfld      int32 acucobol.a_cobol_info::num_params
      IL_0039:  blt.s      IL_000b

      IL_003b:  ldarg.1
      IL_003c:  ldfld      valuetype acucobol.ARGUMENT_ENTRY* acucobol.a_cobol_info::p_params
      IL_0041:  ldc.i4.0
      IL_0042:  conv.u
      IL_0043:  beq.s      IL_0055

      IL_0045:  ldarg.1
      IL_0046:  ldfld      valuetype acucobol.ARGUMENT_ENTRY* acucobol.a_cobol_info::p_params
      IL_004b:  call       native int [mscorlib]System.IntPtr::op_Explicit(void*)
      IL_0050:  call       void [mscorlib]System.Runtime.InteropServices.Marshal::FreeCoTaskMem(native int)
      IL_0055:  ldarg.1
      IL_0056:  ldfld      void* acucobol.a_cobol_info::pgm_name
      IL_005b:  call       native int [mscorlib]System.IntPtr::op_Explicit(void*)
      IL_0060:  call       void [mscorlib]System.Runtime.InteropServices.Marshal::FreeCoTaskMem(native int)
      IL_0065:  ldarg.1
      IL_0066:  call       native int [mscorlib]System.IntPtr::op_Explicit(void*)
      IL_006b:  call       void [mscorlib]System.Runtime.InteropServices.Marshal::FreeCoTaskMem(native int)
      IL_0070:  ldc.i4.0
      IL_0071:  stloc.2
      IL_0072:  br.s       IL_0074

      IL_0074:  ldloc.2
      IL_0075:  ret
    } // end of method CVM::FreeInfo

    .method public hidebysig instance bool 
            Initialize() cil managed
    {
      // Code size       12 (0xc)
      .maxstack  2
      .locals ([0] bool CS$00000003$00000000)
      IL_0000:  ldarg.0
      IL_0001:  ldnull
      IL_0002:  call       instance bool acucobol.CVM::Initialize(string)
      IL_0007:  stloc.0
      IL_0008:  br.s       IL_000a

      IL_000a:  ldloc.0
      IL_000b:  ret
    } // end of method CVM::Initialize

    .method public hidebysig instance bool 
            Initialize(string cmdline) cil managed
    {
      // Code size       694 (0x2b6)
      .maxstack  3
      .locals ([0] int32 irtn,
               [1] native int pCmd,
               [2] string options,
               [3] string LatestVersion,
               [4] int32 iLatestVersion,
               [5] int32 accum,
               [6] int32 accumTot,
               [7] int32 mult,
               [8] int32 mult2,
               [9] int32 num,
               [10] string pid,
               [11] class [System]System.Diagnostics.Process currentProcess,
               [12] class [mscorlib]Microsoft.Win32.RegistryKey rk,
               [13] class [mscorlib]Microsoft.Win32.RegistryKey rkSub,
               [14] string[] keyVersion,
               [15] string Version,
               [16] int32 i,
               [17] class [mscorlib]System.Exception e,
               [18] class [mscorlib]System.Exception innerE,
               [19] class [mscorlib]System.Exception V_19,
               [20] bool CS$00000003$00000000,
               [21] native int CS$00000002$00000001,
               [22] string[] CS$00000007$00000002,
               [23] int32 CS$00000008$00000003)
      IL_0000:  ldstr      ""
      IL_0005:  stloc.2
      IL_0006:  ldstr      ""
      IL_000b:  stloc.3
      IL_000c:  ldc.i4.0
      IL_000d:  stloc.s    iLatestVersion
      IL_000f:  ldc.i4.0
      IL_0010:  stloc.s    accum
      IL_0012:  ldc.i4.0
      IL_0013:  stloc.s    accumTot
      IL_0015:  ldc.i4.s   100
      IL_0017:  stloc.s    mult
      IL_0019:  ldc.i4.s   100
      IL_001b:  stloc.s    mult2
      IL_001d:  ldc.i4.0
      IL_001e:  stloc.s    num
      IL_0020:  ldarg.0
      IL_0021:  ldfld      bool acucobol.CVM::Initialized
      IL_0026:  brfalse.s  IL_0030

      IL_0028:  ldc.i4.0
      IL_0029:  stloc.s    CS$00000003$00000000
      IL_002b:  br         IL_02b3

      IL_0030:  call       class [System]System.Diagnostics.Process [System]System.Diagnostics.Process::GetCurrentProcess()
      IL_0035:  stloc.s    currentProcess
      IL_0037:  ldloc.s    currentProcess
      IL_0039:  callvirt   instance native int [System]System.Diagnostics.Process::get_Handle()
      IL_003e:  stloc.s    CS$00000002$00000001
      IL_0040:  ldloca.s   CS$00000002$00000001
      IL_0042:  call       instance string [mscorlib]System.IntPtr::ToString()
      IL_0047:  stloc.s    pid
      IL_0049:  ldloc.s    pid
      IL_004b:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::StringToCoTaskMemAnsi(string)
      IL_0050:  stloc.1
      IL_0051:  ldc.i4.0
      IL_0052:  conv.u
      IL_0053:  ldc.i4.1
      IL_0054:  ldloc.1
      IL_0055:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_005a:  call       int32 acucobol.CVM::CreateMutex(void*,
                                                           int32,
                                                           char*)
      IL_005f:  stloc.0
      IL_0060:  ldloc.0
      IL_0061:  brfalse.s  IL_0080

      IL_0063:  call       int32 acucobol.CVM::GetLastError()
      IL_0068:  stloc.0
      IL_0069:  ldloc.0
      IL_006a:  ldc.i4     0xb7
      IL_006f:  bne.un.s   IL_0080

      IL_0071:  ldarg.0
      IL_0072:  ldc.i4.1
      IL_0073:  stfld      bool acucobol.CVM::Initialized
      IL_0078:  ldc.i4.0
      IL_0079:  stloc.s    CS$00000003$00000000
      IL_007b:  br         IL_02b3

      IL_0080:  ldloc.1
      IL_0081:  call       void [mscorlib]System.Runtime.InteropServices.Marshal::FreeCoTaskMem(native int)
      IL_0086:  ldarg.0
      IL_0087:  ldarg.1
      IL_0088:  call       instance void acucobol.CVM::SetProperties(string)
      IL_008d:  ldarg.0
      IL_008e:  ldloca.s   options
      IL_0090:  call       instance void acucobol.CVM::BuildOptions(string&)
      IL_0095:  ldarg.0
      IL_0096:  ldfld      string acucobol.CVM::RuntimePath
      IL_009b:  brfalse.s  IL_00ad

      IL_009d:  ldarg.0
      IL_009e:  ldfld      string acucobol.CVM::RuntimePath
      IL_00a3:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_00a8:  brtrue     IL_01ef

      IL_00ad:  ldsfld     class [mscorlib]Microsoft.Win32.RegistryKey [mscorlib]Microsoft.Win32.Registry::LocalMachine
      IL_00b2:  stloc.s    rk
      IL_00b4:  ldloc.s    rk
      IL_00b6:  ldstr      "SOFTWARE\\Acucorp, Inc.\\ACUCOBOL-GT"
      IL_00bb:  callvirt   instance class [mscorlib]Microsoft.Win32.RegistryKey [mscorlib]Microsoft.Win32.RegistryKey::OpenSubKey(string)
      IL_00c0:  stloc.s    rkSub
      IL_00c2:  ldloc.s    rkSub
      IL_00c4:  brfalse    IL_01ef

      IL_00c9:  ldloc.s    rkSub
      IL_00cb:  callvirt   instance string[] [mscorlib]Microsoft.Win32.RegistryKey::GetSubKeyNames()
      IL_00d0:  stloc.s    keyVersion
      IL_00d2:  ldloc.s    keyVersion
      IL_00d4:  brfalse    IL_01c5

      IL_00d9:  ldloc.s    keyVersion
      IL_00db:  ldlen
      IL_00dc:  conv.i4
      IL_00dd:  ldc.i4.0
      IL_00de:  ble        IL_01c5

      IL_00e3:  ldloc.s    keyVersion
      IL_00e5:  stloc.s    CS$00000007$00000002
      IL_00e7:  ldc.i4.0
      IL_00e8:  stloc.s    CS$00000008$00000003
      IL_00ea:  br         IL_01ba

      IL_00ef:  ldloc.s    CS$00000007$00000002
      IL_00f1:  ldloc.s    CS$00000008$00000003
      IL_00f3:  ldelem.ref
      IL_00f4:  stloc.s    Version
      IL_00f6:  ldloc.s    Version
      IL_00f8:  ldc.i4.0
      IL_00f9:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_00fe:  ldc.i4.0
      IL_00ff:  ble        IL_01b4

      IL_0104:  ldloc.s    Version
      IL_0106:  ldc.i4.0
      IL_0107:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_010c:  ldc.i4.s   9
      IL_010e:  blt        IL_01b4

      IL_0113:  ldc.i4.0
      IL_0114:  stloc.s    accum
      IL_0116:  ldc.i4.0
      IL_0117:  stloc.s    accumTot
      IL_0119:  ldc.i4.s   100
      IL_011b:  stloc.s    mult
      IL_011d:  ldc.i4.s   100
      IL_011f:  stloc.s    mult2
      IL_0121:  ldc.i4.0
      IL_0122:  stloc.s    num
      IL_0124:  ldc.i4.0
      IL_0125:  stloc.s    i
      IL_0127:  br.s       IL_018e

      IL_0129:  ldloc.s    Version
      IL_012b:  ldloc.s    i
      IL_012d:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0132:  ldc.i4.s   46
      IL_0134:  bne.un.s   IL_0159

      IL_0136:  ldloc.s    mult
      IL_0138:  ldc.i4.0
      IL_0139:  ble.s      IL_0142

      IL_013b:  ldloc.s    accum
      IL_013d:  ldloc.s    mult
      IL_013f:  mul
      IL_0140:  stloc.s    accum
      IL_0142:  ldloc.s    accumTot
      IL_0144:  ldloc.s    accum
      IL_0146:  add
      IL_0147:  stloc.s    accumTot
      IL_0149:  ldc.i4.0
      IL_014a:  stloc.s    accum
      IL_014c:  ldloc.s    mult
      IL_014e:  ldc.i4.s   10
      IL_0150:  div
      IL_0151:  stloc.s    mult
      IL_0153:  ldc.i4.s   100
      IL_0155:  stloc.s    mult2
      IL_0157:  br.s       IL_0188

      IL_0159:  ldloc.s    Version
      IL_015b:  ldloc.s    i
      IL_015d:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0162:  call       int32 [mscorlib]System.Convert::ToInt32(char)
      IL_0167:  stloc.s    num
      IL_0169:  ldloc.s    mult2
      IL_016b:  ldc.i4.0
      IL_016c:  ble.s      IL_017a

      IL_016e:  ldloc.s    accum
      IL_0170:  ldloc.s    num
      IL_0172:  ldloc.s    mult2
      IL_0174:  mul
      IL_0175:  add
      IL_0176:  stloc.s    accum
      IL_0178:  br.s       IL_0181

      IL_017a:  ldloc.s    accum
      IL_017c:  ldloc.s    num
      IL_017e:  add
      IL_017f:  stloc.s    accum
      IL_0181:  ldloc.s    mult2
      IL_0183:  ldc.i4.s   10
      IL_0185:  div
      IL_0186:  stloc.s    mult2
      IL_0188:  ldloc.s    i
      IL_018a:  ldc.i4.1
      IL_018b:  add
      IL_018c:  stloc.s    i
      IL_018e:  ldloc.s    i
      IL_0190:  ldloc.s    Version
      IL_0192:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_0197:  blt.s      IL_0129

      IL_0199:  ldloc.s    accum
      IL_019b:  ldloc.s    num
      IL_019d:  add
      IL_019e:  stloc.s    accum
      IL_01a0:  ldloc.s    accumTot
      IL_01a2:  ldloc.s    accum
      IL_01a4:  add
      IL_01a5:  stloc.s    accumTot
      IL_01a7:  ldloc.s    accumTot
      IL_01a9:  ldloc.s    iLatestVersion
      IL_01ab:  ble.s      IL_01b4

      IL_01ad:  ldloc.s    accum
      IL_01af:  stloc.s    iLatestVersion
      IL_01b1:  ldloc.s    Version
      IL_01b3:  stloc.3
      IL_01b4:  ldloc.s    CS$00000008$00000003
      IL_01b6:  ldc.i4.1
      IL_01b7:  add
      IL_01b8:  stloc.s    CS$00000008$00000003
      IL_01ba:  ldloc.s    CS$00000008$00000003
      IL_01bc:  ldloc.s    CS$00000007$00000002
      IL_01be:  ldlen
      IL_01bf:  conv.i4
      IL_01c0:  blt        IL_00ef

      IL_01c5:  ldloc.3
      IL_01c6:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_01cb:  ldc.i4.0
      IL_01cc:  ble.s      IL_01ef

      IL_01ce:  ldloc.s    rkSub
      IL_01d0:  ldloc.3
      IL_01d1:  callvirt   instance class [mscorlib]Microsoft.Win32.RegistryKey [mscorlib]Microsoft.Win32.RegistryKey::OpenSubKey(string)
      IL_01d6:  stloc.s    rkSub
      IL_01d8:  ldarg.0
      IL_01d9:  ldloc.s    rkSub
      IL_01db:  ldstr      "PathName"
      IL_01e0:  callvirt   instance object [mscorlib]Microsoft.Win32.RegistryKey::GetValue(string)
      IL_01e5:  castclass  [mscorlib]System.String
      IL_01ea:  stfld      string acucobol.CVM::RuntimePath
      IL_01ef:  ldarg.0
      IL_01f0:  ldfld      string acucobol.CVM::RuntimePath
      IL_01f5:  brfalse    IL_027b

      IL_01fa:  ldarg.0
      IL_01fb:  ldfld      string acucobol.CVM::RuntimePath
      IL_0200:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_0205:  ldc.i4.0
      IL_0206:  ble.s      IL_027b

      .try
      {
        IL_0208:  ldarg.0
        IL_0209:  call       string [mscorlib]System.IO.Directory::GetCurrentDirectory()
        IL_020e:  stfld      string acucobol.CVM::oldRuntimePath
        IL_0213:  ldarg.0
        IL_0214:  ldfld      string acucobol.CVM::RuntimePath
        IL_0219:  call       void [mscorlib]System.IO.Directory::SetCurrentDirectory(string)
        IL_021e:  leave.s    IL_027b

      }  // end .try
      catch [mscorlib]System.Exception 
      {
        IL_0220:  stloc.s    e
        IL_0222:  ldloc.s    e
        IL_0224:  callvirt   instance class [mscorlib]System.Exception [mscorlib]System.Exception::get_InnerException()
        IL_0229:  stloc.s    innerE
        IL_022b:  ldloc.s    innerE
        IL_022d:  brfalse.s  IL_024d

        IL_022f:  ldloc.s    innerE
        IL_0231:  callvirt   instance string [mscorlib]System.Exception::get_Message()
        IL_0236:  callvirt   instance int32 [mscorlib]System.String::get_Length()
        IL_023b:  ldc.i4.0
        IL_023c:  ble.s      IL_024d

        IL_023e:  ldarg.0
        IL_023f:  ldloc.s    innerE
        IL_0241:  callvirt   instance string [mscorlib]System.Exception::get_Message()
        IL_0246:  stfld      string acucobol.CVM::error_msg
        IL_024b:  br.s       IL_0276

        IL_024d:  ldloc.s    e
        IL_024f:  callvirt   instance string [mscorlib]System.Exception::get_Message()
        IL_0254:  callvirt   instance int32 [mscorlib]System.String::get_Length()
        IL_0259:  ldc.i4.0
        IL_025a:  ble.s      IL_026b

        IL_025c:  ldarg.0
        IL_025d:  ldloc.s    e
        IL_025f:  callvirt   instance string [mscorlib]System.Exception::get_Message()
        IL_0264:  stfld      string acucobol.CVM::error_msg
        IL_0269:  br.s       IL_0276

        IL_026b:  ldarg.0
        IL_026c:  ldstr      "Invalid Directory Path"
        IL_0271:  stfld      string acucobol.CVM::error_msg
        IL_0276:  ldc.i4.0
        IL_0277:  stloc.s    CS$00000003$00000000
        IL_0279:  leave.s    IL_02b3

      }  // end handler
      IL_027b:  ldloc.2
      IL_027c:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::StringToCoTaskMemAnsi(string)
      IL_0281:  stloc.1
      .try
      {
        IL_0282:  ldloc.1
        IL_0283:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
        IL_0288:  call       int32 acucobol.CVM::AcuInitialize(char*)
        IL_028d:  stloc.0
        IL_028e:  leave.s    IL_0299

      }  // end .try
      catch [mscorlib]System.Exception 
      {
        IL_0290:  stloc.s    V_19
        IL_0292:  ldloc.0
        IL_0293:  brtrue.s   IL_0297

        IL_0295:  ldc.i4.1
        IL_0296:  stloc.0
        IL_0297:  leave.s    IL_0299

      }  // end handler
      IL_0299:  ldloc.1
      IL_029a:  call       void [mscorlib]System.Runtime.InteropServices.Marshal::FreeCoTaskMem(native int)
      IL_029f:  ldloc.0
      IL_02a0:  brfalse.s  IL_02a7

      IL_02a2:  ldc.i4.0
      IL_02a3:  stloc.s    CS$00000003$00000000
      IL_02a5:  br.s       IL_02b3

      IL_02a7:  ldarg.0
      IL_02a8:  ldc.i4.1
      IL_02a9:  stfld      bool acucobol.CVM::Initialized
      IL_02ae:  ldc.i4.1
      IL_02af:  stloc.s    CS$00000003$00000000
      IL_02b1:  br.s       IL_02b3

      IL_02b3:  ldloc.s    CS$00000003$00000000
      IL_02b5:  ret
    } // end of method CVM::Initialize

    .method public hidebysig instance void 
            ShutDown(int32 msg) cil managed
    {
      // Code size       14 (0xe)
      .maxstack  8
      IL_0000:  ldarg.1
      IL_0001:  call       void acucobol.CVM::acu_shutdown(int32)
      IL_0006:  ldarg.0
      IL_0007:  ldc.i4.0
      IL_0008:  stfld      bool acucobol.CVM::Initialized
      IL_000d:  ret
    } // end of method CVM::ShutDown

    .method public hidebysig instance valuetype acucobol.errorTypes 
            Call(string pgmName,
                 object[]& CobolParams,
                 unsigned int8[]& CblTypes,
                 string CallOptions,
                 int32& ProgramReturnCode) cil managed
    {
      // Code size       736 (0x2e0)
      .maxstack  5
      .locals ([0] int32 i,
               [1] int32 irtn,
               [2] bool brtn,
               [3] valuetype acucobol.errorTypes translateReturn,
               [4] class [mscorlib]System.Text.Encoding enc,
               [5] int32 memLength,
               [6] unsigned int8* pByte,
               [7] valuetype acucobol.compilerTypes cblType,
               [8] valuetype acucobol.a_cobol_info* pInfoStruct,
               [9] valuetype acucobol.ARGUMENT_ENTRY* pArg,
               [10] valuetype acucobol.AcuInitArgs* pAcuInitArgs,
               [11] valuetype acucobol.errorTypes CS$00000003$00000000)
      IL_0000:  ldc.i4.0
      IL_0001:  stloc.s    memLength
      IL_0003:  ldc.i4.0
      IL_0004:  conv.u
      IL_0005:  stloc.s    pByte
      IL_0007:  ldc.i4.0
      IL_0008:  conv.u
      IL_0009:  stloc.s    pInfoStruct
      IL_000b:  ldc.i4.0
      IL_000c:  conv.u
      IL_000d:  stloc.s    pArg
      IL_000f:  ldc.i4.0
      IL_0010:  conv.u
      IL_0011:  stloc.s    pAcuInitArgs
      IL_0013:  ldarg.1
      IL_0014:  brtrue.s   IL_001e

      IL_0016:  ldc.i4.1
      IL_0017:  stloc.s    CS$00000003$00000000
      IL_0019:  br         IL_02dd

      IL_001e:  call       class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_Default()
      IL_0023:  stloc.s    enc
      IL_0025:  ldarg.0
      IL_0026:  call       instance valuetype acucobol.a_cobol_info* acucobol.CVM::AllocInfo()
      IL_002b:  stloc.s    pInfoStruct
      IL_002d:  ldloc.s    pInfoStruct
      IL_002f:  ldc.i4.0
      IL_0030:  conv.u
      IL_0031:  bne.un.s   IL_003b

      IL_0033:  ldc.i4.4
      IL_0034:  stloc.s    CS$00000003$00000000
      IL_0036:  br         IL_02dd

      IL_003b:  ldarg.2
      IL_003c:  ldind.ref
      IL_003d:  brfalse.s  IL_008d

      IL_003f:  ldarg.2
      IL_0040:  ldind.ref
      IL_0041:  ldlen
      IL_0042:  conv.i4
      IL_0043:  ldc.i4.0
      IL_0044:  ble.s      IL_008d

      IL_0046:  ldarg.2
      IL_0047:  ldind.ref
      IL_0048:  ldlen
      IL_0049:  conv.i4
      IL_004a:  sizeof     acucobol.ARGUMENT_ENTRY
      IL_0050:  mul
      IL_0051:  stloc.s    memLength
      IL_0053:  ldloc.s    pInfoStruct
      IL_0055:  ldloc.s    memLength
      IL_0057:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::AllocCoTaskMem(int32)
      IL_005c:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_0061:  stfld      valuetype acucobol.ARGUMENT_ENTRY* acucobol.a_cobol_info::p_params
      IL_0066:  ldloc.s    pInfoStruct
      IL_0068:  ldarg.2
      IL_0069:  ldind.ref
      IL_006a:  ldlen
      IL_006b:  conv.i4
      IL_006c:  stfld      int32 acucobol.a_cobol_info::num_params
      IL_0071:  ldloc.s    pInfoStruct
      IL_0073:  ldfld      valuetype acucobol.ARGUMENT_ENTRY* acucobol.a_cobol_info::p_params
      IL_0078:  stloc.s    pByte
      IL_007a:  ldc.i4.0
      IL_007b:  stloc.0
      IL_007c:  br.s       IL_0088

      IL_007e:  ldloc.s    pByte
      IL_0080:  ldloc.0
      IL_0081:  add
      IL_0082:  ldc.i4.0
      IL_0083:  stind.i1
      IL_0084:  ldloc.0
      IL_0085:  ldc.i4.1
      IL_0086:  add
      IL_0087:  stloc.0
      IL_0088:  ldloc.0
      IL_0089:  ldloc.s    memLength
      IL_008b:  blt.s      IL_007e

      IL_008d:  ldloc.s    pInfoStruct
      IL_008f:  ldarg.1
      IL_0090:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::StringToCoTaskMemAnsi(string)
      IL_0095:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_009a:  stfld      void* acucobol.a_cobol_info::pgm_name
      IL_009f:  ldarg.s    CallOptions
      IL_00a1:  brfalse.s  IL_00b5

      IL_00a3:  ldarg.s    CallOptions
      IL_00a5:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_00aa:  ldc.i4.0
      IL_00ab:  ble.s      IL_00b5

      IL_00ad:  ldarg.0
      IL_00ae:  ldarg.s    CallOptions
      IL_00b0:  call       instance void acucobol.CVM::SetCallOptions(string)
      IL_00b5:  ldarg.0
      IL_00b6:  ldfld      bool acucobol.CVM::propDebug
      IL_00bb:  brfalse.s  IL_00c5

      IL_00bd:  ldloc.s    pInfoStruct
      IL_00bf:  ldc.i4.2
      IL_00c0:  stfld      valuetype acucobol.DEBUG_METHODS acucobol.a_cobol_info::debug_methods
      IL_00c5:  ldarg.0
      IL_00c6:  ldfld      bool acucobol.CVM::propNoStop
      IL_00cb:  brfalse.s  IL_00d5

      IL_00cd:  ldloc.s    pInfoStruct
      IL_00cf:  ldc.i4.1
      IL_00d0:  stfld      unsigned int32 acucobol.a_cobol_info::no_stop_cache
      IL_00d5:  ldarg.0
      IL_00d6:  ldfld      bool acucobol.CVM::propCache
      IL_00db:  brfalse.s  IL_00ec

      IL_00dd:  ldloc.s    pInfoStruct
      IL_00df:  dup
      IL_00e0:  ldfld      unsigned int32 acucobol.a_cobol_info::no_stop_cache
      IL_00e5:  ldc.i4.2
      IL_00e6:  add
      IL_00e7:  stfld      unsigned int32 acucobol.a_cobol_info::no_stop_cache
      IL_00ec:  ldloc.s    pInfoStruct
      IL_00ee:  ldfld      valuetype acucobol.ARGUMENT_ENTRY* acucobol.a_cobol_info::p_params
      IL_00f3:  stloc.s    pArg
      IL_00f5:  ldc.i4.0
      IL_00f6:  stloc.0
      IL_00f7:  br.s       IL_0167

      IL_00f9:  ldarg.3
      IL_00fa:  ldind.ref
      IL_00fb:  brfalse.s  IL_0105

      IL_00fd:  ldarg.3
      IL_00fe:  ldind.ref
      IL_00ff:  ldloc.0
      IL_0100:  ldelem.u1
      IL_0101:  stloc.s    cblType
      IL_0103:  br.s       IL_010c

      IL_0105:  ldc.i4     0xff
      IL_010a:  stloc.s    cblType
      IL_010c:  ldarg.0
      IL_010d:  ldloc.s    pArg
      IL_010f:  ldarg.2
      IL_0110:  ldind.ref
      IL_0111:  ldloc.0
      IL_0112:  ldelem.ref
      IL_0113:  ldloc.s    cblType
      IL_0115:  ldloc.s    enc
      IL_0117:  call       instance valuetype acucobol.errorTypes acucobol.CVM::TranslateToCobolType(valuetype acucobol.ARGUMENT_ENTRY*,
                                                                                                     object,
                                                                                                     valuetype acucobol.compilerTypes,
                                                                                                     class [mscorlib]System.Text.Encoding)
      IL_011c:  stloc.3
      IL_011d:  ldloc.3
      IL_011e:  brfalse.s  IL_0158

      IL_0120:  ldarg.0
      IL_0121:  ldloc.s    pInfoStruct
      IL_0123:  call       instance valuetype acucobol.errorTypes acucobol.CVM::FreeInfo(valuetype acucobol.a_cobol_info*)
      IL_0128:  pop
      IL_0129:  ldarg.0
      IL_012a:  ldstr      "Unsupported Parameter"
      IL_012f:  stfld      string acucobol.CVM::error_msg
      IL_0134:  ldarg.0
      IL_0135:  ldfld      bool acucobol.CVM::propShowError
      IL_013a:  brfalse.s  IL_0150

      IL_013c:  ldarg.0
      IL_013d:  ldfld      string acucobol.CVM::error_msg
      IL_0142:  ldstr      "WRUNNET"
      IL_0147:  ldc.i4.0
      IL_0148:  ldc.i4.s   16
      IL_014a:  call       valuetype [System.Windows.Forms]System.Windows.Forms.DialogResult [System.Windows.Forms]System.Windows.Forms.MessageBox::Show(string,
                                                                                                                                                         string,
                                                                                                                                                         valuetype [System.Windows.Forms]System.Windows.Forms.MessageBoxButtons,
                                                                                                                                                         valuetype [System.Windows.Forms]System.Windows.Forms.MessageBoxIcon)
      IL_014f:  pop
      IL_0150:  ldloc.3
      IL_0151:  stloc.s    CS$00000003$00000000
      IL_0153:  br         IL_02dd

      IL_0158:  ldloc.0
      IL_0159:  ldc.i4.1
      IL_015a:  add
      IL_015b:  stloc.0
      IL_015c:  ldloc.s    pArg
      IL_015e:  sizeof     acucobol.ARGUMENT_ENTRY
      IL_0164:  add
      IL_0165:  stloc.s    pArg
      IL_0167:  ldloc.0
      IL_0168:  ldloc.s    pInfoStruct
      IL_016a:  ldfld      int32 acucobol.a_cobol_info::num_params
      IL_016f:  blt.s      IL_00f9

      IL_0171:  ldarg.0
      IL_0172:  ldfld      bool acucobol.CVM::Initialized
      IL_0177:  brtrue.s   IL_0196

      IL_0179:  ldarg.0
      IL_017a:  ldnull
      IL_017b:  call       instance bool acucobol.CVM::Initialize(string)
      IL_0180:  stloc.2
      IL_0181:  ldloc.2
      IL_0182:  brtrue.s   IL_0196

      IL_0184:  ldarg.0
      IL_0185:  ldloc.s    pInfoStruct
      IL_0187:  call       instance valuetype acucobol.errorTypes acucobol.CVM::FreeInfo(valuetype acucobol.a_cobol_info*)
      IL_018c:  pop
      IL_018d:  ldc.i4.s   -3
      IL_018f:  stloc.s    CS$00000003$00000000
      IL_0191:  br         IL_02dd

      IL_0196:  ldloc.s    pInfoStruct
      IL_0198:  call       int32 acucobol.CVM::acu_cobol(valuetype acucobol.a_cobol_info*)
      IL_019d:  stloc.1
      IL_019e:  ldloc.1
      IL_019f:  brtrue.s   IL_01ab

      IL_01a1:  ldarg.s    ProgramReturnCode
      IL_01a3:  ldloc.s    pInfoStruct
      IL_01a5:  ldfld      int32 acucobol.a_cobol_info::cobol_return_code
      IL_01aa:  stind.i4
      IL_01ab:  ldloc.1
      IL_01ac:  brfalse.s  IL_0225

      IL_01ae:  ldc.i4.s   66
      IL_01b0:  stloc.3
      IL_01b1:  ldarg.0
      IL_01b2:  ldloc.s    pInfoStruct
      IL_01b4:  ldfld      unsigned int8* acucobol.a_cobol_info::p_exit_msg
      IL_01b9:  call       native int [mscorlib]System.IntPtr::op_Explicit(void*)
      IL_01be:  call       string [mscorlib]System.Runtime.InteropServices.Marshal::PtrToStringAnsi(native int)
      IL_01c3:  stfld      string acucobol.CVM::error_msg
      IL_01c8:  ldarg.0
      IL_01c9:  ldfld      bool acucobol.CVM::propShowError
      IL_01ce:  brfalse.s  IL_01e4

      IL_01d0:  ldarg.0
      IL_01d1:  ldfld      string acucobol.CVM::error_msg
      IL_01d6:  ldstr      "WRUNNET"
      IL_01db:  ldc.i4.0
      IL_01dc:  ldc.i4.s   16
      IL_01de:  call       valuetype [System.Windows.Forms]System.Windows.Forms.DialogResult [System.Windows.Forms]System.Windows.Forms.MessageBox::Show(string,
                                                                                                                                                         string,
                                                                                                                                                         valuetype [System.Windows.Forms]System.Windows.Forms.MessageBoxButtons,
                                                                                                                                                         valuetype [System.Windows.Forms]System.Windows.Forms.MessageBoxIcon)
      IL_01e3:  pop
      IL_01e4:  ldloc.s    pInfoStruct
      IL_01e6:  ldfld      int32 acucobol.a_cobol_info::exit_code
      IL_01eb:  ldc.i4.4
      IL_01ec:  bne.un.s   IL_01f8

      IL_01ee:  ldloc.s    pInfoStruct
      IL_01f0:  ldfld      valuetype acucobol.errorTypes acucobol.a_cobol_info::call_error
      IL_01f5:  stloc.3
      IL_01f6:  br.s       IL_0214

      IL_01f8:  ldloc.s    pInfoStruct
      IL_01fa:  ldfld      int32 acucobol.a_cobol_info::exit_code
      IL_01ff:  ldc.i4.5
      IL_0200:  bne.un.s   IL_0207

      IL_0202:  ldc.i4.s   65
      IL_0204:  stloc.3
      IL_0205:  br.s       IL_0214

      IL_0207:  ldloc.s    pInfoStruct
      IL_0209:  ldfld      int32 acucobol.a_cobol_info::exit_code
      IL_020e:  ldc.i4.6
      IL_020f:  bne.un.s   IL_0214

      IL_0211:  ldc.i4.s   66
      IL_0213:  stloc.3
      IL_0214:  ldarg.0
      IL_0215:  ldloc.s    pInfoStruct
      IL_0217:  call       instance valuetype acucobol.errorTypes acucobol.CVM::FreeInfo(valuetype acucobol.a_cobol_info*)
      IL_021c:  pop
      IL_021d:  ldloc.3
      IL_021e:  stloc.s    CS$00000003$00000000
      IL_0220:  br         IL_02dd

      IL_0225:  ldloc.s    pInfoStruct
      IL_0227:  ldfld      int32 acucobol.a_cobol_info::num_params
      IL_022c:  brtrue.s   IL_0236

      IL_022e:  ldc.i4.0
      IL_022f:  stloc.s    CS$00000003$00000000
      IL_0231:  br         IL_02dd

      IL_0236:  ldloc.s    pInfoStruct
      IL_0238:  ldfld      valuetype acucobol.ARGUMENT_ENTRY* acucobol.a_cobol_info::p_params
      IL_023d:  stloc.s    pArg
      IL_023f:  ldc.i4.0
      IL_0240:  stloc.0
      IL_0241:  br.s       IL_02b2

      IL_0243:  ldarg.3
      IL_0244:  ldind.ref
      IL_0245:  brfalse.s  IL_024f

      IL_0247:  ldarg.3
      IL_0248:  ldind.ref
      IL_0249:  ldloc.0
      IL_024a:  ldelem.u1
      IL_024b:  stloc.s    cblType
      IL_024d:  br.s       IL_0256

      IL_024f:  ldc.i4     0xff
      IL_0254:  stloc.s    cblType
      IL_0256:  ldarg.0
      IL_0257:  ldloc.s    pArg
      IL_0259:  ldarg.2
      IL_025a:  ldind.ref
      IL_025b:  ldloc.0
      IL_025c:  ldelema    [mscorlib]System.Object
      IL_0261:  ldloc.s    cblType
      IL_0263:  ldloc.s    enc
      IL_0265:  call       instance valuetype acucobol.errorTypes acucobol.CVM::TranslateFromCobolType(valuetype acucobol.ARGUMENT_ENTRY*,
                                                                                                       object&,
                                                                                                       valuetype acucobol.compilerTypes,
                                                                                                       class [mscorlib]System.Text.Encoding)
      IL_026a:  stloc.3
      IL_026b:  ldloc.3
      IL_026c:  brfalse.s  IL_02a3

      IL_026e:  ldarg.0
      IL_026f:  ldloc.s    pInfoStruct
      IL_0271:  call       instance valuetype acucobol.errorTypes acucobol.CVM::FreeInfo(valuetype acucobol.a_cobol_info*)
      IL_0276:  pop
      IL_0277:  ldarg.0
      IL_0278:  ldstr      "Unsupported COBOL Parameter"
      IL_027d:  stfld      string acucobol.CVM::error_msg
      IL_0282:  ldarg.0
      IL_0283:  ldfld      bool acucobol.CVM::propShowError
      IL_0288:  brfalse.s  IL_029e

      IL_028a:  ldarg.0
      IL_028b:  ldfld      string acucobol.CVM::error_msg
      IL_0290:  ldstr      "WRUNNET"
      IL_0295:  ldc.i4.0
      IL_0296:  ldc.i4.s   16
      IL_0298:  call       valuetype [System.Windows.Forms]System.Windows.Forms.DialogResult [System.Windows.Forms]System.Windows.Forms.MessageBox::Show(string,
                                                                                                                                                         string,
                                                                                                                                                         valuetype [System.Windows.Forms]System.Windows.Forms.MessageBoxButtons,
                                                                                                                                                         valuetype [System.Windows.Forms]System.Windows.Forms.MessageBoxIcon)
      IL_029d:  pop
      IL_029e:  ldloc.3
      IL_029f:  stloc.s    CS$00000003$00000000
      IL_02a1:  br.s       IL_02dd

      IL_02a3:  ldloc.0
      IL_02a4:  ldc.i4.1
      IL_02a5:  add
      IL_02a6:  stloc.0
      IL_02a7:  ldloc.s    pArg
      IL_02a9:  sizeof     acucobol.ARGUMENT_ENTRY
      IL_02af:  add
      IL_02b0:  stloc.s    pArg
      IL_02b2:  ldloc.0
      IL_02b3:  ldloc.s    pInfoStruct
      IL_02b5:  ldfld      int32 acucobol.a_cobol_info::num_params
      IL_02ba:  blt.s      IL_0243

      IL_02bc:  ldarg.0
      IL_02bd:  ldfld      string acucobol.CVM::oldRuntimePath
      IL_02c2:  brfalse.s  IL_02cf

      IL_02c4:  ldarg.0
      IL_02c5:  ldfld      string acucobol.CVM::oldRuntimePath
      IL_02ca:  call       void [mscorlib]System.IO.Directory::SetCurrentDirectory(string)
      IL_02cf:  ldarg.0
      IL_02d0:  ldloc.s    pInfoStruct
      IL_02d2:  call       instance valuetype acucobol.errorTypes acucobol.CVM::FreeInfo(valuetype acucobol.a_cobol_info*)
      IL_02d7:  pop
      IL_02d8:  ldc.i4.0
      IL_02d9:  stloc.s    CS$00000003$00000000
      IL_02db:  br.s       IL_02dd

      IL_02dd:  ldloc.s    CS$00000003$00000000
      IL_02df:  ret
    } // end of method CVM::Call

    .method public hidebysig instance bool 
            CancelProgram(string name) cil managed
    {
      // Code size       35 (0x23)
      .maxstack  1
      .locals ([0] char* pName,
               [1] bool CS$00000003$00000000)
      IL_0000:  ldarg.1
      IL_0001:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::StringToCoTaskMemAnsi(string)
      IL_0006:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_000b:  stloc.0
      IL_000c:  ldloc.0
      IL_000d:  call       void acucobol.CVM::acu_cancel(char*)
      IL_0012:  ldloc.0
      IL_0013:  call       native int [mscorlib]System.IntPtr::op_Explicit(void*)
      IL_0018:  call       void [mscorlib]System.Runtime.InteropServices.Marshal::FreeCoTaskMem(native int)
      IL_001d:  ldc.i4.1
      IL_001e:  stloc.1
      IL_001f:  br.s       IL_0021

      IL_0021:  ldloc.1
      IL_0022:  ret
    } // end of method CVM::CancelProgram

    .method public hidebysig instance bool 
            CancelAllPrograms() cil managed
    {
      // Code size       11 (0xb)
      .maxstack  1
      .locals ([0] bool CS$00000003$00000000)
      IL_0000:  call       void acucobol.CVM::acu_cancel_all()
      IL_0005:  ldc.i4.1
      IL_0006:  stloc.0
      IL_0007:  br.s       IL_0009

      IL_0009:  ldloc.0
      IL_000a:  ret
    } // end of method CVM::CancelAllPrograms

    .method public hidebysig instance bool 
            UnloadProgram(string name,
                          bool subprograms) cil managed
    {
      // Code size       43 (0x2b)
      .maxstack  2
      .locals ([0] char* pName,
               [1] int32 isub,
               [2] bool CS$00000003$00000000)
      IL_0000:  ldc.i4.0
      IL_0001:  stloc.1
      IL_0002:  ldarg.2
      IL_0003:  brfalse.s  IL_0007

      IL_0005:  ldc.i4.1
      IL_0006:  stloc.1
      IL_0007:  ldarg.1
      IL_0008:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::StringToCoTaskMemAnsi(string)
      IL_000d:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_0012:  stloc.0
      IL_0013:  ldloc.0
      IL_0014:  ldloc.1
      IL_0015:  call       void acucobol.CVM::acu_unload(char*,
                                                         int32)
      IL_001a:  ldloc.0
      IL_001b:  call       native int [mscorlib]System.IntPtr::op_Explicit(void*)
      IL_0020:  call       void [mscorlib]System.Runtime.InteropServices.Marshal::FreeCoTaskMem(native int)
      IL_0025:  ldc.i4.1
      IL_0026:  stloc.2
      IL_0027:  br.s       IL_0029

      IL_0029:  ldloc.2
      IL_002a:  ret
    } // end of method CVM::UnloadProgram

    .method public hidebysig instance bool 
            UnloadAllPrograms() cil managed
    {
      // Code size       11 (0xb)
      .maxstack  1
      .locals ([0] bool CS$00000003$00000000)
      IL_0000:  call       void acucobol.CVM::acu_unload_all()
      IL_0005:  ldc.i4.1
      IL_0006:  stloc.0
      IL_0007:  br.s       IL_0009

      IL_0009:  ldloc.0
      IL_000a:  ret
    } // end of method CVM::UnloadAllPrograms

    .method private hidebysig instance valuetype acucobol.errorTypes 
            TranslateFromCobolType(valuetype acucobol.ARGUMENT_ENTRY* pArg,
                                   object& CobolParam,
                                   valuetype acucobol.compilerTypes cblType,
                                   class [mscorlib]System.Text.Encoding enc) cil managed
    {
      // Code size       618 (0x26a)
      .maxstack  5
      .locals ([0] class [mscorlib]System.Type objType,
               [1] valuetype [mscorlib]System.TypeCode objTypeCode,
               [2] unsigned int8[] theBytes,
               [3] unsigned int8* pByte,
               [4] int32 j,
               [5] char[] theChars,
               [6] class [mscorlib]System.Text.StringBuilder buf,
               [7] valuetype acucobol.errorTypes CS$00000003$00000000,
               [8] valuetype [mscorlib]System.TypeCode CS$00000002$00000001,
               [9] unsigned int8 CS$00000002$00000002)
      IL_0000:  ldarg.2
      IL_0001:  ldind.ref
      IL_0002:  callvirt   instance class [mscorlib]System.Type [mscorlib]System.Object::GetType()
      IL_0007:  stloc.0
      IL_0008:  ldloc.0
      IL_0009:  call       valuetype [mscorlib]System.TypeCode [mscorlib]System.Type::GetTypeCode(class [mscorlib]System.Type)
      IL_000e:  stloc.1
      IL_000f:  ldloc.1
      IL_0010:  stloc.s    CS$00000002$00000001
      IL_0012:  ldloc.s    CS$00000002$00000001
      IL_0014:  switch     ( 
                            IL_0118,
                            IL_025c,
                            IL_025c,
                            IL_006a,
                            IL_009d,
                            IL_007d,
                            IL_007d,
                            IL_011d,
                            IL_015e,
                            IL_011d,
                            IL_015e,
                            IL_011d,
                            IL_015e,
                            IL_00ee,
                            IL_00ee,
                            IL_025c,
                            IL_025c,
                            IL_025c,
                            IL_019f)
      IL_0065:  br         IL_025c

      IL_006a:  ldarg.2
      IL_006b:  ldarg.1
      IL_006c:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0071:  ldind.i1
      IL_0072:  box        [mscorlib]System.Boolean
      IL_0077:  stind.ref
      IL_0078:  br         IL_0262

      IL_007d:  ldarg.2
      IL_007e:  ldarg.1
      IL_007f:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0084:  ldarg.2
      IL_0085:  ldind.ref
      IL_0086:  unbox      [mscorlib]System.Byte
      IL_008b:  ldind.u1
      IL_008c:  dup
      IL_008d:  stloc.s    CS$00000002$00000002
      IL_008f:  stind.i1
      IL_0090:  ldloc.s    CS$00000002$00000002
      IL_0092:  box        [mscorlib]System.Byte
      IL_0097:  stind.ref
      IL_0098:  br         IL_0262

      IL_009d:  ldarg.0
      IL_009e:  ldfld      bool acucobol.CVM::propUniCode
      IL_00a3:  brtrue.s   IL_00cb

      IL_00a5:  ldarg.0
      IL_00a6:  ldfld      bool acucobol.CVM::propWide
      IL_00ab:  brtrue.s   IL_00cb

      IL_00ad:  ldarg.3
      IL_00ae:  ldc.i4.s   32
      IL_00b0:  beq.s      IL_00cb

      IL_00b2:  ldarg.3
      IL_00b3:  ldc.i4.s   35
      IL_00b5:  beq.s      IL_00cb

      IL_00b7:  ldarg.3
      IL_00b8:  ldc.i4.s   37
      IL_00ba:  beq.s      IL_00cb

      IL_00bc:  ldarg.3
      IL_00bd:  ldc.i4.s   34
      IL_00bf:  beq.s      IL_00cb

      IL_00c1:  ldarg.3
      IL_00c2:  ldc.i4.s   33
      IL_00c4:  beq.s      IL_00cb

      IL_00c6:  ldarg.3
      IL_00c7:  ldc.i4.s   36
      IL_00c9:  bne.un.s   IL_00db

      IL_00cb:  ldarg.2
      IL_00cc:  ldarg.1
      IL_00cd:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_00d2:  ldind.i2
      IL_00d3:  box        [mscorlib]System.Int16
      IL_00d8:  stind.ref
      IL_00d9:  br.s       IL_00e9

      IL_00db:  ldarg.2
      IL_00dc:  ldarg.1
      IL_00dd:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_00e2:  ldind.u1
      IL_00e3:  box        [mscorlib]System.Byte
      IL_00e8:  stind.ref
      IL_00e9:  br         IL_0262

      IL_00ee:  ldloc.1
      IL_00ef:  ldc.i4.s   13
      IL_00f1:  bne.un.s   IL_0104

      IL_00f3:  ldarg.2
      IL_00f4:  ldarg.1
      IL_00f5:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_00fa:  ldind.r4
      IL_00fb:  conv.r4
      IL_00fc:  box        [mscorlib]System.Single
      IL_0101:  stind.ref
      IL_0102:  br.s       IL_0113

      IL_0104:  ldarg.2
      IL_0105:  ldarg.1
      IL_0106:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_010b:  ldind.r8
      IL_010c:  conv.r8
      IL_010d:  box        [mscorlib]System.Double
      IL_0112:  stind.ref
      IL_0113:  br         IL_0262

      IL_0118:  br         IL_0262

      IL_011d:  ldloc.1
      IL_011e:  ldc.i4.s   11
      IL_0120:  bne.un.s   IL_0132

      IL_0122:  ldarg.2
      IL_0123:  ldarg.1
      IL_0124:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0129:  ldind.i8
      IL_012a:  box        [mscorlib]System.Int64
      IL_012f:  stind.ref
      IL_0130:  br.s       IL_0159

      IL_0132:  ldloc.1
      IL_0133:  ldc.i4.7
      IL_0134:  bne.un.s   IL_0146

      IL_0136:  ldarg.2
      IL_0137:  ldarg.1
      IL_0138:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_013d:  ldind.i2
      IL_013e:  box        [mscorlib]System.Int16
      IL_0143:  stind.ref
      IL_0144:  br.s       IL_0159

      IL_0146:  ldloc.1
      IL_0147:  ldc.i4.s   9
      IL_0149:  bne.un.s   IL_0159

      IL_014b:  ldarg.2
      IL_014c:  ldarg.1
      IL_014d:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0152:  ldind.i4
      IL_0153:  box        [mscorlib]System.Int32
      IL_0158:  stind.ref
      IL_0159:  br         IL_0262

      IL_015e:  ldloc.1
      IL_015f:  ldc.i4.s   11
      IL_0161:  bne.un.s   IL_0173

      IL_0163:  ldarg.2
      IL_0164:  ldarg.1
      IL_0165:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_016a:  ldind.i8
      IL_016b:  box        [mscorlib]System.UInt64
      IL_0170:  stind.ref
      IL_0171:  br.s       IL_019a

      IL_0173:  ldloc.1
      IL_0174:  ldc.i4.7
      IL_0175:  bne.un.s   IL_0187

      IL_0177:  ldarg.2
      IL_0178:  ldarg.1
      IL_0179:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_017e:  ldind.u2
      IL_017f:  box        [mscorlib]System.UInt16
      IL_0184:  stind.ref
      IL_0185:  br.s       IL_019a

      IL_0187:  ldloc.1
      IL_0188:  ldc.i4.s   9
      IL_018a:  bne.un.s   IL_019a

      IL_018c:  ldarg.2
      IL_018d:  ldarg.1
      IL_018e:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0193:  ldind.u4
      IL_0194:  box        [mscorlib]System.UInt32
      IL_0199:  stind.ref
      IL_019a:  br         IL_0262

      IL_019f:  ldarg.0
      IL_01a0:  ldfld      bool acucobol.CVM::propUniCode
      IL_01a5:  brtrue.s   IL_01b6

      IL_01a7:  ldarg.3
      IL_01a8:  ldc.i4.s   32
      IL_01aa:  beq.s      IL_01b6

      IL_01ac:  ldarg.3
      IL_01ad:  ldc.i4.s   34
      IL_01af:  beq.s      IL_01b6

      IL_01b1:  ldarg.3
      IL_01b2:  ldc.i4.s   33
      IL_01b4:  bne.un.s   IL_01d3

      IL_01b6:  ldarg.2
      IL_01b7:  ldarg.1
      IL_01b8:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_01bd:  call       native int [mscorlib]System.IntPtr::op_Explicit(void*)
      IL_01c2:  ldarg.1
      IL_01c3:  ldfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_01c8:  call       string [mscorlib]System.Runtime.InteropServices.Marshal::PtrToStringUni(native int,
                                                                                                   int32)
      IL_01cd:  stind.ref
      IL_01ce:  br         IL_025a

      IL_01d3:  ldarg.0
      IL_01d4:  ldfld      bool acucobol.CVM::propWide
      IL_01d9:  brtrue.s   IL_01ea

      IL_01db:  ldarg.3
      IL_01dc:  ldc.i4.s   35
      IL_01de:  beq.s      IL_01ea

      IL_01e0:  ldarg.3
      IL_01e1:  ldc.i4.s   37
      IL_01e3:  beq.s      IL_01ea

      IL_01e5:  ldarg.3
      IL_01e6:  ldc.i4.s   36
      IL_01e8:  bne.un.s   IL_0242

      IL_01ea:  ldarg.1
      IL_01eb:  ldfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_01f0:  newarr     [mscorlib]System.Byte
      IL_01f5:  stloc.2
      IL_01f6:  ldarg.1
      IL_01f7:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_01fc:  stloc.3
      IL_01fd:  ldc.i4.0
      IL_01fe:  stloc.s    j
      IL_0200:  br.s       IL_0212

      IL_0202:  ldloc.2
      IL_0203:  ldloc.s    j
      IL_0205:  ldloc.3
      IL_0206:  dup
      IL_0207:  ldc.i4.1
      IL_0208:  add
      IL_0209:  stloc.3
      IL_020a:  ldind.u1
      IL_020b:  stelem.i1
      IL_020c:  ldloc.s    j
      IL_020e:  ldc.i4.1
      IL_020f:  add
      IL_0210:  stloc.s    j
      IL_0212:  ldloc.s    j
      IL_0214:  ldloc.2
      IL_0215:  ldlen
      IL_0216:  conv.i4
      IL_0217:  blt.s      IL_0202

      IL_0219:  ldarg.s    enc
      IL_021b:  ldloc.2
      IL_021c:  callvirt   instance char[] [mscorlib]System.Text.Encoding::GetChars(unsigned int8[])
      IL_0221:  stloc.s    theChars
      IL_0223:  ldloc.2
      IL_0224:  ldlen
      IL_0225:  conv.i4
      IL_0226:  newobj     instance void [mscorlib]System.Text.StringBuilder::.ctor(int32)
      IL_022b:  stloc.s    buf
      IL_022d:  ldloc.s    buf
      IL_022f:  ldloc.s    theChars
      IL_0231:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(char[])
      IL_0236:  pop
      IL_0237:  ldarg.2
      IL_0238:  ldloc.s    buf
      IL_023a:  callvirt   instance string [mscorlib]System.Text.StringBuilder::ToString()
      IL_023f:  stind.ref
      IL_0240:  br.s       IL_025a

      IL_0242:  ldarg.2
      IL_0243:  ldarg.1
      IL_0244:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0249:  call       native int [mscorlib]System.IntPtr::op_Explicit(void*)
      IL_024e:  ldarg.1
      IL_024f:  ldfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0254:  call       string [mscorlib]System.Runtime.InteropServices.Marshal::PtrToStringAnsi(native int,
                                                                                                    int32)
      IL_0259:  stind.ref
      IL_025a:  br.s       IL_0262

      IL_025c:  ldc.i4.s   31
      IL_025e:  stloc.s    CS$00000003$00000000
      IL_0260:  br.s       IL_0267

      IL_0262:  ldc.i4.0
      IL_0263:  stloc.s    CS$00000003$00000000
      IL_0265:  br.s       IL_0267

      IL_0267:  ldloc.s    CS$00000003$00000000
      IL_0269:  ret
    } // end of method CVM::TranslateFromCobolType

    .method private hidebysig instance valuetype acucobol.errorTypes 
            TranslateToCobolType(valuetype acucobol.ARGUMENT_ENTRY* pArg,
                                 object CobolParam,
                                 valuetype acucobol.compilerTypes cblType,
                                 class [mscorlib]System.Text.Encoding enc) cil managed
    {
      // Code size       1121 (0x461)
      .maxstack  3
      .locals ([0] class [mscorlib]System.Type objType,
               [1] valuetype [mscorlib]System.TypeCode objTypeCode,
               [2] unsigned int8* pByte,
               [3] unsigned int8[] theBytes,
               [4] int32 j,
               [5] valuetype acucobol.errorTypes CS$00000003$00000000,
               [6] valuetype [mscorlib]System.TypeCode CS$00000002$00000001)
      IL_0000:  ldarg.2
      IL_0001:  callvirt   instance class [mscorlib]System.Type [mscorlib]System.Object::GetType()
      IL_0006:  stloc.0
      IL_0007:  ldloc.0
      IL_0008:  call       valuetype [mscorlib]System.TypeCode [mscorlib]System.Type::GetTypeCode(class [mscorlib]System.Type)
      IL_000d:  stloc.1
      IL_000e:  ldloc.1
      IL_000f:  stloc.s    CS$00000002$00000001
      IL_0011:  ldloc.s    CS$00000002$00000001
      IL_0013:  switch     ( 
                            IL_020e,
                            IL_0453,
                            IL_0453,
                            IL_0069,
                            IL_00fb,
                            IL_00b2,
                            IL_00b2,
                            IL_0257,
                            IL_02ee,
                            IL_0257,
                            IL_02ee,
                            IL_0257,
                            IL_02ee,
                            IL_019a,
                            IL_019a,
                            IL_0453,
                            IL_0453,
                            IL_0453,
                            IL_037e)
      IL_0064:  br         IL_0453

      IL_0069:  ldarg.1
      IL_006a:  ldc.i4.4
      IL_006b:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0070:  ldarg.1
      IL_0071:  ldc.i4.4
      IL_0072:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::AllocCoTaskMem(int32)
      IL_0077:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_007c:  stfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0081:  ldarg.1
      IL_0082:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0087:  ldarg.2
      IL_0088:  unbox      [mscorlib]System.UInt32
      IL_008d:  ldind.u4
      IL_008e:  stind.i4
      IL_008f:  ldarg.1
      IL_0090:  ldc.i4.0
      IL_0091:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_digits
      IL_0096:  ldarg.1
      IL_0097:  ldc.i4.0
      IL_0098:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_scale
      IL_009d:  ldarg.1
      IL_009e:  ldc.i4.0
      IL_009f:  conv.u
      IL_00a0:  stfld      void* acucobol.ARGUMENT_ENTRY::p_a_picture
      IL_00a5:  ldarg.1
      IL_00a6:  ldc.i4.s   14
      IL_00a8:  stfld      valuetype acucobol.cobolTypes acucobol.ARGUMENT_ENTRY::a_type
      IL_00ad:  br         IL_0459

      IL_00b2:  ldarg.1
      IL_00b3:  ldc.i4.1
      IL_00b4:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_00b9:  ldarg.1
      IL_00ba:  ldc.i4.1
      IL_00bb:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::AllocCoTaskMem(int32)
      IL_00c0:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_00c5:  stfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_00ca:  ldarg.1
      IL_00cb:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_00d0:  ldarg.2
      IL_00d1:  unbox      [mscorlib]System.Byte
      IL_00d6:  ldind.u1
      IL_00d7:  stind.i1
      IL_00d8:  ldarg.1
      IL_00d9:  ldc.i4.0
      IL_00da:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_digits
      IL_00df:  ldarg.1
      IL_00e0:  ldc.i4.0
      IL_00e1:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_scale
      IL_00e6:  ldarg.1
      IL_00e7:  ldc.i4.0
      IL_00e8:  conv.u
      IL_00e9:  stfld      void* acucobol.ARGUMENT_ENTRY::p_a_picture
      IL_00ee:  ldarg.1
      IL_00ef:  ldc.i4.s   16
      IL_00f1:  stfld      valuetype acucobol.cobolTypes acucobol.ARGUMENT_ENTRY::a_type
      IL_00f6:  br         IL_0459

      IL_00fb:  ldarg.0
      IL_00fc:  ldfld      bool acucobol.CVM::propUniCode
      IL_0101:  brtrue.s   IL_0129

      IL_0103:  ldarg.0
      IL_0104:  ldfld      bool acucobol.CVM::propWide
      IL_0109:  brtrue.s   IL_0129

      IL_010b:  ldarg.3
      IL_010c:  ldc.i4.s   32
      IL_010e:  beq.s      IL_0129

      IL_0110:  ldarg.3
      IL_0111:  ldc.i4.s   35
      IL_0113:  beq.s      IL_0129

      IL_0115:  ldarg.3
      IL_0116:  ldc.i4.s   37
      IL_0118:  beq.s      IL_0129

      IL_011a:  ldarg.3
      IL_011b:  ldc.i4.s   34
      IL_011d:  beq.s      IL_0129

      IL_011f:  ldarg.3
      IL_0120:  ldc.i4.s   33
      IL_0122:  beq.s      IL_0129

      IL_0124:  ldarg.3
      IL_0125:  ldc.i4.s   36
      IL_0127:  bne.un.s   IL_0151

      IL_0129:  ldarg.1
      IL_012a:  ldc.i4.2
      IL_012b:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0130:  ldarg.1
      IL_0131:  ldc.i4.2
      IL_0132:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::AllocCoTaskMem(int32)
      IL_0137:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_013c:  stfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0141:  ldarg.1
      IL_0142:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0147:  ldarg.2
      IL_0148:  unbox      [mscorlib]System.Int16
      IL_014d:  ldind.i2
      IL_014e:  stind.i2
      IL_014f:  br.s       IL_0177

      IL_0151:  ldarg.1
      IL_0152:  ldc.i4.1
      IL_0153:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0158:  ldarg.1
      IL_0159:  ldc.i4.1
      IL_015a:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::AllocCoTaskMem(int32)
      IL_015f:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_0164:  stfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0169:  ldarg.1
      IL_016a:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_016f:  ldarg.2
      IL_0170:  unbox      [mscorlib]System.Byte
      IL_0175:  ldind.u1
      IL_0176:  stind.i1
      IL_0177:  ldarg.1
      IL_0178:  ldc.i4.0
      IL_0179:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_digits
      IL_017e:  ldarg.1
      IL_017f:  ldc.i4.0
      IL_0180:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_scale
      IL_0185:  ldarg.1
      IL_0186:  ldc.i4.0
      IL_0187:  conv.u
      IL_0188:  stfld      void* acucobol.ARGUMENT_ENTRY::p_a_picture
      IL_018d:  ldarg.1
      IL_018e:  ldc.i4.s   16
      IL_0190:  stfld      valuetype acucobol.cobolTypes acucobol.ARGUMENT_ENTRY::a_type
      IL_0195:  br         IL_0459

      IL_019a:  ldloc.1
      IL_019b:  ldc.i4.s   14
      IL_019d:  bne.un.s   IL_01a6

      IL_019f:  ldarg.1
      IL_01a0:  ldc.i4.8
      IL_01a1:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_01a6:  ldloc.1
      IL_01a7:  ldc.i4.s   13
      IL_01a9:  bne.un.s   IL_01b2

      IL_01ab:  ldarg.1
      IL_01ac:  ldc.i4.4
      IL_01ad:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_01b2:  ldarg.1
      IL_01b3:  ldarg.1
      IL_01b4:  ldfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_01b9:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::AllocCoTaskMem(int32)
      IL_01be:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_01c3:  stfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_01c8:  ldloc.1
      IL_01c9:  ldc.i4.s   13
      IL_01cb:  bne.un.s   IL_01dd

      IL_01cd:  ldarg.1
      IL_01ce:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_01d3:  ldarg.2
      IL_01d4:  unbox      [mscorlib]System.Single
      IL_01d9:  ldind.r4
      IL_01da:  stind.r4
      IL_01db:  br.s       IL_01eb

      IL_01dd:  ldarg.1
      IL_01de:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_01e3:  ldarg.2
      IL_01e4:  unbox      [mscorlib]System.Double
      IL_01e9:  ldind.r8
      IL_01ea:  stind.r8
      IL_01eb:  ldarg.1
      IL_01ec:  ldc.i4.0
      IL_01ed:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_digits
      IL_01f2:  ldarg.1
      IL_01f3:  ldc.i4.0
      IL_01f4:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_scale
      IL_01f9:  ldarg.1
      IL_01fa:  ldc.i4.0
      IL_01fb:  conv.u
      IL_01fc:  stfld      void* acucobol.ARGUMENT_ENTRY::p_a_picture
      IL_0201:  ldarg.1
      IL_0202:  ldc.i4.s   23
      IL_0204:  stfld      valuetype acucobol.cobolTypes acucobol.ARGUMENT_ENTRY::a_type
      IL_0209:  br         IL_0459

      IL_020e:  ldarg.1
      IL_020f:  ldc.i4.4
      IL_0210:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0215:  ldarg.1
      IL_0216:  ldc.i4.4
      IL_0217:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::AllocCoTaskMem(int32)
      IL_021c:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_0221:  stfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0226:  ldarg.1
      IL_0227:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_022c:  ldarg.2
      IL_022d:  unbox      [mscorlib]System.UInt32
      IL_0232:  ldind.u4
      IL_0233:  stind.i4
      IL_0234:  ldarg.1
      IL_0235:  ldc.i4.0
      IL_0236:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_digits
      IL_023b:  ldarg.1
      IL_023c:  ldc.i4.0
      IL_023d:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_scale
      IL_0242:  ldarg.1
      IL_0243:  ldc.i4.0
      IL_0244:  conv.u
      IL_0245:  stfld      void* acucobol.ARGUMENT_ENTRY::p_a_picture
      IL_024a:  ldarg.1
      IL_024b:  ldc.i4.s   14
      IL_024d:  stfld      valuetype acucobol.cobolTypes acucobol.ARGUMENT_ENTRY::a_type
      IL_0252:  br         IL_0459

      IL_0257:  ldloc.1
      IL_0258:  ldc.i4.s   9
      IL_025a:  bne.un.s   IL_0265

      IL_025c:  ldarg.1
      IL_025d:  ldc.i4.4
      IL_025e:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0263:  br.s       IL_0279

      IL_0265:  ldloc.1
      IL_0266:  ldc.i4.7
      IL_0267:  bne.un.s   IL_0272

      IL_0269:  ldarg.1
      IL_026a:  ldc.i4.2
      IL_026b:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0270:  br.s       IL_0279

      IL_0272:  ldarg.1
      IL_0273:  ldc.i4.8
      IL_0274:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0279:  ldarg.1
      IL_027a:  ldarg.1
      IL_027b:  ldfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0280:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::AllocCoTaskMem(int32)
      IL_0285:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_028a:  stfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_028f:  ldloc.1
      IL_0290:  ldc.i4.s   11
      IL_0292:  bne.un.s   IL_02a4

      IL_0294:  ldarg.1
      IL_0295:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_029a:  ldarg.2
      IL_029b:  unbox      [mscorlib]System.Int64
      IL_02a0:  ldind.i8
      IL_02a1:  stind.i8
      IL_02a2:  br.s       IL_02cb

      IL_02a4:  ldloc.1
      IL_02a5:  ldc.i4.7
      IL_02a6:  bne.un.s   IL_02b8

      IL_02a8:  ldarg.1
      IL_02a9:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_02ae:  ldarg.2
      IL_02af:  unbox      [mscorlib]System.Int16
      IL_02b4:  ldind.i2
      IL_02b5:  stind.i2
      IL_02b6:  br.s       IL_02cb

      IL_02b8:  ldloc.1
      IL_02b9:  ldc.i4.s   9
      IL_02bb:  bne.un.s   IL_02cb

      IL_02bd:  ldarg.1
      IL_02be:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_02c3:  ldarg.2
      IL_02c4:  unbox      [mscorlib]System.Int32
      IL_02c9:  ldind.i4
      IL_02ca:  stind.i4
      IL_02cb:  ldarg.1
      IL_02cc:  ldc.i4.0
      IL_02cd:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_digits
      IL_02d2:  ldarg.1
      IL_02d3:  ldc.i4.0
      IL_02d4:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_scale
      IL_02d9:  ldarg.1
      IL_02da:  ldc.i4.0
      IL_02db:  conv.u
      IL_02dc:  stfld      void* acucobol.ARGUMENT_ENTRY::p_a_picture
      IL_02e1:  ldarg.1
      IL_02e2:  ldc.i4.s   13
      IL_02e4:  stfld      valuetype acucobol.cobolTypes acucobol.ARGUMENT_ENTRY::a_type
      IL_02e9:  br         IL_0459

      IL_02ee:  ldloc.1
      IL_02ef:  ldc.i4.s   10
      IL_02f1:  bne.un.s   IL_02fc

      IL_02f3:  ldarg.1
      IL_02f4:  ldc.i4.4
      IL_02f5:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_02fa:  br.s       IL_0310

      IL_02fc:  ldloc.1
      IL_02fd:  ldc.i4.8
      IL_02fe:  bne.un.s   IL_0309

      IL_0300:  ldarg.1
      IL_0301:  ldc.i4.2
      IL_0302:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0307:  br.s       IL_0310

      IL_0309:  ldarg.1
      IL_030a:  ldc.i4.8
      IL_030b:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0310:  ldarg.1
      IL_0311:  ldarg.1
      IL_0312:  ldfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0317:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::AllocCoTaskMem(int32)
      IL_031c:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_0321:  stfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0326:  ldloc.1
      IL_0327:  ldc.i4.s   12
      IL_0329:  bne.un.s   IL_033b

      IL_032b:  ldarg.1
      IL_032c:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0331:  ldarg.2
      IL_0332:  unbox      [mscorlib]System.UInt64
      IL_0337:  ldind.i8
      IL_0338:  stind.i8
      IL_0339:  br.s       IL_0362

      IL_033b:  ldloc.1
      IL_033c:  ldc.i4.8
      IL_033d:  bne.un.s   IL_034f

      IL_033f:  ldarg.1
      IL_0340:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0345:  ldarg.2
      IL_0346:  unbox      [mscorlib]System.UInt16
      IL_034b:  ldind.u2
      IL_034c:  stind.i2
      IL_034d:  br.s       IL_0362

      IL_034f:  ldloc.1
      IL_0350:  ldc.i4.s   10
      IL_0352:  bne.un.s   IL_0362

      IL_0354:  ldarg.1
      IL_0355:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_035a:  ldarg.2
      IL_035b:  unbox      [mscorlib]System.UInt32
      IL_0360:  ldind.u4
      IL_0361:  stind.i4
      IL_0362:  ldarg.1
      IL_0363:  ldc.i4.0
      IL_0364:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_scale
      IL_0369:  ldarg.1
      IL_036a:  ldc.i4.0
      IL_036b:  conv.u
      IL_036c:  stfld      void* acucobol.ARGUMENT_ENTRY::p_a_picture
      IL_0371:  ldarg.1
      IL_0372:  ldc.i4.s   14
      IL_0374:  stfld      valuetype acucobol.cobolTypes acucobol.ARGUMENT_ENTRY::a_type
      IL_0379:  br         IL_0459

      IL_037e:  ldarg.0
      IL_037f:  ldfld      bool acucobol.CVM::propUniCode
      IL_0384:  brtrue.s   IL_03ac

      IL_0386:  ldarg.0
      IL_0387:  ldfld      bool acucobol.CVM::propWide
      IL_038c:  brtrue.s   IL_03ac

      IL_038e:  ldarg.3
      IL_038f:  ldc.i4.s   32
      IL_0391:  beq.s      IL_03ac

      IL_0393:  ldarg.3
      IL_0394:  ldc.i4.s   35
      IL_0396:  beq.s      IL_03ac

      IL_0398:  ldarg.3
      IL_0399:  ldc.i4.s   37
      IL_039b:  beq.s      IL_03ac

      IL_039d:  ldarg.3
      IL_039e:  ldc.i4.s   34
      IL_03a0:  beq.s      IL_03ac

      IL_03a2:  ldarg.3
      IL_03a3:  ldc.i4.s   33
      IL_03a5:  beq.s      IL_03ac

      IL_03a7:  ldarg.3
      IL_03a8:  ldc.i4.s   36
      IL_03aa:  bne.un.s   IL_040c

      IL_03ac:  ldarg.1
      IL_03ad:  ldarg.2
      IL_03ae:  castclass  [mscorlib]System.String
      IL_03b3:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::StringToCoTaskMemUni(string)
      IL_03b8:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_03bd:  stfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_03c2:  ldarg.0
      IL_03c3:  ldfld      bool acucobol.CVM::propWide
      IL_03c8:  brtrue.s   IL_03d9

      IL_03ca:  ldarg.3
      IL_03cb:  ldc.i4.s   35
      IL_03cd:  beq.s      IL_03d9

      IL_03cf:  ldarg.3
      IL_03d0:  ldc.i4.s   37
      IL_03d2:  beq.s      IL_03d9

      IL_03d4:  ldarg.3
      IL_03d5:  ldc.i4.s   36
      IL_03d7:  bne.un.s   IL_040a

      IL_03d9:  ldarg.1
      IL_03da:  ldfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_03df:  stloc.2
      IL_03e0:  ldarg.s    enc
      IL_03e2:  ldarg.2
      IL_03e3:  castclass  [mscorlib]System.String
      IL_03e8:  callvirt   instance unsigned int8[] [mscorlib]System.Text.Encoding::GetBytes(string)
      IL_03ed:  stloc.3
      IL_03ee:  ldc.i4.0
      IL_03ef:  stloc.s    j
      IL_03f1:  br.s       IL_0403

      IL_03f3:  ldloc.2
      IL_03f4:  dup
      IL_03f5:  ldc.i4.1
      IL_03f6:  add
      IL_03f7:  stloc.2
      IL_03f8:  ldloc.3
      IL_03f9:  ldloc.s    j
      IL_03fb:  ldelem.u1
      IL_03fc:  stind.i1
      IL_03fd:  ldloc.s    j
      IL_03ff:  ldc.i4.1
      IL_0400:  add
      IL_0401:  stloc.s    j
      IL_0403:  ldloc.s    j
      IL_0405:  ldloc.3
      IL_0406:  ldlen
      IL_0407:  conv.i4
      IL_0408:  blt.s      IL_03f3

      IL_040a:  br.s       IL_0422

      IL_040c:  ldarg.1
      IL_040d:  ldarg.2
      IL_040e:  castclass  [mscorlib]System.String
      IL_0413:  call       native int [mscorlib]System.Runtime.InteropServices.Marshal::StringToCoTaskMemAnsi(string)
      IL_0418:  call       void* [mscorlib]System.IntPtr::op_Explicit(native int)
      IL_041d:  stfld      void* acucobol.ARGUMENT_ENTRY::a_address
      IL_0422:  ldarg.1
      IL_0423:  ldc.i4.0
      IL_0424:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_digits
      IL_0429:  ldarg.1
      IL_042a:  ldc.i4.0
      IL_042b:  stfld      unsigned int8 acucobol.ARGUMENT_ENTRY::a_scale
      IL_0430:  ldarg.1
      IL_0431:  ldc.i4.0
      IL_0432:  conv.u
      IL_0433:  stfld      void* acucobol.ARGUMENT_ENTRY::p_a_picture
      IL_0438:  ldarg.1
      IL_0439:  ldc.i4.s   16
      IL_043b:  stfld      valuetype acucobol.cobolTypes acucobol.ARGUMENT_ENTRY::a_type
      IL_0440:  ldarg.1
      IL_0441:  ldarg.2
      IL_0442:  castclass  [mscorlib]System.String
      IL_0447:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_044c:  stfld      int32 acucobol.ARGUMENT_ENTRY::a_length
      IL_0451:  br.s       IL_0459

      IL_0453:  ldc.i4.s   31
      IL_0455:  stloc.s    CS$00000003$00000000
      IL_0457:  br.s       IL_045e

      IL_0459:  ldc.i4.0
      IL_045a:  stloc.s    CS$00000003$00000000
      IL_045c:  br.s       IL_045e

      IL_045e:  ldloc.s    CS$00000003$00000000
      IL_0460:  ret
    } // end of method CVM::TranslateToCobolType

    .method private hidebysig instance void 
            SetProperties(string param) cil managed
    {
      // Code size       1522 (0x5f2)
      .maxstack  5
      .locals ([0] int32 i,
               [1] int32 startIndex)
      IL_0000:  ldarg.1
      IL_0001:  brfalse.s  IL_000b

      IL_0003:  ldarg.1
      IL_0004:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_0009:  brtrue.s   IL_0010

      IL_000b:  br         IL_05f1

      IL_0010:  ldc.i4.0
      IL_0011:  stloc.0
      IL_0012:  ldc.i4.0
      IL_0013:  stloc.1
      IL_0014:  br         IL_05e5

      IL_0019:  ldarg.1
      IL_001a:  ldloc.1
      IL_001b:  ldstr      "-d"
      IL_0020:  ldc.i4.0
      IL_0021:  ldc.i4.2
      IL_0022:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_0027:  dup
      IL_0028:  stloc.0
      IL_0029:  brtrue.s   IL_003b

      IL_002b:  ldarg.0
      IL_002c:  ldc.i4.1
      IL_002d:  stfld      bool acucobol.CVM::propDebug
      IL_0032:  ldloc.1
      IL_0033:  ldc.i4.2
      IL_0034:  add
      IL_0035:  stloc.1
      IL_0036:  br         IL_05e5

      IL_003b:  ldarg.1
      IL_003c:  ldloc.1
      IL_003d:  ldstr      "-uni"
      IL_0042:  ldc.i4.0
      IL_0043:  ldc.i4.4
      IL_0044:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_0049:  dup
      IL_004a:  stloc.0
      IL_004b:  brtrue.s   IL_005d

      IL_004d:  ldarg.0
      IL_004e:  ldc.i4.1
      IL_004f:  stfld      bool acucobol.CVM::propUniCode
      IL_0054:  ldloc.1
      IL_0055:  ldc.i4.4
      IL_0056:  add
      IL_0057:  stloc.1
      IL_0058:  br         IL_05e5

      IL_005d:  ldarg.1
      IL_005e:  ldloc.1
      IL_005f:  ldstr      "-wide"
      IL_0064:  ldc.i4.0
      IL_0065:  ldc.i4.5
      IL_0066:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_006b:  dup
      IL_006c:  stloc.0
      IL_006d:  brtrue.s   IL_007f

      IL_006f:  ldarg.0
      IL_0070:  ldc.i4.1
      IL_0071:  stfld      bool acucobol.CVM::propWide
      IL_0076:  ldloc.1
      IL_0077:  ldc.i4.5
      IL_0078:  add
      IL_0079:  stloc.1
      IL_007a:  br         IL_05e5

      IL_007f:  ldarg.1
      IL_0080:  ldloc.1
      IL_0081:  ldstr      "-no"
      IL_0086:  ldc.i4.0
      IL_0087:  ldc.i4.3
      IL_0088:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_008d:  dup
      IL_008e:  stloc.0
      IL_008f:  brtrue.s   IL_00a1

      IL_0091:  ldarg.0
      IL_0092:  ldc.i4.1
      IL_0093:  stfld      bool acucobol.CVM::propNoStop
      IL_0098:  ldloc.1
      IL_0099:  ldc.i4.3
      IL_009a:  add
      IL_009b:  stloc.1
      IL_009c:  br         IL_05e5

      IL_00a1:  ldarg.1
      IL_00a2:  ldloc.1
      IL_00a3:  ldstr      "-cache"
      IL_00a8:  ldc.i4.0
      IL_00a9:  ldc.i4.6
      IL_00aa:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_00af:  dup
      IL_00b0:  stloc.0
      IL_00b1:  brtrue.s   IL_00c3

      IL_00b3:  ldarg.0
      IL_00b4:  ldc.i4.1
      IL_00b5:  stfld      bool acucobol.CVM::propCache
      IL_00ba:  ldloc.1
      IL_00bb:  ldc.i4.6
      IL_00bc:  add
      IL_00bd:  stloc.1
      IL_00be:  br         IL_05e5

      IL_00c3:  ldarg.1
      IL_00c4:  ldloc.1
      IL_00c5:  ldstr      "-show"
      IL_00ca:  ldc.i4.0
      IL_00cb:  ldc.i4.5
      IL_00cc:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_00d1:  dup
      IL_00d2:  stloc.0
      IL_00d3:  brtrue.s   IL_00e5

      IL_00d5:  ldarg.0
      IL_00d6:  ldc.i4.1
      IL_00d7:  stfld      bool acucobol.CVM::propShowError
      IL_00dc:  ldloc.1
      IL_00dd:  ldc.i4.5
      IL_00de:  add
      IL_00df:  stloc.1
      IL_00e0:  br         IL_05e5

      IL_00e5:  ldarg.1
      IL_00e6:  ldloc.1
      IL_00e7:  ldstr      "-b"
      IL_00ec:  ldc.i4.0
      IL_00ed:  ldc.i4.2
      IL_00ee:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_00f3:  dup
      IL_00f4:  stloc.0
      IL_00f5:  brtrue.s   IL_0107

      IL_00f7:  ldarg.0
      IL_00f8:  ldc.i4.1
      IL_00f9:  stfld      bool acucobol.CVM::propTerminalInit
      IL_00fe:  ldloc.1
      IL_00ff:  ldc.i4.2
      IL_0100:  add
      IL_0101:  stloc.1
      IL_0102:  br         IL_05e5

      IL_0107:  ldarg.1
      IL_0108:  ldloc.1
      IL_0109:  ldstr      "-f"
      IL_010e:  ldc.i4.0
      IL_010f:  ldc.i4.2
      IL_0110:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_0115:  dup
      IL_0116:  stloc.0
      IL_0117:  brtrue.s   IL_0129

      IL_0119:  ldarg.0
      IL_011a:  ldc.i4.1
      IL_011b:  stfld      bool acucobol.CVM::propCGIWarnings
      IL_0120:  ldloc.1
      IL_0121:  ldc.i4.2
      IL_0122:  add
      IL_0123:  stloc.1
      IL_0124:  br         IL_05e5

      IL_0129:  ldarg.1
      IL_012a:  ldloc.1
      IL_012b:  ldstr      "-h"
      IL_0130:  ldc.i4.0
      IL_0131:  ldc.i4.2
      IL_0132:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_0137:  dup
      IL_0138:  stloc.0
      IL_0139:  brtrue.s   IL_014b

      IL_013b:  ldarg.0
      IL_013c:  ldc.i4.1
      IL_013d:  stfld      bool acucobol.CVM::propIgnoreSignals
      IL_0142:  ldloc.1
      IL_0143:  ldc.i4.2
      IL_0144:  add
      IL_0145:  stloc.1
      IL_0146:  br         IL_05e5

      IL_014b:  ldarg.1
      IL_014c:  ldloc.1
      IL_014d:  ldstr      "-l"
      IL_0152:  ldc.i4.0
      IL_0153:  ldc.i4.2
      IL_0154:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_0159:  dup
      IL_015a:  stloc.0
      IL_015b:  brtrue.s   IL_016d

      IL_015d:  ldarg.0
      IL_015e:  ldc.i4.1
      IL_015f:  stfld      bool acucobol.CVM::propListConfig
      IL_0164:  ldloc.1
      IL_0165:  ldc.i4.2
      IL_0166:  add
      IL_0167:  stloc.1
      IL_0168:  br         IL_05e5

      IL_016d:  ldarg.1
      IL_016e:  ldloc.1
      IL_016f:  ldstr      "--no-save-debug"
      IL_0174:  ldc.i4.0
      IL_0175:  ldc.i4.s   15
      IL_0177:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_017c:  dup
      IL_017d:  stloc.0
      IL_017e:  brtrue.s   IL_0191

      IL_0180:  ldarg.0
      IL_0181:  ldc.i4.1
      IL_0182:  stfld      bool acucobol.CVM::propNoSaveDebug
      IL_0187:  ldloc.1
      IL_0188:  ldc.i4.s   15
      IL_018a:  add
      IL_018b:  stloc.1
      IL_018c:  br         IL_05e5

      IL_0191:  ldarg.1
      IL_0192:  ldloc.1
      IL_0193:  ldstr      "-s"
      IL_0198:  ldc.i4.0
      IL_0199:  ldc.i4.2
      IL_019a:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_019f:  dup
      IL_01a0:  stloc.0
      IL_01a1:  brtrue.s   IL_01b3

      IL_01a3:  ldarg.0
      IL_01a4:  ldc.i4.1
      IL_01a5:  stfld      bool acucobol.CVM::propSafeMode
      IL_01aa:  ldloc.1
      IL_01ab:  ldc.i4.2
      IL_01ac:  add
      IL_01ad:  stloc.1
      IL_01ae:  br         IL_05e5

      IL_01b3:  ldarg.1
      IL_01b4:  ldloc.1
      IL_01b5:  ldstr      "-w"
      IL_01ba:  ldc.i4.0
      IL_01bb:  ldc.i4.2
      IL_01bc:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_01c1:  dup
      IL_01c2:  stloc.0
      IL_01c3:  brtrue.s   IL_01d5

      IL_01c5:  ldarg.0
      IL_01c6:  ldc.i4.1
      IL_01c7:  stfld      bool acucobol.CVM::propNonNumeric
      IL_01cc:  ldloc.1
      IL_01cd:  ldc.i4.2
      IL_01ce:  add
      IL_01cf:  stloc.1
      IL_01d0:  br         IL_05e5

      IL_01d5:  ldarg.1
      IL_01d6:  ldloc.1
      IL_01d7:  ldstr      "-x"
      IL_01dc:  ldc.i4.0
      IL_01dd:  ldc.i4.2
      IL_01de:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_01e3:  dup
      IL_01e4:  stloc.0
      IL_01e5:  brtrue.s   IL_01f7

      IL_01e7:  ldarg.0
      IL_01e8:  ldc.i4.1
      IL_01e9:  stfld      bool acucobol.CVM::propExtendedError
      IL_01ee:  ldloc.1
      IL_01ef:  ldc.i4.2
      IL_01f0:  add
      IL_01f1:  stloc.1
      IL_01f2:  br         IL_05e5

      IL_01f7:  ldarg.1
      IL_01f8:  ldloc.1
      IL_01f9:  ldstr      "-z"
      IL_01fe:  ldc.i4.0
      IL_01ff:  ldc.i4.2
      IL_0200:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_0205:  dup
      IL_0206:  stloc.0
      IL_0207:  brtrue.s   IL_0219

      IL_0209:  ldarg.0
      IL_020a:  ldc.i4.1
      IL_020b:  stfld      bool acucobol.CVM::propDumpMem
      IL_0210:  ldloc.1
      IL_0211:  ldc.i4.2
      IL_0212:  add
      IL_0213:  stloc.1
      IL_0214:  br         IL_05e5

      IL_0219:  ldarg.1
      IL_021a:  ldloc.1
      IL_021b:  ldstr      "-CharToGui"
      IL_0220:  ldc.i4.0
      IL_0221:  ldc.i4.s   11
      IL_0223:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_0228:  dup
      IL_0229:  stloc.0
      IL_022a:  brtrue.s   IL_023d

      IL_022c:  ldarg.0
      IL_022d:  ldc.i4.1
      IL_022e:  stfld      bool acucobol.CVM::propCharToGui
      IL_0233:  ldloc.1
      IL_0234:  ldc.i4.s   11
      IL_0236:  add
      IL_0237:  stloc.1
      IL_0238:  br         IL_05e5

      IL_023d:  ldarg.1
      IL_023e:  ldloc.1
      IL_023f:  ldstr      "-g"
      IL_0244:  ldc.i4.0
      IL_0245:  ldc.i4.2
      IL_0246:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_024b:  dup
      IL_024c:  stloc.0
      IL_024d:  brtrue.s   IL_025f

      IL_024f:  ldarg.0
      IL_0250:  ldc.i4.1
      IL_0251:  stfld      bool acucobol.CVM::propZipErrorFile
      IL_0256:  ldloc.1
      IL_0257:  ldc.i4.2
      IL_0258:  add
      IL_0259:  stloc.1
      IL_025a:  br         IL_05e5

      IL_025f:  ldarg.1
      IL_0260:  ldloc.1
      IL_0261:  ldstr      "-u"
      IL_0266:  ldc.i4.0
      IL_0267:  ldc.i4.2
      IL_0268:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_026d:  dup
      IL_026e:  stloc.0
      IL_026f:  brtrue.s   IL_0281

      IL_0271:  ldarg.0
      IL_0272:  ldc.i4.1
      IL_0273:  stfld      bool acucobol.CVM::propLinkageLength
      IL_0278:  ldloc.1
      IL_0279:  ldc.i4.2
      IL_027a:  add
      IL_027b:  stloc.1
      IL_027c:  br         IL_05e5

      IL_0281:  ldarg.1
      IL_0282:  ldloc.1
      IL_0283:  ldstr      "-runpath"
      IL_0288:  ldc.i4.0
      IL_0289:  ldc.i4.8
      IL_028a:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_028f:  dup
      IL_0290:  stloc.0
      IL_0291:  brtrue.s   IL_02bc

      IL_0293:  ldloc.1
      IL_0294:  ldc.i4.8
      IL_0295:  add
      IL_0296:  stloc.1
      IL_0297:  ldloc.1
      IL_0298:  stloc.0
      IL_0299:  ldarg.0
      IL_029a:  ldarg.0
      IL_029b:  ldflda     string acucobol.CVM::RuntimePath
      IL_02a0:  ldarga.s   param
      IL_02a2:  ldloca.s   i
      IL_02a4:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_02a9:  ldloc.1
      IL_02aa:  ldarg.0
      IL_02ab:  ldfld      string acucobol.CVM::RuntimePath
      IL_02b0:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_02b5:  add
      IL_02b6:  stloc.1
      IL_02b7:  br         IL_05e5

      IL_02bc:  ldarg.1
      IL_02bd:  ldloc.1
      IL_02be:  ldstr      "-Import"
      IL_02c3:  ldc.i4.0
      IL_02c4:  ldc.i4.7
      IL_02c5:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_02ca:  dup
      IL_02cb:  stloc.0
      IL_02cc:  brtrue.s   IL_02f7

      IL_02ce:  ldloc.1
      IL_02cf:  ldc.i4.7
      IL_02d0:  add
      IL_02d1:  stloc.1
      IL_02d2:  ldloc.1
      IL_02d3:  stloc.0
      IL_02d4:  ldarg.0
      IL_02d5:  ldarg.0
      IL_02d6:  ldflda     string acucobol.CVM::propImport
      IL_02db:  ldarga.s   param
      IL_02dd:  ldloca.s   i
      IL_02df:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_02e4:  ldloc.1
      IL_02e5:  ldarg.0
      IL_02e6:  ldfld      string acucobol.CVM::propImport
      IL_02eb:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_02f0:  add
      IL_02f1:  stloc.1
      IL_02f2:  br         IL_05e5

      IL_02f7:  ldarg.1
      IL_02f8:  ldloc.1
      IL_02f9:  ldstr      "-#"
      IL_02fe:  ldc.i4.0
      IL_02ff:  ldc.i4.2
      IL_0300:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_0305:  dup
      IL_0306:  stloc.0
      IL_0307:  brtrue.s   IL_0332

      IL_0309:  ldloc.1
      IL_030a:  ldc.i4.2
      IL_030b:  add
      IL_030c:  stloc.1
      IL_030d:  ldloc.1
      IL_030e:  stloc.0
      IL_030f:  ldarg.0
      IL_0310:  ldarg.0
      IL_0311:  ldflda     string acucobol.CVM::propSwitches
      IL_0316:  ldarga.s   param
      IL_0318:  ldloca.s   i
      IL_031a:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_031f:  ldloc.1
      IL_0320:  ldarg.0
      IL_0321:  ldfld      string acucobol.CVM::propSwitches
      IL_0326:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_032b:  add
      IL_032c:  stloc.1
      IL_032d:  br         IL_05e5

      IL_0332:  ldarg.1
      IL_0333:  ldloc.1
      IL_0334:  ldstr      "-c"
      IL_0339:  ldc.i4.0
      IL_033a:  ldc.i4.2
      IL_033b:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_0340:  dup
      IL_0341:  stloc.0
      IL_0342:  brtrue.s   IL_036d

      IL_0344:  ldloc.1
      IL_0345:  ldc.i4.2
      IL_0346:  add
      IL_0347:  stloc.1
      IL_0348:  ldloc.1
      IL_0349:  stloc.0
      IL_034a:  ldarg.0
      IL_034b:  ldarg.0
      IL_034c:  ldflda     string acucobol.CVM::propConfigFile
      IL_0351:  ldarga.s   param
      IL_0353:  ldloca.s   i
      IL_0355:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_035a:  ldloc.1
      IL_035b:  ldarg.0
      IL_035c:  ldfld      string acucobol.CVM::propConfigFile
      IL_0361:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_0366:  add
      IL_0367:  stloc.1
      IL_0368:  br         IL_05e5

      IL_036d:  ldarg.1
      IL_036e:  ldloc.1
      IL_036f:  ldstr      "-e"
      IL_0374:  ldc.i4.0
      IL_0375:  ldc.i4.2
      IL_0376:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_037b:  dup
      IL_037c:  stloc.0
      IL_037d:  brtrue.s   IL_03a8

      IL_037f:  ldloc.1
      IL_0380:  ldc.i4.2
      IL_0381:  add
      IL_0382:  stloc.1
      IL_0383:  ldloc.1
      IL_0384:  stloc.0
      IL_0385:  ldarg.0
      IL_0386:  ldarg.0
      IL_0387:  ldflda     string acucobol.CVM::propErrorsOut
      IL_038c:  ldarga.s   param
      IL_038e:  ldloca.s   i
      IL_0390:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_0395:  ldloc.1
      IL_0396:  ldarg.0
      IL_0397:  ldfld      string acucobol.CVM::propErrorsOut
      IL_039c:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_03a1:  add
      IL_03a2:  stloc.1
      IL_03a3:  br         IL_05e5

      IL_03a8:  ldarg.1
      IL_03a9:  ldloc.1
      IL_03aa:  ldstr      "+e"
      IL_03af:  ldc.i4.0
      IL_03b0:  ldc.i4.2
      IL_03b1:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_03b6:  dup
      IL_03b7:  stloc.0
      IL_03b8:  brtrue.s   IL_03e3

      IL_03ba:  ldloc.1
      IL_03bb:  ldc.i4.2
      IL_03bc:  add
      IL_03bd:  stloc.1
      IL_03be:  ldloc.1
      IL_03bf:  stloc.0
      IL_03c0:  ldarg.0
      IL_03c1:  ldarg.0
      IL_03c2:  ldflda     string acucobol.CVM::propErrorsAppend
      IL_03c7:  ldarga.s   param
      IL_03c9:  ldloca.s   i
      IL_03cb:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_03d0:  ldloc.1
      IL_03d1:  ldarg.0
      IL_03d2:  ldfld      string acucobol.CVM::propErrorsAppend
      IL_03d7:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_03dc:  add
      IL_03dd:  stloc.1
      IL_03de:  br         IL_05e5

      IL_03e3:  ldarg.1
      IL_03e4:  ldloc.1
      IL_03e5:  ldstr      "-i"
      IL_03ea:  ldc.i4.0
      IL_03eb:  ldc.i4.2
      IL_03ec:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_03f1:  dup
      IL_03f2:  stloc.0
      IL_03f3:  brtrue.s   IL_041e

      IL_03f5:  ldloc.1
      IL_03f6:  ldc.i4.2
      IL_03f7:  add
      IL_03f8:  stloc.1
      IL_03f9:  ldloc.1
      IL_03fa:  stloc.0
      IL_03fb:  ldarg.0
      IL_03fc:  ldarg.0
      IL_03fd:  ldflda     string acucobol.CVM::propKeyFile
      IL_0402:  ldarga.s   param
      IL_0404:  ldloca.s   i
      IL_0406:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_040b:  ldloc.1
      IL_040c:  ldarg.0
      IL_040d:  ldfld      string acucobol.CVM::propKeyFile
      IL_0412:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_0417:  add
      IL_0418:  stloc.1
      IL_0419:  br         IL_05e5

      IL_041e:  ldarg.1
      IL_041f:  ldloc.1
      IL_0420:  ldstr      "-k"
      IL_0425:  ldc.i4.0
      IL_0426:  ldc.i4.2
      IL_0427:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_042c:  dup
      IL_042d:  stloc.0
      IL_042e:  brtrue.s   IL_0459

      IL_0430:  ldloc.1
      IL_0431:  ldc.i4.2
      IL_0432:  add
      IL_0433:  stloc.1
      IL_0434:  ldloc.1
      IL_0435:  stloc.0
      IL_0436:  ldarg.0
      IL_0437:  ldarg.0
      IL_0438:  ldflda     string acucobol.CVM::propPlays
      IL_043d:  ldarga.s   param
      IL_043f:  ldloca.s   i
      IL_0441:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_0446:  ldloc.1
      IL_0447:  ldarg.0
      IL_0448:  ldfld      string acucobol.CVM::propPlays
      IL_044d:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_0452:  add
      IL_0453:  stloc.1
      IL_0454:  br         IL_05e5

      IL_0459:  ldarg.1
      IL_045a:  ldloc.1
      IL_045b:  ldstr      "-o"
      IL_0460:  ldc.i4.0
      IL_0461:  ldc.i4.2
      IL_0462:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_0467:  dup
      IL_0468:  stloc.0
      IL_0469:  brtrue.s   IL_0494

      IL_046b:  ldloc.1
      IL_046c:  ldc.i4.2
      IL_046d:  add
      IL_046e:  stloc.1
      IL_046f:  ldloc.1
      IL_0470:  stloc.0
      IL_0471:  ldarg.0
      IL_0472:  ldarg.0
      IL_0473:  ldflda     string acucobol.CVM::propDisplayOut
      IL_0478:  ldarga.s   param
      IL_047a:  ldloca.s   i
      IL_047c:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_0481:  ldloc.1
      IL_0482:  ldarg.0
      IL_0483:  ldfld      string acucobol.CVM::propDisplayOut
      IL_0488:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_048d:  add
      IL_048e:  stloc.1
      IL_048f:  br         IL_05e5

      IL_0494:  ldarg.1
      IL_0495:  ldloc.1
      IL_0496:  ldstr      "+o"
      IL_049b:  ldc.i4.0
      IL_049c:  ldc.i4.2
      IL_049d:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_04a2:  dup
      IL_04a3:  stloc.0
      IL_04a4:  brtrue.s   IL_04cf

      IL_04a6:  ldloc.1
      IL_04a7:  ldc.i4.2
      IL_04a8:  add
      IL_04a9:  stloc.1
      IL_04aa:  ldloc.1
      IL_04ab:  stloc.0
      IL_04ac:  ldarg.0
      IL_04ad:  ldarg.0
      IL_04ae:  ldflda     string acucobol.CVM::propDisplayAppend
      IL_04b3:  ldarga.s   param
      IL_04b5:  ldloca.s   i
      IL_04b7:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_04bc:  ldloc.1
      IL_04bd:  ldarg.0
      IL_04be:  ldfld      string acucobol.CVM::propDisplayAppend
      IL_04c3:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_04c8:  add
      IL_04c9:  stloc.1
      IL_04ca:  br         IL_05e5

      IL_04cf:  ldarg.1
      IL_04d0:  ldloc.1
      IL_04d1:  ldstr      "-r"
      IL_04d6:  ldc.i4.0
      IL_04d7:  ldc.i4.2
      IL_04d8:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_04dd:  dup
      IL_04de:  stloc.0
      IL_04df:  brtrue.s   IL_050a

      IL_04e1:  ldloc.1
      IL_04e2:  ldc.i4.2
      IL_04e3:  add
      IL_04e4:  stloc.1
      IL_04e5:  ldloc.1
      IL_04e6:  stloc.0
      IL_04e7:  ldarg.0
      IL_04e8:  ldarg.0
      IL_04e9:  ldflda     string acucobol.CVM::propDebugCmds
      IL_04ee:  ldarga.s   param
      IL_04f0:  ldloca.s   i
      IL_04f2:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_04f7:  ldloc.1
      IL_04f8:  ldarg.0
      IL_04f9:  ldfld      string acucobol.CVM::propDebugCmds
      IL_04fe:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_0503:  add
      IL_0504:  stloc.1
      IL_0505:  br         IL_05e5

      IL_050a:  ldarg.1
      IL_050b:  ldloc.1
      IL_050c:  ldstr      "-t"
      IL_0511:  ldc.i4.0
      IL_0512:  ldc.i4.2
      IL_0513:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_0518:  dup
      IL_0519:  stloc.0
      IL_051a:  brtrue.s   IL_0545

      IL_051c:  ldloc.1
      IL_051d:  ldc.i4.2
      IL_051e:  add
      IL_051f:  stloc.1
      IL_0520:  ldloc.1
      IL_0521:  stloc.0
      IL_0522:  ldarg.0
      IL_0523:  ldarg.0
      IL_0524:  ldflda     string acucobol.CVM::propTerminalOut
      IL_0529:  ldarga.s   param
      IL_052b:  ldloca.s   i
      IL_052d:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_0532:  ldloc.1
      IL_0533:  ldarg.0
      IL_0534:  ldfld      string acucobol.CVM::propTerminalOut
      IL_0539:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_053e:  add
      IL_053f:  stloc.1
      IL_0540:  br         IL_05e5

      IL_0545:  ldarg.1
      IL_0546:  ldloc.1
      IL_0547:  ldstr      "-y"
      IL_054c:  ldc.i4.0
      IL_054d:  ldc.i4.2
      IL_054e:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_0553:  dup
      IL_0554:  stloc.0
      IL_0555:  brtrue.s   IL_05a7

      IL_0557:  ldloc.1
      IL_0558:  ldc.i4.2
      IL_0559:  add
      IL_055a:  stloc.1
      IL_055b:  ldloc.1
      IL_055c:  stloc.0
      IL_055d:  ldarg.0
      IL_055e:  ldarg.0
      IL_055f:  ldfld      string[] acucobol.CVM::propObjLib
      IL_0564:  ldarg.0
      IL_0565:  ldfld      int32 acucobol.CVM::Objidx
      IL_056a:  ldelema    [mscorlib]System.String
      IL_056f:  ldarga.s   param
      IL_0571:  ldloca.s   i
      IL_0573:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_0578:  ldarg.0
      IL_0579:  ldfld      int32 acucobol.CVM::Objidx
      IL_057e:  ldc.i4.s   31
      IL_0580:  bge.s      IL_0590

      IL_0582:  ldarg.0
      IL_0583:  dup
      IL_0584:  ldfld      int32 acucobol.CVM::Objidx
      IL_0589:  ldc.i4.1
      IL_058a:  add
      IL_058b:  stfld      int32 acucobol.CVM::Objidx
      IL_0590:  ldloc.1
      IL_0591:  ldarg.0
      IL_0592:  ldfld      string[] acucobol.CVM::propObjLib
      IL_0597:  ldarg.0
      IL_0598:  ldfld      int32 acucobol.CVM::Objidx
      IL_059d:  ldelem.ref
      IL_059e:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_05a3:  add
      IL_05a4:  stloc.1
      IL_05a5:  br.s       IL_05e5

      IL_05a7:  ldarg.1
      IL_05a8:  ldloc.1
      IL_05a9:  ldstr      "--embedded"
      IL_05ae:  ldc.i4.0
      IL_05af:  ldc.i4.s   10
      IL_05b1:  call       int32 [mscorlib]System.String::Compare(string,
                                                                  int32,
                                                                  string,
                                                                  int32,
                                                                  int32)
      IL_05b6:  dup
      IL_05b7:  stloc.0
      IL_05b8:  brtrue.s   IL_05e1

      IL_05ba:  ldloc.1
      IL_05bb:  ldc.i4.s   10
      IL_05bd:  add
      IL_05be:  stloc.1
      IL_05bf:  ldloc.1
      IL_05c0:  stloc.0
      IL_05c1:  ldarg.0
      IL_05c2:  ldarg.0
      IL_05c3:  ldflda     string acucobol.CVM::propEmbeddedLib
      IL_05c8:  ldarga.s   param
      IL_05ca:  ldloca.s   i
      IL_05cc:  call       instance void acucobol.CVM::MoveOptionToProp(string&,
                                                                        string&,
                                                                        int32&)
      IL_05d1:  ldloc.1
      IL_05d2:  ldarg.0
      IL_05d3:  ldfld      string acucobol.CVM::propEmbeddedLib
      IL_05d8:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_05dd:  add
      IL_05de:  stloc.1
      IL_05df:  br.s       IL_05e5

      IL_05e1:  ldloc.1
      IL_05e2:  ldc.i4.1
      IL_05e3:  add
      IL_05e4:  stloc.1
      IL_05e5:  ldloc.1
      IL_05e6:  ldarg.1
      IL_05e7:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_05ec:  blt        IL_0019

      IL_05f1:  ret
    } // end of method CVM::SetProperties

    .method private hidebysig instance void 
            MoveOptionToProp(string& prop,
                             string& option,
                             int32& idx) cil managed
    {
      // Code size       199 (0xc7)
      .maxstack  4
      .locals ([0] int32 length,
               [1] bool InQuotes,
               [2] int32 start)
      IL_0000:  ldc.i4.0
      IL_0001:  stloc.0
      IL_0002:  ldc.i4.0
      IL_0003:  stloc.1
      IL_0004:  br.s       IL_001d

      IL_0006:  ldarg.2
      IL_0007:  ldind.ref
      IL_0008:  ldarg.3
      IL_0009:  ldind.i4
      IL_000a:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_000f:  ldc.i4.s   32
      IL_0011:  bne.un.s   IL_001b

      IL_0013:  ldarg.3
      IL_0014:  dup
      IL_0015:  ldind.i4
      IL_0016:  ldc.i4.1
      IL_0017:  add
      IL_0018:  stind.i4
      IL_0019:  br.s       IL_001d

      IL_001b:  br.s       IL_0028

      IL_001d:  ldarg.3
      IL_001e:  ldind.i4
      IL_001f:  ldarg.2
      IL_0020:  ldind.ref
      IL_0021:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_0026:  blt.s      IL_0006

      IL_0028:  ldarg.3
      IL_0029:  ldind.i4
      IL_002a:  stloc.2
      IL_002b:  br.s       IL_009f

      IL_002d:  ldloc.1
      IL_002e:  brtrue.s   IL_004c

      IL_0030:  ldarg.2
      IL_0031:  ldind.ref
      IL_0032:  ldarg.3
      IL_0033:  ldind.i4
      IL_0034:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0039:  ldc.i4.s   32
      IL_003b:  beq.s      IL_004a

      IL_003d:  ldarg.2
      IL_003e:  ldind.ref
      IL_003f:  ldarg.3
      IL_0040:  ldind.i4
      IL_0041:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0046:  ldc.i4.s   45
      IL_0048:  bne.un.s   IL_004c

      IL_004a:  br.s       IL_00aa

      IL_004c:  ldloc.1
      IL_004d:  brfalse.s  IL_0086

      IL_004f:  ldarg.2
      IL_0050:  ldind.ref
      IL_0051:  ldarg.3
      IL_0052:  ldind.i4
      IL_0053:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0058:  ldc.i4.s   34
      IL_005a:  bne.un.s   IL_0086

      IL_005c:  ldarg.3
      IL_005d:  ldind.i4
      IL_005e:  ldc.i4.1
      IL_005f:  add
      IL_0060:  ldarg.2
      IL_0061:  ldind.ref
      IL_0062:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_0067:  bge.s      IL_0084

      IL_0069:  ldarg.2
      IL_006a:  ldind.ref
      IL_006b:  ldarg.3
      IL_006c:  ldind.i4
      IL_006d:  ldc.i4.1
      IL_006e:  add
      IL_006f:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0074:  ldc.i4.s   34
      IL_0076:  bne.un.s   IL_0084

      IL_0078:  ldarg.3
      IL_0079:  dup
      IL_007a:  ldind.i4
      IL_007b:  ldc.i4.1
      IL_007c:  add
      IL_007d:  stind.i4
      IL_007e:  ldloc.0
      IL_007f:  ldc.i4.1
      IL_0080:  add
      IL_0081:  stloc.0
      IL_0082:  br.s       IL_0086

      IL_0084:  br.s       IL_00aa

      IL_0086:  ldarg.2
      IL_0087:  ldind.ref
      IL_0088:  ldarg.3
      IL_0089:  ldind.i4
      IL_008a:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_008f:  ldc.i4.s   34
      IL_0091:  bne.un.s   IL_0095

      IL_0093:  ldc.i4.1
      IL_0094:  stloc.1
      IL_0095:  ldarg.3
      IL_0096:  dup
      IL_0097:  ldind.i4
      IL_0098:  ldc.i4.1
      IL_0099:  add
      IL_009a:  stind.i4
      IL_009b:  ldloc.0
      IL_009c:  ldc.i4.1
      IL_009d:  add
      IL_009e:  stloc.0
      IL_009f:  ldarg.3
      IL_00a0:  ldind.i4
      IL_00a1:  ldarg.2
      IL_00a2:  ldind.ref
      IL_00a3:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_00a8:  blt.s      IL_002d

      IL_00aa:  ldloc.1
      IL_00ab:  brfalse.s  IL_00b7

      IL_00ad:  ldc.i4.0
      IL_00ae:  stloc.1
      IL_00af:  ldloc.2
      IL_00b0:  ldc.i4.1
      IL_00b1:  add
      IL_00b2:  stloc.2
      IL_00b3:  ldloc.0
      IL_00b4:  ldc.i4.2
      IL_00b5:  sub
      IL_00b6:  stloc.0
      IL_00b7:  ldloc.0
      IL_00b8:  ldc.i4.0
      IL_00b9:  ble.s      IL_00c6

      IL_00bb:  ldarg.1
      IL_00bc:  ldarg.2
      IL_00bd:  ldind.ref
      IL_00be:  ldloc.2
      IL_00bf:  ldloc.0
      IL_00c0:  callvirt   instance string [mscorlib]System.String::Substring(int32,
                                                                              int32)
      IL_00c5:  stind.ref
      IL_00c6:  ret
    } // end of method CVM::MoveOptionToProp

    .method private hidebysig instance void 
            BuildOptions(string& options) cil managed
    {
      // Code size       714 (0x2ca)
      .maxstack  3
      .locals ([0] class [mscorlib]System.Text.StringBuilder optString,
               [1] int32 i)
      IL_0000:  ldc.i4     0x100
      IL_0005:  newobj     instance void [mscorlib]System.Text.StringBuilder::.ctor(int32)
      IL_000a:  stloc.0
      IL_000b:  ldarg.0
      IL_000c:  ldfld      bool acucobol.CVM::propTerminalInit
      IL_0011:  brfalse.s  IL_001f

      IL_0013:  ldloc.0
      IL_0014:  ldstr      " -b "
      IL_0019:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_001e:  pop
      IL_001f:  ldarg.0
      IL_0020:  ldfld      bool acucobol.CVM::propCGIWarnings
      IL_0025:  brfalse.s  IL_0033

      IL_0027:  ldloc.0
      IL_0028:  ldstr      " -f "
      IL_002d:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0032:  pop
      IL_0033:  ldarg.0
      IL_0034:  ldfld      bool acucobol.CVM::propIgnoreSignals
      IL_0039:  brfalse.s  IL_0047

      IL_003b:  ldloc.0
      IL_003c:  ldstr      " -h "
      IL_0041:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0046:  pop
      IL_0047:  ldarg.0
      IL_0048:  ldfld      bool acucobol.CVM::propListConfig
      IL_004d:  brfalse.s  IL_005b

      IL_004f:  ldloc.0
      IL_0050:  ldstr      " -l "
      IL_0055:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_005a:  pop
      IL_005b:  ldarg.0
      IL_005c:  ldfld      bool acucobol.CVM::propNoSaveDebug
      IL_0061:  brfalse.s  IL_006f

      IL_0063:  ldloc.0
      IL_0064:  ldstr      " --no-save-debug "
      IL_0069:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_006e:  pop
      IL_006f:  ldarg.0
      IL_0070:  ldfld      bool acucobol.CVM::propSafeMode
      IL_0075:  brfalse.s  IL_0083

      IL_0077:  ldloc.0
      IL_0078:  ldstr      " -s "
      IL_007d:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0082:  pop
      IL_0083:  ldarg.0
      IL_0084:  ldfld      bool acucobol.CVM::propNonNumeric
      IL_0089:  brfalse.s  IL_0097

      IL_008b:  ldloc.0
      IL_008c:  ldstr      " -w "
      IL_0091:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0096:  pop
      IL_0097:  ldarg.0
      IL_0098:  ldfld      bool acucobol.CVM::propExtendedError
      IL_009d:  brfalse.s  IL_00ab

      IL_009f:  ldloc.0
      IL_00a0:  ldstr      " -x "
      IL_00a5:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_00aa:  pop
      IL_00ab:  ldarg.0
      IL_00ac:  ldfld      bool acucobol.CVM::propDumpMem
      IL_00b1:  brfalse.s  IL_00bf

      IL_00b3:  ldloc.0
      IL_00b4:  ldstr      " -z "
      IL_00b9:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_00be:  pop
      IL_00bf:  ldarg.0
      IL_00c0:  ldfld      bool acucobol.CVM::propCharToGui
      IL_00c5:  brfalse.s  IL_00d3

      IL_00c7:  ldloc.0
      IL_00c8:  ldstr      " --CharToGui "
      IL_00cd:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_00d2:  pop
      IL_00d3:  ldarg.0
      IL_00d4:  ldfld      bool acucobol.CVM::propZipErrorFile
      IL_00d9:  brfalse.s  IL_00e7

      IL_00db:  ldloc.0
      IL_00dc:  ldstr      " -g "
      IL_00e1:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_00e6:  pop
      IL_00e7:  ldarg.0
      IL_00e8:  ldfld      bool acucobol.CVM::propLinkageLength
      IL_00ed:  brfalse.s  IL_00fb

      IL_00ef:  ldloc.0
      IL_00f0:  ldstr      " -u "
      IL_00f5:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_00fa:  pop
      IL_00fb:  ldarg.0
      IL_00fc:  ldfld      string acucobol.CVM::propSwitches
      IL_0101:  brfalse.s  IL_011c

      IL_0103:  ldloc.0
      IL_0104:  ldstr      " -# "
      IL_0109:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_010e:  pop
      IL_010f:  ldloc.0
      IL_0110:  ldarg.0
      IL_0111:  ldfld      string acucobol.CVM::propSwitches
      IL_0116:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_011b:  pop
      IL_011c:  ldarg.0
      IL_011d:  ldfld      string acucobol.CVM::propConfigFile
      IL_0122:  brfalse.s  IL_013d

      IL_0124:  ldloc.0
      IL_0125:  ldstr      " -c "
      IL_012a:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_012f:  pop
      IL_0130:  ldloc.0
      IL_0131:  ldarg.0
      IL_0132:  ldfld      string acucobol.CVM::propConfigFile
      IL_0137:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_013c:  pop
      IL_013d:  ldarg.0
      IL_013e:  ldfld      string acucobol.CVM::propErrorsOut
      IL_0143:  brfalse.s  IL_015e

      IL_0145:  ldloc.0
      IL_0146:  ldstr      " -e "
      IL_014b:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0150:  pop
      IL_0151:  ldloc.0
      IL_0152:  ldarg.0
      IL_0153:  ldfld      string acucobol.CVM::propErrorsOut
      IL_0158:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_015d:  pop
      IL_015e:  ldarg.0
      IL_015f:  ldfld      string acucobol.CVM::propErrorsAppend
      IL_0164:  brfalse.s  IL_017f

      IL_0166:  ldloc.0
      IL_0167:  ldstr      " +e "
      IL_016c:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0171:  pop
      IL_0172:  ldloc.0
      IL_0173:  ldarg.0
      IL_0174:  ldfld      string acucobol.CVM::propErrorsAppend
      IL_0179:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_017e:  pop
      IL_017f:  ldarg.0
      IL_0180:  ldfld      string acucobol.CVM::propKeyFile
      IL_0185:  brfalse.s  IL_01a0

      IL_0187:  ldloc.0
      IL_0188:  ldstr      " -i "
      IL_018d:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0192:  pop
      IL_0193:  ldloc.0
      IL_0194:  ldarg.0
      IL_0195:  ldfld      string acucobol.CVM::propKeyFile
      IL_019a:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_019f:  pop
      IL_01a0:  ldarg.0
      IL_01a1:  ldfld      string acucobol.CVM::propImport
      IL_01a6:  brfalse.s  IL_01c1

      IL_01a8:  ldloc.0
      IL_01a9:  ldstr      " -import "
      IL_01ae:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_01b3:  pop
      IL_01b4:  ldloc.0
      IL_01b5:  ldarg.0
      IL_01b6:  ldfld      string acucobol.CVM::propImport
      IL_01bb:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_01c0:  pop
      IL_01c1:  ldarg.0
      IL_01c2:  ldfld      string acucobol.CVM::propPlays
      IL_01c7:  brfalse.s  IL_01e2

      IL_01c9:  ldloc.0
      IL_01ca:  ldstr      " -k "
      IL_01cf:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_01d4:  pop
      IL_01d5:  ldloc.0
      IL_01d6:  ldarg.0
      IL_01d7:  ldfld      string acucobol.CVM::propPlays
      IL_01dc:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_01e1:  pop
      IL_01e2:  ldarg.0
      IL_01e3:  ldfld      string acucobol.CVM::propDisplayOut
      IL_01e8:  brfalse.s  IL_0203

      IL_01ea:  ldloc.0
      IL_01eb:  ldstr      " -o "
      IL_01f0:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_01f5:  pop
      IL_01f6:  ldloc.0
      IL_01f7:  ldarg.0
      IL_01f8:  ldfld      string acucobol.CVM::propDisplayOut
      IL_01fd:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0202:  pop
      IL_0203:  ldarg.0
      IL_0204:  ldfld      string acucobol.CVM::propDisplayAppend
      IL_0209:  brfalse.s  IL_0224

      IL_020b:  ldloc.0
      IL_020c:  ldstr      " +o "
      IL_0211:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0216:  pop
      IL_0217:  ldloc.0
      IL_0218:  ldarg.0
      IL_0219:  ldfld      string acucobol.CVM::propDisplayAppend
      IL_021e:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0223:  pop
      IL_0224:  ldarg.0
      IL_0225:  ldfld      string acucobol.CVM::propDebugCmds
      IL_022a:  brfalse.s  IL_0245

      IL_022c:  ldloc.0
      IL_022d:  ldstr      " -r "
      IL_0232:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0237:  pop
      IL_0238:  ldloc.0
      IL_0239:  ldarg.0
      IL_023a:  ldfld      string acucobol.CVM::propDebugCmds
      IL_023f:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0244:  pop
      IL_0245:  ldarg.0
      IL_0246:  ldfld      string acucobol.CVM::propTerminalOut
      IL_024b:  brfalse.s  IL_0266

      IL_024d:  ldloc.0
      IL_024e:  ldstr      " -t "
      IL_0253:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0258:  pop
      IL_0259:  ldloc.0
      IL_025a:  ldarg.0
      IL_025b:  ldfld      string acucobol.CVM::propTerminalOut
      IL_0260:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_0265:  pop
      IL_0266:  ldarg.0
      IL_0267:  ldfld      string[] acucobol.CVM::propObjLib
      IL_026c:  brfalse.s  IL_02a0

      IL_026e:  ldc.i4.0
      IL_026f:  stloc.1
      IL_0270:  br.s       IL_0291

      IL_0272:  ldloc.0
      IL_0273:  ldstr      " -y "
      IL_0278:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_027d:  pop
      IL_027e:  ldloc.0
      IL_027f:  ldarg.0
      IL_0280:  ldfld      string[] acucobol.CVM::propObjLib
      IL_0285:  ldloc.1
      IL_0286:  ldelem.ref
      IL_0287:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_028c:  pop
      IL_028d:  ldloc.1
      IL_028e:  ldc.i4.1
      IL_028f:  add
      IL_0290:  stloc.1
      IL_0291:  ldarg.0
      IL_0292:  ldfld      string[] acucobol.CVM::propObjLib
      IL_0297:  ldloc.1
      IL_0298:  ldelem.ref
      IL_0299:  brfalse.s  IL_02a0

      IL_029b:  ldloc.1
      IL_029c:  ldc.i4.s   32
      IL_029e:  blt.s      IL_0272

      IL_02a0:  ldarg.0
      IL_02a1:  ldfld      string acucobol.CVM::propEmbeddedLib
      IL_02a6:  brfalse.s  IL_02c1

      IL_02a8:  ldloc.0
      IL_02a9:  ldstr      " --embedded "
      IL_02ae:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_02b3:  pop
      IL_02b4:  ldloc.0
      IL_02b5:  ldarg.0
      IL_02b6:  ldfld      string acucobol.CVM::propEmbeddedLib
      IL_02bb:  callvirt   instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(string)
      IL_02c0:  pop
      IL_02c1:  ldarg.1
      IL_02c2:  ldloc.0
      IL_02c3:  callvirt   instance string [mscorlib]System.Text.StringBuilder::ToString()
      IL_02c8:  stind.ref
      IL_02c9:  ret
    } // end of method CVM::BuildOptions

    .method public hidebysig instance void 
            SetCallOptions(string CallOptions) cil managed
    {
      // Code size       391 (0x187)
      .maxstack  3
      .locals ([0] int32 idx)
      IL_0000:  ldarg.1
      IL_0001:  ldstr      "-d"
      IL_0006:  callvirt   instance int32 [mscorlib]System.String::IndexOf(string)
      IL_000b:  stloc.0
      IL_000c:  ldloc.0
      IL_000d:  ldc.i4.m1
      IL_000e:  beq.s      IL_004e

      IL_0010:  br.s       IL_003a

      IL_0012:  ldarg.1
      IL_0013:  ldloc.0
      IL_0014:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0019:  ldc.i4.s   49
      IL_001b:  bne.un.s   IL_0026

      IL_001d:  ldarg.0
      IL_001e:  ldc.i4.1
      IL_001f:  stfld      bool acucobol.CVM::propDebug
      IL_0024:  br.s       IL_004e

      IL_0026:  ldarg.1
      IL_0027:  ldloc.0
      IL_0028:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_002d:  ldc.i4.s   48
      IL_002f:  bne.un.s   IL_003a

      IL_0031:  ldarg.0
      IL_0032:  ldc.i4.0
      IL_0033:  stfld      bool acucobol.CVM::propDebug
      IL_0038:  br.s       IL_004e

      IL_003a:  ldarg.1
      IL_003b:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_0040:  ldloc.0
      IL_0041:  ble.s      IL_004e

      IL_0043:  ldarg.1
      IL_0044:  ldloc.0
      IL_0045:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_004a:  ldc.i4.s   45
      IL_004c:  bne.un.s   IL_0012

      IL_004e:  ldarg.1
      IL_004f:  ldstr      "-cache"
      IL_0054:  callvirt   instance int32 [mscorlib]System.String::IndexOf(string)
      IL_0059:  stloc.0
      IL_005a:  ldloc.0
      IL_005b:  ldc.i4.m1
      IL_005c:  beq.s      IL_009c

      IL_005e:  br.s       IL_0088

      IL_0060:  ldarg.1
      IL_0061:  ldloc.0
      IL_0062:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0067:  ldc.i4.s   49
      IL_0069:  bne.un.s   IL_0074

      IL_006b:  ldarg.0
      IL_006c:  ldc.i4.1
      IL_006d:  stfld      bool acucobol.CVM::propCache
      IL_0072:  br.s       IL_009c

      IL_0074:  ldarg.1
      IL_0075:  ldloc.0
      IL_0076:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_007b:  ldc.i4.s   48
      IL_007d:  bne.un.s   IL_0088

      IL_007f:  ldarg.0
      IL_0080:  ldc.i4.0
      IL_0081:  stfld      bool acucobol.CVM::propCache
      IL_0086:  br.s       IL_009c

      IL_0088:  ldarg.1
      IL_0089:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_008e:  ldloc.0
      IL_008f:  ble.s      IL_009c

      IL_0091:  ldarg.1
      IL_0092:  ldloc.0
      IL_0093:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0098:  ldc.i4.s   45
      IL_009a:  bne.un.s   IL_0060

      IL_009c:  ldarg.1
      IL_009d:  ldstr      "-wide"
      IL_00a2:  callvirt   instance int32 [mscorlib]System.String::IndexOf(string)
      IL_00a7:  stloc.0
      IL_00a8:  ldloc.0
      IL_00a9:  ldc.i4.m1
      IL_00aa:  beq.s      IL_00ea

      IL_00ac:  br.s       IL_00d6

      IL_00ae:  ldarg.1
      IL_00af:  ldloc.0
      IL_00b0:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_00b5:  ldc.i4.s   49
      IL_00b7:  bne.un.s   IL_00c2

      IL_00b9:  ldarg.0
      IL_00ba:  ldc.i4.1
      IL_00bb:  stfld      bool acucobol.CVM::propWide
      IL_00c0:  br.s       IL_00ea

      IL_00c2:  ldarg.1
      IL_00c3:  ldloc.0
      IL_00c4:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_00c9:  ldc.i4.s   48
      IL_00cb:  bne.un.s   IL_00d6

      IL_00cd:  ldarg.0
      IL_00ce:  ldc.i4.0
      IL_00cf:  stfld      bool acucobol.CVM::propWide
      IL_00d4:  br.s       IL_00ea

      IL_00d6:  ldarg.1
      IL_00d7:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_00dc:  ldloc.0
      IL_00dd:  ble.s      IL_00ea

      IL_00df:  ldarg.1
      IL_00e0:  ldloc.0
      IL_00e1:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_00e6:  ldc.i4.s   45
      IL_00e8:  bne.un.s   IL_00ae

      IL_00ea:  ldarg.1
      IL_00eb:  ldstr      "-uni"
      IL_00f0:  callvirt   instance int32 [mscorlib]System.String::IndexOf(string)
      IL_00f5:  stloc.0
      IL_00f6:  ldloc.0
      IL_00f7:  ldc.i4.m1
      IL_00f8:  beq.s      IL_0138

      IL_00fa:  br.s       IL_0124

      IL_00fc:  ldarg.1
      IL_00fd:  ldloc.0
      IL_00fe:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0103:  ldc.i4.s   49
      IL_0105:  bne.un.s   IL_0110

      IL_0107:  ldarg.0
      IL_0108:  ldc.i4.1
      IL_0109:  stfld      bool acucobol.CVM::propUniCode
      IL_010e:  br.s       IL_0138

      IL_0110:  ldarg.1
      IL_0111:  ldloc.0
      IL_0112:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0117:  ldc.i4.s   48
      IL_0119:  bne.un.s   IL_0124

      IL_011b:  ldarg.0
      IL_011c:  ldc.i4.0
      IL_011d:  stfld      bool acucobol.CVM::propUniCode
      IL_0122:  br.s       IL_0138

      IL_0124:  ldarg.1
      IL_0125:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_012a:  ldloc.0
      IL_012b:  ble.s      IL_0138

      IL_012d:  ldarg.1
      IL_012e:  ldloc.0
      IL_012f:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0134:  ldc.i4.s   45
      IL_0136:  bne.un.s   IL_00fc

      IL_0138:  ldarg.1
      IL_0139:  ldstr      "-show"
      IL_013e:  callvirt   instance int32 [mscorlib]System.String::IndexOf(string)
      IL_0143:  stloc.0
      IL_0144:  ldloc.0
      IL_0145:  ldc.i4.m1
      IL_0146:  beq.s      IL_0186

      IL_0148:  br.s       IL_0172

      IL_014a:  ldarg.1
      IL_014b:  ldloc.0
      IL_014c:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0151:  ldc.i4.s   49
      IL_0153:  bne.un.s   IL_015e

      IL_0155:  ldarg.0
      IL_0156:  ldc.i4.1
      IL_0157:  stfld      bool acucobol.CVM::propShowError
      IL_015c:  br.s       IL_0186

      IL_015e:  ldarg.1
      IL_015f:  ldloc.0
      IL_0160:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0165:  ldc.i4.s   48
      IL_0167:  bne.un.s   IL_0172

      IL_0169:  ldarg.0
      IL_016a:  ldc.i4.0
      IL_016b:  stfld      bool acucobol.CVM::propShowError
      IL_0170:  br.s       IL_0186

      IL_0172:  ldarg.1
      IL_0173:  callvirt   instance int32 [mscorlib]System.String::get_Length()
      IL_0178:  ldloc.0
      IL_0179:  ble.s      IL_0186

      IL_017b:  ldarg.1
      IL_017c:  ldloc.0
      IL_017d:  callvirt   instance char [mscorlib]System.String::get_Chars(int32)
      IL_0182:  ldc.i4.s   45
      IL_0184:  bne.un.s   IL_014a

      IL_0186:  ret
    } // end of method CVM::SetCallOptions

    .property instance bool Debug()
    {
      .set instance void acucobol.CVM::set_Debug(bool)
    } // end of property CVM::Debug
    .property instance bool Unicode()
    {
      .set instance void acucobol.CVM::set_Unicode(bool)
    } // end of property CVM::Unicode
    .property instance bool Wide()
    {
      .set instance void acucobol.CVM::set_Wide(bool)
    } // end of property CVM::Wide
    .property instance bool NoStop()
    {
      .set instance void acucobol.CVM::set_NoStop(bool)
    } // end of property CVM::NoStop
    .property instance bool Cache()
    {
      .set instance void acucobol.CVM::set_Cache(bool)
    } // end of property CVM::Cache
    .property instance bool TerminalInit()
    {
      .set instance void acucobol.CVM::set_TerminalInit(bool)
    } // end of property CVM::TerminalInit
    .property instance bool CGIWarnings()
    {
      .set instance void acucobol.CVM::set_CGIWarnings(bool)
    } // end of property CVM::CGIWarnings
    .property instance bool IgnoreSignals()
    {
      .set instance void acucobol.CVM::set_IgnoreSignals(bool)
    } // end of property CVM::IgnoreSignals
    .property instance bool ListConfig()
    {
      .set instance void acucobol.CVM::set_ListConfig(bool)
    } // end of property CVM::ListConfig
    .property instance bool NoSaveDebug()
    {
      .set instance void acucobol.CVM::set_NoSaveDebug(bool)
    } // end of property CVM::NoSaveDebug
    .property instance bool SafeMode()
    {
      .set instance void acucobol.CVM::set_SafeMode(bool)
    } // end of property CVM::SafeMode
    .property instance bool NonNumeric()
    {
      .set instance void acucobol.CVM::set_NonNumeric(bool)
    } // end of property CVM::NonNumeric
    .property instance bool ExtendedError()
    {
      .set instance void acucobol.CVM::set_ExtendedError(bool)
    } // end of property CVM::ExtendedError
    .property instance bool DumpMem()
    {
      .set instance void acucobol.CVM::set_DumpMem(bool)
    } // end of property CVM::DumpMem
    .property instance bool ShowError()
    {
      .set instance void acucobol.CVM::set_ShowError(bool)
    } // end of property CVM::ShowError
    .property instance bool CharToGui()
    {
      .set instance void acucobol.CVM::set_CharToGui(bool)
    } // end of property CVM::CharToGui
    .property instance bool ZipErrorFile()
    {
      .set instance void acucobol.CVM::set_ZipErrorFile(bool)
    } // end of property CVM::ZipErrorFile
    .property instance bool LinkageLength()
    {
      .set instance void acucobol.CVM::set_LinkageLength(bool)
    } // end of property CVM::LinkageLength
    .property instance string EmbeddedLib()
    {
      .set instance void acucobol.CVM::set_EmbeddedLib(string)
    } // end of property CVM::EmbeddedLib
    .property instance string LastErrorMsg()
    {
      .get instance string acucobol.CVM::get_LastErrorMsg()
    } // end of property CVM::LastErrorMsg
    .property instance string RunPath()
    {
      .set instance void acucobol.CVM::set_RunPath(string)
    } // end of property CVM::RunPath
    .property instance string Switches()
    {
      .set instance void acucobol.CVM::set_Switches(string)
    } // end of property CVM::Switches
    .property instance string ConfigFile()
    {
      .set instance void acucobol.CVM::set_ConfigFile(string)
    } // end of property CVM::ConfigFile
    .property instance string ErrorsOut()
    {
      .set instance void acucobol.CVM::set_ErrorsOut(string)
    } // end of property CVM::ErrorsOut
    .property instance string ErrorsAppend()
    {
      .set instance void acucobol.CVM::set_ErrorsAppend(string)
    } // end of property CVM::ErrorsAppend
    .property instance string KeyFile()
    {
      .set instance void acucobol.CVM::set_KeyFile(string)
    } // end of property CVM::KeyFile
    .property instance string Import()
    {
      .set instance void acucobol.CVM::set_Import(string)
    } // end of property CVM::Import
    .property instance string Plays()
    {
      .set instance void acucobol.CVM::set_Plays(string)
    } // end of property CVM::Plays
    .property instance string DisplayOut()
    {
      .set instance void acucobol.CVM::set_DisplayOut(string)
    } // end of property CVM::DisplayOut
    .property instance string DisplayAppend()
    {
      .set instance void acucobol.CVM::set_DisplayAppend(string)
    } // end of property CVM::DisplayAppend
    .property instance string DebugCmds()
    {
      .set instance void acucobol.CVM::set_DebugCmds(string)
    } // end of property CVM::DebugCmds
    .property instance string TerminalOut()
    {
      .set instance void acucobol.CVM::set_TerminalOut(string)
    } // end of property CVM::TerminalOut
    .property instance string ObjLib()
    {
      .set instance void acucobol.CVM::set_ObjLib(string)
    } // end of property CVM::ObjLib
    