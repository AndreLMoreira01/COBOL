
using System;
namespace WebClient2
{
    
    public class WebClient2
    {
	int totalNumber = 0;
	
    
	public WebClient2()
	{
	    
	}

	public delegate void CounterString(string stringParam); 
	public event CounterString fireCounter;

	public void TalkToService()
	{
	    string msg;
	    int j;
	    string curMsg;
	
	    Service2 web = new Service2();
	    web.SendMsg("Client to WebService2");

	    // Retrieve the name from the activated object
	    if (fireCounter != null)
	    {
		curMsg = web.get_LastMessage();
		fireCounter("response: " + curMsg);
	    }

	    // Perform a series of calls on the object
	    for (int i=0; i < 7; i++)
	    {
		msg = "Client to WebService2 msg #";
		j = i + 1;
		msg += j.ToString();
		web.SendMsg(msg);
		if (fireCounter != null)
		{
		    curMsg = web.get_LastMessage();
		    fireCounter("response: " + curMsg);
		}
	    }
	    totalNumber = web.get_TotalNumber();
	    if (fireCounter != null)
		fireCounter("Total Messages sent " + totalNumber.ToString());
	}   
    }
}

