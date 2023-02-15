/*
 * Created on March 11, 2005
 *
 */

import java.io.*;
import java.util.*;
import java.util.logging.*;
import com.acucorp.acucobolgt.*;

/**
 * JavaCallingCobol sample Java program
 *
 */
public class JavaCallingCobol {

	private static Logger _log;

	public JavaCallingCobol() {
		super();
	}


/////////////////////////////////////////////////////////////////////////////
//main
/////////////////////////////////////////////////////////////////////////////
	public static void main(String[] args)  throws IOException {

	    try{
		String tmp = new String();

		System.setProperty( "java.util.logging.config.file", "logging.properties" );
		_log = Logger.getLogger("com.acucorp.acucobolgt.CVM");

		if( args.length == 0 )
		{
		    _log.info("no argument specified");
		    _log.info("end");
		    return;
		}

		//_log.info( "num cl args: " + args.length );
		for( int idx = 0; idx < args.length; idx++ )
		{
		    //_log.info( "arg[" + idx + "] --> [" + args[idx] + "]" );
		    tmp += args[idx] + " ";
		}
		//_log.info( "command line: " + tmp );

		System.setProperty( "line.separator", "\r\n" );
		//_log.info(" ");
		_log.info("******************************************");
		_log.info("** Start Sample **************************");
		_log.info("******************************************");
		_log.info("******************************************");
		_log.info(" ");

/////////////////////////////////////////////////////////////////////////////
// cvm
/////////////////////////////////////////////////////////////////////////////
		if( args[0].equals("cvm") ) {
		    CVM cvm;
		    cvm = CVM.GET_INSTANCE();
		    cvm.LogNativeMessages( true );

		    //cvm.showCurrentProperties();
		    String prop;
		    Properties props = System.getProperties();

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** System Properties *********************");
		    _log.info(" ");
		    for (Enumeration e = props.propertyNames() ; e.hasMoreElements() ;) {
			prop = e.nextElement().toString();
			_log.info("PROPERTY: [" + prop + "] VALUE: [" + props.getProperty(prop) + "]");
		    }
		    _log.info(" ");
		    _log.info("** System Properties End *****************");
		    _log.info("******************************************");
		    _log.info(" ");

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

		    Object emptyParams[] = {};

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Log Parameter Objects *****************");
		    _log.info("******************************************");
		    _log.info("******************************************");
		    _log.info(" ");

		    int retval = cvm.logParams( params );

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Java to Cobol Input *******************");
		    _log.info("******************************************");
		    _log.info("******************************************");
		    _log.info(" ");

		    _log.info("String: " + stringInOut);
		    _log.info("Int: " + intInOut);
		    _log.info("Byte: " + byteInOut);
		    _log.info("Char: " + charInOut);
		    _log.info("Bool: " + boolInOut);
		    _log.info("Short: " + shortInOut);
		    _log.info("Long: " + longInOut);
		    _log.info("Float: " + floatInOut);
		    _log.info("Double: " + doubleInOut);
		    _log.info("LongT2: " + longType2);
		    _log.info("LongT3: " + longType3);
		    _log.info("String: " + stringTwo);

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Array Type Input **********************");
		    _log.info("******************************************");
		    _log.info(" ");

		    _log.info("IntArray: " + intArr[0]);
		    _log.info("IntArray: " + intArr[1]);
		    _log.info("IntArray: " + intArr[2]);
		    _log.info("IntArray: " + intArr[3]);
		    _log.info("IntArray: " + intArr[4]);

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Array Type Input **********************");
		    _log.info("******************************************");
		    _log.info(" ");

		    _log.info("Byte Array: " + byteArr[0]);
		    _log.info("Byte Array: " + byteArr[1]);
		    _log.info("Byte Array: " + byteArr[2]);
		    _log.info("Byte Array: " + byteArr[3]);
		    _log.info("Byte Array: " + byteArr[4]);

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Array Type Input **********************");
		    _log.info("******************************************");
		    _log.info(" ");

		    _log.info("Char Array: " + charArr[0]);
		    _log.info("Char Array: " + charArr[1]);
		    _log.info("Char Array: " + charArr[2]);
		    _log.info("Char Array: " + charArr[3]);
		    _log.info("Char Array: " + charArr[4]);

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Array Type Input **********************");
		    _log.info("******************************************");
		    _log.info(" ");

		    _log.info("Boolean Array: " + booleanArr[0]);
		    _log.info("Boolean Array: " + booleanArr[1]);
		    _log.info("Boolean Array: " + booleanArr[2]);
		    _log.info("Boolean Array: " + booleanArr[3]);
		    _log.info("Boolean Array: " + booleanArr[4]);

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Array Type Input **********************");
		    _log.info("******************************************");
		    _log.info(" ");

		    _log.info("Short Array: " + shortArr[0]);
		    _log.info("Short Array: " + shortArr[1]);
		    _log.info("Short Array: " + shortArr[2]);
		    _log.info("Short Array: " + shortArr[3]);
		    _log.info("Short Array: " + shortArr[4]);

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Array Type Input **********************");
		    _log.info("******************************************");
		    _log.info(" ");

		    _log.info("Long Array: " + longArr[0]);
		    _log.info("Long Array: " + longArr[1]);
		    _log.info("Long Array: " + longArr[2]);
		    _log.info("Long Array: " + longArr[3]);
		    _log.info("Long Array: " + longArr[4]);

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Array Type Input **********************");
		    _log.info("******************************************");
		    _log.info(" ");

		    _log.info("Float Array: " + floatArr[0]);
		    _log.info("Float Array: " + floatArr[1]);
		    _log.info("Float Array: " + floatArr[2]);
		    _log.info("Float Array: " + floatArr[3]);
		    _log.info("Float Array: " + floatArr[4]);

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Array Type Input **********************");
		    _log.info("******************************************");
		    _log.info(" ");

		    _log.info("Double Array: " + doubleArr[0]);
		    _log.info("Double Array: " + doubleArr[1]);
		    _log.info("Double Array: " + doubleArr[2]);
		    _log.info("Double Array: " + doubleArr[3]);
		    _log.info("Double Array: " + doubleArr[4]);

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("**Calling JavaCallingCobol ***************");
		    _log.info("******************************************");
		    _log.info("******************************************");
		    _log.info(" ");

		    cvm.setErrorsOut( "localErrFile" );
         	    cvm.setListConfig(true);
	            cvm.setConfigFile("config");
		    CALL_OPTIONS callOpts = new CALL_OPTIONS();
		    cvm.initialize();
		    cvm.callProgram( "JavaCallingCobol", params, callOpts );
		    Class cls;
		    Class cls1;
		    String name;
		    Object obj;

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Java to Cobol Output ******************");
		    _log.info("******************************************");
		    _log.info("******************************************");
		    _log.info(" ");

		    for( int idx = 0; idx < params.length; idx++  ) {
		        cls = params[idx].getClass();
		        name = cls.getName();

			if( name.charAt(0) != '[' ) {
			    _log.info("param class name: " + name);
			    _log.info("param value: " + params[idx].toString());
			    continue;
			} else {
			    _log.info(" ");
			    _log.info("******************************************");
			    _log.info("** Array Type Output *********************");
			    _log.info("******************************************");
			    _log.info(" ");
			    for( int idx1 = 0; idx1 < java.lang.reflect.Array.getLength( params[idx] ); idx1++ ) {
				obj = java.lang.reflect.Array.get( params[idx], idx1 );
				cls1 = obj.getClass();
				name = cls1.getName();
				_log.info("param class name: " + name);
				_log.info("param value: " + obj.toString());
			    }
			}

		    }

		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Calling CobolCallingJava **************");
		    _log.info("******************************************");
		    _log.info("******************************************");
		    _log.info(" ");

		    cvm.callProgram( "CobolCallingJava", emptyParams, callOpts );

		    cvm.shutdown();
		    _log.info("shutdown complete");

		    _log.info("calling cobol end");
		}
/////////////////////////////////////////////////////////////////////////////
// properties
/////////////////////////////////////////////////////////////////////////////
		else if( args[0].equals("props") ) {
		    _log.info("properties start");

		    String prop;
		    Properties props = System.getProperties();

		    _log.info("******************** System Properties ********************");
		    for (Enumeration e = props.propertyNames() ; e.hasMoreElements() ;) {
			prop = e.nextElement().toString();
			_log.info("PROPERTY: [" + prop + "] VALUE: [" + props.getProperty(prop) + "]");
			//_log.info("PROPERTY: [" + prop + "]");
			//_log.info("VALUE: [" + props.getProperty(prop) + "]");
		    }
		    _log.info("properties end");
		}
/////////////////////////////////////////////////////////////////////////////
//directions
/////////////////////////////////////////////////////////////////////////////
		else {
		    _log.info(" ");
		    _log.info("******************************************");
		    _log.info("** Sample Options ************************");
		    _log.info("******************************************");
		    _log.info("props, cvm");
		    _log.info("******************************************");
		    _log.info("******************************************");
		    _log.info(" ");
		}
	    }
	    catch ( Exception e ) {
			_log.info("exception caught");
			_log.info(e.getMessage());
			_log.info( e.getMessage() );
			_log.info("end");
	    }
	    _log.info(" ");
	    _log.info("******************************************");
	    _log.info("** Sample Complete ***********************");
	    _log.info("******************************************");
	    _log.info("******************************************");
	    _log.info(" ");
	}

}
