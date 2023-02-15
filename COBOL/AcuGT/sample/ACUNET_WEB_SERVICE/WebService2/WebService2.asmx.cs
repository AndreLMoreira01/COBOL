using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Web;
using System.Web.Services;

namespace WebService2
{
	/// <summary>
	/// Summary description for Service1.
	/// </summary>
	public class Service2 : System.Web.Services.WebService
	{
		
		public Service2()
		{
		    //CODEGEN: This call is required by the ASP.NET Web Services Designer
		    InitializeComponent();
		}

		#region Component Designer generated code
		
		//Required by the Web Services Designer 
		private IContainer components = null;
				
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if(disposing && components != null)
			{
				components.Dispose();
			}
			base.Dispose(disposing);		
		}
		
		#endregion

		[ WebMethod ]
		public void SendMsg(String msg)
		{
		    string temp = "WebService2 received HTTP request: ";
		    temp += msg;
		    Application.Lock();
		    Application["Message"] = temp;
		    if  (Application["GlobalCounter"] != null )
			Application["GlobalCounter"] = ((int)Application["GlobalCounter"]) + 1;
		    else
			Application["GlobalCounter"] =  (int) 1;
		    Application.UnLock();
		}

		[ WebMethod ]
		public int get_TotalNumber()
		{   
		    int i = (int) Application["GlobalCounter"];
		    return i; 
		}

		[ WebMethod ]
		public string get_LastMessage()
		{
		    string temp = (string) Application["Message"];
		    return temp;
		}

	}
}
