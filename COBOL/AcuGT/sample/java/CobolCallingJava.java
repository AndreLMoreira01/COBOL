/*
 * Created on March 11, 2005
 *
 */

import java.util.*;
import java.util.logging.*;
import java.io.*;
import com.acucorp.acucobolgt.*;

/**
 * CobolCallingJava example Java program
 *
 */
public class CobolCallingJava {

	private Properties _runtimeProperties;
	static private Logger 	   _log = Logger.getLogger("com.acucorp.acucobolgt.CVM");

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// Constuctor
	public CobolCallingJava( boolean val ) {
		super();
		System.setProperty( "java.util.logging.config.file", "logging.properties" );
		//_log = Logger.getLogger("com.acucorp.acucobolgt.CVM");

		cblLog( "CobolCallingJava: boolean CTOR reached: " + val );
	}

	public CobolCallingJava( char val ) {
		super();
		System.setProperty( "java.util.logging.config.file", "logging.properties" );
		//_log = Logger.getLogger("com.acucorp.acucobolgt.CVM");

		cblLog( "CobolCallingJava: char CTOR reached: " + val );
	}

	public CobolCallingJava( byte val ) {
		super();
		System.setProperty( "java.util.logging.config.file", "logging.properties" );
		//_log = Logger.getLogger("com.acucorp.acucobolgt.CVM");

		cblLog( "CobolCallingJava: byte CTOR reached: " + val );
	}

	public CobolCallingJava( short val ) {
		super();
		System.setProperty( "java.util.logging.config.file", "logging.properties" );
		//_log = Logger.getLogger("com.acucorp.acucobolgt.CVM");

		cblLog( "CobolCallingJava: short CTOR reached: " + val );
	}

	public CobolCallingJava( long val ) {
		super();
		System.setProperty( "java.util.logging.config.file", "logging.properties" );
		//_log = Logger.getLogger("com.acucorp.acucobolgt.CVM");

		cblLog( "CobolCallingJava: long CTOR reached: " + val );
	}

	public CobolCallingJava( float val ) {
		super();
		System.setProperty( "java.util.logging.config.file", "logging.properties" );
		//_log = Logger.getLogger("com.acucorp.acucobolgt.CVM");

		cblLog( "CobolCallingJava: float CTOR reached: " + val );
	}

	public CobolCallingJava( double val ) {
		super();
		System.setProperty( "java.util.logging.config.file", "logging.properties" );
		//_log = Logger.getLogger("com.acucorp.acucobolgt.CVM");

		cblLog( "CobolCallingJava: double CTOR reached: " + val );
	}

	public CobolCallingJava( int val ) {
		super();
		System.setProperty( "java.util.logging.config.file", "logging.properties" );
		//_log = Logger.getLogger("com.acucorp.acucobolgt.CVM");

		cblLog( "CobolCallingJava: int CTOR reached: " + val );
	}

	public CobolCallingJava() {
		super();
		System.setProperty( "java.util.logging.config.file", "logging.properties" );
		//_log = Logger.getLogger("com.acucorp.acucobolgt.CVM");

		cblLog("CobolCallingJava: void CTOR reached");
	}

	public CobolCallingJava( String programName ) {
		super();

		System.setProperty( "java.util.logging.config.file", "logging.properties" );
		//_log = Logger.getLogger("com.acucorp.acucobolgt.CVM");

		cblLog("CobolCallingJava: string CTOR reached");
		cblLog("CobolCallingJava:  begin load");

		_runtimeProperties = new Properties();
		System.loadLibrary("wrun32");

		String prop;
		Properties sysProps = System.getProperties();
		prop = sysProps.getProperty( "os.name" );

		setRuntimeProperty( "program.name", programName );
		setRuntimeProperty( "os.name", prop );

		setRuntimeProperty( "display", "-d" );
		setRuntimeProperty( "tty", "" );
		setRuntimeProperty( "debug", "0" );
		setRuntimeProperty( "cache", "0" );
		setRuntimeProperty( "num.params", "0" );
		setRuntimeProperty( "signal.number", "0" );
		setRuntimeProperty( "no.stop", "1" );

		cblLog( "CobolCallingJava:  end load " );
	}


/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// Log
	private void cblLog( String msg ) {
	    cblLog( Level.INFO, msg );
	}

	private void cblLog( Level level, String msg ) {
	    if( level == Level.OFF )
		return;
	    if( _log != null ) {
		_log.log( level, msg );
	    } else {
		cblLog( msg );
	    }
	}


	public void setRuntimeProperty( String key, String value ) {
		this.getDefaultProperties().setProperty( key, value );
	}

	public Properties getDefaultProperties() {
		return _runtimeProperties;
	}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// CobolCallingJavaReentrantTest

	public void CobolCallingJavaReentrantTest() {
	    cblLog( Level.INFO, "CobolCallingJavaReentrantTest: Start" );
	    Object emptyParams[] = {};
	    CVM cvm;
	    cvm = CVM.GET_INSTANCE();
	    cvm.LogNativeMessages( true );
	    CALL_OPTIONS callOpts = new CALL_OPTIONS();
	    cvm.initialize( "" );
	    //cvm.showCurrentProperties();

	    String stringInOut = new String("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
	    String stringTwo = new String("//////////////////////////////////");
	    int intInOut = 10;
	    byte byteInOut = 'a';
	    char charInOut = 'b';
	    boolean boolInOut = false;
	    short shortInOut = 11111;
	    int longInOut = 3333333;
	    //long longInOut = 3333333;
	    float floatInOut = (float)1.23456;
	    double doubleInOut = 9.87654;
	    long longType2 = 999999999;
	    long longType3 = 888888888;

	    int intArr[] = new int[5];
	    intArr[0] = 10;
	    intArr[1] = 9;
	    intArr[2] = 8;
	    intArr[3] = 7;
	    intArr[4] = 6;

	    byte byteArr[] = new byte[5];
	    byteArr[0] = 10;
	    byteArr[1] = 9;
	    byteArr[2] = 8;
	    byteArr[3] = 7;
	    byteArr[4] = 6;

	    char charArr[] = new char[5];
	    charArr[0] = 'z';
	    charArr[1] = 'y';
	    charArr[2] = 'x';
	    charArr[3] = 'w';
	    charArr[4] = 'v';

	    boolean booleanArr[] = new boolean[5];
	    booleanArr[0] = true;
	    booleanArr[1] = true;
	    booleanArr[2] = true;
	    booleanArr[3] = true;
	    booleanArr[4] = true;

	    short shortArr[] = new short[5];
	    shortArr[0] = 10;
	    shortArr[1] = 9;
	    shortArr[2] = 8;
	    shortArr[3] = 7;
	    shortArr[4] = 6;

	    long longArr[] = new long[5];
	    longArr[0] = 10;
	    longArr[1] = 9;
	    longArr[2] = 8;
	    longArr[3] = 7;
	    longArr[4] = 6;

	    float floatArr[] = new float[5];
	    floatArr[0] = (float)11.11;
	    floatArr[1] = (float)9.9;
	    floatArr[2] = (float)8.8;
	    floatArr[3] = (float)7.7;
	    floatArr[4] = (float)6.6;

	    double doubleArr[] = new double[5];
	    doubleArr[0] = 111.111;
	    doubleArr[1] = 99.99;
	    doubleArr[2] = 88.88;
	    doubleArr[3] = 77.77;
	    doubleArr[4] = 66.66;

	    Integer intObj = new Integer(intInOut);
	    Byte byteObj = new Byte(byteInOut);
	    Character charObj = new Character(charInOut);
	    Boolean boolObj = new Boolean(boolInOut);
	    Short shortObj = new Short(shortInOut);
	    Integer longObj = new Integer(longInOut);
	    //Long longObj = new Long(lngInOut);
	    Float floatObj = new Float(floatInOut);
	    Double doubleObj = new Double(doubleInOut);
	    Long longT2Obj = new Long(longType2);
	    Long longT3Obj = new Long(longType3);

	    Object params[] = { stringInOut, intObj, byteObj, charObj,
				boolObj, shortObj, longObj, floatObj,
				doubleObj, longT2Obj, longT3Obj,
				intArr, byteArr, charArr, booleanArr,
				shortArr, longArr, floatArr, doubleArr,
				stringTwo };

	    cvm.callProgram( "JavaCallingCobol", params, callOpts );
	    cblLog( Level.INFO, "CobolCallingJavaReentrantTest: Complete" );
	}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// CobolCallingJavaNV

	public int CobolCallingJavaIntNV( int cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaIntNV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + ( cmdCode+27 ) );
	    return cmdCode+27;
	}

	public boolean CobolCallingJavaBooleanNV( boolean cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaBooleanNV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + !cmdCode );
	    return !cmdCode;
	}

	public void CobolCallingJavaVoidNV() {
	    cblLog( Level.INFO, "CobolCallingJavaVoidNV input: void" );
	    cblLog( Level.INFO, "return value: void" );
	    return;
	}

	public byte CobolCallingJavaByteNV( byte cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaByteNV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + 65 );
	    return (byte)65;
	}

	public char CobolCallingJavaCharNV( char cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaCharNV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + 'B' );
	    return 'B';
	}

	public short CobolCallingJavaShortNV( short cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaShortNV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + 44 );
	    return (short)44;
	}

	public long CobolCallingJavaLongNV( long cmdCode ) {
	    long retVal = 1111111111;
	    cblLog( Level.INFO, "CobolCallingJavaLongNV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + retVal );
	    return retVal;
	}

	public float CobolCallingJavaFloatNV( float cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaFloatNV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + 77.66 );
	    return (float)77.66;
	}

	public double CobolCallingJavaDoubleNV( double cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaDoubleNV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + 88.55 );
	    return (double)88.55;
	}

	public String CobolCallingJavaStringNV( String cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaStringNV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: stringNV done" );
	    return (String)"stringNV done";
	}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// CobolCallingJavaV

	public int CobolCallingJavaIntV( int cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaIntV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + ( cmdCode+27 ) );
	    return cmdCode+27;
	}

	public boolean CobolCallingJavaBooleanV( boolean cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaBooleanV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + !cmdCode );
	    return !cmdCode;
	}

	public void CobolCallingJavaVoidV() {
	    cblLog( Level.INFO, "CobolCallingJavaVoidV input: void" );
	    cblLog( Level.INFO, "return value: void" );
	    return;
	}

	public byte CobolCallingJavaByteV( byte cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaByteV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + 65 );
	    return (byte)65;
	}

	public char CobolCallingJavaCharV( char cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaCharV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + 'B' );
	    return 'B';
	}

	public short CobolCallingJavaShortV( short cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaShortV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + 44 );
	    return (short)44;
	}

	public long CobolCallingJavaLongV( long cmdCode ) {
	    long retVal = 1111111111;
	    cblLog( Level.INFO, "CobolCallingJavaLongV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + retVal );
	    return retVal;
	}

	public float CobolCallingJavaFloatV( float cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaFloatV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + 77.66 );
	    return (float)77.66;
	}

	public double CobolCallingJavaDoubleV( double cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaDoubleV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: " + 88.55 );
	    return (double)88.55;
	}

	public String CobolCallingJavaStringV( String cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaStringV input: " + cmdCode );
	    cblLog( Level.INFO, "return value: stringV done" );
	    return (String)"stringV done";
	}

	public void CobolCallingJavaObjectV( Object cmdCode ) {
	    cblLog( Level.INFO, "CobolCallingJavaObjectV input: " + cmdCode.toString() );
	}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// Static CobolCallingJava

	public static int CobolCallingJavaInt( int cmdCode ) {
            Logger log;
            System.setProperty( "java.util.logging.config.file", "logging.properties" );
            log = Logger.getLogger("com.acucorp.acucobolgt.CVM");
	    log.log( Level.INFO, "CobolCallingJavaInt input: " + cmdCode );
	    log.log( Level.INFO, "return value: " + ( cmdCode+27 ) );
	    return cmdCode+27;
	}

	public static boolean CobolCallingJavaBoolean( boolean cmdCode ) {
            Logger log;
            System.setProperty( "java.util.logging.config.file", "logging.properties" );
            log = Logger.getLogger("com.acucorp.acucobolgt.CVM");
	    log.log( Level.INFO, "CobolCallingJavaBoolean input: " + cmdCode );
	    log.log( Level.INFO, "return value: " + !cmdCode );
	    return !cmdCode;
	}

	public static void CobolCallingJavaVoid() {
            Logger log;
            System.setProperty( "java.util.logging.config.file", "logging.properties" );
            log = Logger.getLogger("com.acucorp.acucobolgt.CVM");
	    log.log( Level.INFO, "CobolCallingJavaVoid input: void" );
	    log.log( Level.INFO, "return value: void" );
	    return;
	}

	public static byte CobolCallingJavaByte( byte cmdCode ) {
            Logger log;
            System.setProperty( "java.util.logging.config.file", "logging.properties" );
            log = Logger.getLogger("com.acucorp.acucobolgt.CVM");
	    log.log( Level.INFO, "CobolCallingJavaByte input: " + cmdCode );
	    log.log( Level.INFO, "return value: " + 65 );
	    return (byte)65;
	}

	public static char CobolCallingJavaChar( char cmdCode ) {
            Logger log;
            System.setProperty( "java.util.logging.config.file", "logging.properties" );
            log = Logger.getLogger("com.acucorp.acucobolgt.CVM");
	    log.log( Level.INFO, "CobolCallingJavaChar input: " + cmdCode );
	    log.log( Level.INFO, "return value: " + 'B' );
	    return 'B';
	}

	public static short CobolCallingJavaShort( short cmdCode ) {
            Logger log;
            System.setProperty( "java.util.logging.config.file", "logging.properties" );
            log = Logger.getLogger("com.acucorp.acucobolgt.CVM");
	    log.log( Level.INFO, "CobolCallingJavaShort input: " + cmdCode );
	    log.log( Level.INFO, "return value: " + 44 );
	    return (short)44;
	}

	public static long CobolCallingJavaLong( long cmdCode ) {
	    long retVal = 1111111111;
            Logger log;
            System.setProperty( "java.util.logging.config.file", "logging.properties" );
            log = Logger.getLogger("com.acucorp.acucobolgt.CVM");
	    log.log( Level.INFO, "CobolCallingJavaLong input: " + cmdCode );
	    log.log( Level.INFO, "return value: " + retVal );
	    return retVal;
	}

	public static float CobolCallingJavaFloat( float cmdCode ) {
            Logger log;
            System.setProperty( "java.util.logging.config.file", "logging.properties" );
            log = Logger.getLogger("com.acucorp.acucobolgt.CVM");
	    log.log( Level.INFO, "CobolCallingJavaFloat input: " + cmdCode );
	    log.log( Level.INFO, "return value: " + 77.66 );
	    return (float)77.66;
	}

	public static double CobolCallingJavaDouble( double cmdCode ) {
            Logger log;
            System.setProperty( "java.util.logging.config.file", "logging.properties" );
            log = Logger.getLogger("com.acucorp.acucobolgt.CVM");
	    log.log( Level.INFO, "CobolCallingJavaDouble input: " + cmdCode );
	    log.log( Level.INFO, "return value: " + 88.55 );
	    return (double)88.55;
	}

	public static String CobolCallingJavaString( String cmdCode ) {
            Logger log;
            System.setProperty( "java.util.logging.config.file", "logging.properties" );
            log = Logger.getLogger("com.acucorp.acucobolgt.CVM");
	    log.log( Level.INFO, "CobolCallingJavaString input: " + cmdCode );
	    log.log( Level.INFO, "return value: CobolCallingJavaString done" );
	    return (String)"CobolCallingJavaString done";
	}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// CobolCallingJavaArray

	public int CobolCallingJavaIntArray( int cmdCode[] ) {
	    cblLog( Level.INFO, "Int Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ ) {
		cblLog( Level.INFO, "int value: " + cmdCode[idx] );
		cmdCode[idx]++;
	    }
	    return 1;
	}

	public boolean CobolCallingJavaBooleanArray( boolean cmdCode[] ) {
	    cblLog( Level.INFO, "Boolean Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ ) {
		cblLog( Level.INFO, "boolean value: " + cmdCode[idx] );
		cmdCode[idx] = true;
	    }
	    return true;
	}

	public byte CobolCallingJavaByteArray( byte cmdCode[] ) {
	    cblLog( Level.INFO, "Byte Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ ) {
		cblLog( Level.INFO, "byte value: " + cmdCode[idx] );
		cmdCode[idx]++;
	    }
	    return (byte)65;
	}

	public char CobolCallingJavaCharArray( char cmdCode[] ) {
	    cblLog( Level.INFO, "Char Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ ) {
		cblLog( Level.INFO, "char value: " + cmdCode[idx] );
		cmdCode[idx] = 'Z';
	    }
	    return 'B';
	}

	public short CobolCallingJavaShortArray( short cmdCode[] ) {
	    cblLog( Level.INFO, "Short Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ ) {
		cblLog( Level.INFO, "short value: " + cmdCode[idx] );
		cmdCode[idx]++;
	    }
	    return (short)44;
	}

	public long CobolCallingJavaLongArray( long cmdCode[] ) {
	    long retVal = 1111111111;
	    cblLog( Level.INFO, "Long Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ ) {
		cblLog( Level.INFO, "long value: " + cmdCode[idx] );
		cmdCode[idx]++;
	    }
	    return retVal;
	}

	public float CobolCallingJavaFloatArray( float cmdCode[] ) {
	    cblLog( Level.INFO, "Float Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ ) {
		cblLog( Level.INFO, "float value: " + cmdCode[idx] );
		cmdCode[idx] += (float)100.0;
	    }
	    return (float)77.66;
	}

	public double CobolCallingJavaDoubleArray( double cmdCode[] ) {
	    cblLog( Level.INFO, "Double Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ ) {
		cblLog( Level.INFO, "double value: " + cmdCode[idx] );
		cmdCode[idx] += 200.0;
	    }
	    return (double)88.55;
	}

	public String CobolCallingJavaStringArray( String cmdCode[] ) {
	    cblLog( Level.INFO, "String Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ )
		cblLog( Level.INFO, "String value: " + cmdCode[idx] );
	    return (String)"CobolCallingJavaStringArray done";
	}

	public String CobolCallingJavaObjectArray( Object cmdCode[] ) {
	    cblLog( Level.INFO, "Object Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ )
		cblLog( Level.INFO, "Object value: " + cmdCode[idx].toString() );
	    return (String)"CobolCallingJavaObjectArray done";
	}

	public String CobolCallingJavaStringArrayModify( String cmdCode[] ) {
	    cblLog( Level.INFO, "String Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ ) {
		cblLog( Level.INFO, "String value: " + cmdCode[idx] );
		cmdCode[idx] = "BBBBBBBBBBBBBBBBBBBB";
	    }
	    for( int idx = 0; idx < cmdCode.length; idx++ )
		cblLog( Level.INFO, "String value: " + cmdCode[idx] );
	    return (String)"CobolCallingJavaStringArray done";
	}

}



