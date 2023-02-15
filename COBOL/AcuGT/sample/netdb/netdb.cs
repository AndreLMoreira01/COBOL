using System;
using System.Data;
using System.Data.OleDb;


namespace NetDB
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	public class NetDB_MGR
	{
	    DataSet dataset;
	    string myConnString;
	    string query;
	    OleDbConnection conn;
	    OleDbCommand myCommand;
	    OleDbDataReader myReader;
	    String lastErrorMsg;

	    ~NetDB_MGR()
	    {
		
	    }
	    public NetDB_MGR(string DBpath, string DBquery)
	    {
		lastErrorMsg = "";
		if (DBquery.Length > 0)
		    query = DBquery;
		else
		    query = "SELECT * FROM Orders";
		try
		{
		    dataset = new DataSet();
		    myConnString = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=";
		    myConnString += DBpath;
		    conn = new OleDbConnection(myConnString);
		    myCommand = new OleDbCommand(query, conn);
		    conn.Open();
		    myReader = myCommand.ExecuteReader();
		}
		catch (System.Exception e)
		{
		    Exception innerE = e.InnerException;
		    if ((innerE != null) && (innerE.Message.Length > 0))
			lastErrorMsg = innerE.Message;
		    else
		    {
			if (e.Message.Length > 0)
			    lastErrorMsg = e.Message;
			else
			    lastErrorMsg = String.Concat("Db Connection Failed ", DBpath); 
		    }
		}
	    }

	    public bool GetNext(ref string orderNumber,
				ref string productName,
				ref int quantity)
	    {
		bool rtn = false;
		rtn = myReader.Read();
		if (rtn == true)
		{
		    orderNumber = myReader.GetString(0);
		    productName = myReader.GetString(1);
		    quantity = myReader.GetInt32(2);
		}
		else
		{
		    myReader.Close();
		    conn.Close();
		}
		return rtn;
	    }

	    public string LastErrMsg
	    {
		get { return lastErrorMsg; }
	    }
	}
}
