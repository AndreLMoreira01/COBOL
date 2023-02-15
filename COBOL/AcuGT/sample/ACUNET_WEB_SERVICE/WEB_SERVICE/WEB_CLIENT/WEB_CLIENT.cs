
using System;
using System.Windows.Forms;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels.Http;
using System.Security.Policy;
using System.Threading;

using WEB_SERVICE;


public class WebClient
{
    int totalNumber = 0;
    
    public delegate void CounterString(string stringParam);
    public event CounterString fireCounter;
    
    public WebClient()
    {
    }

    public void TalkToService()
    {
	string msg;
	int j;
	string curMsg;
	// Load the Http Channel from the config file
	try
	{
	    RemotingConfiguration.Configure("WebClient.config");
	    
	}
	catch (System.Exception e)
	{
	}
	WebService web = new WebService();
	web.SendMsg("The Client Has Arrived");

	// Retrieve the name from the activated object
	if (fireCounter != null)
	{
	    curMsg = web.LastMessage;
	    fireCounter("response: " + curMsg);
	}

	// Perform a series of calls on the object
	for (int i=0; i < 5; i++)
	{
	    msg = "Client Message number ";
	    j = i + 1;
	    msg += j.ToString();
	    web.SendMsg(msg);
	    if (fireCounter != null)
	    {
		curMsg = web.LastMessage;
		fireCounter("response: " + curMsg);
	    }
	}
	totalNumber = web.TotalNumber;
	if (fireCounter != null)
	    fireCounter("Total Messages sent " + totalNumber.ToString());
    }   
}

