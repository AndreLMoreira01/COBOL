
using System;
using System.Runtime.Remoting;

namespace WEB_SERVICE
{
   
    public class WebService : MarshalByRefObject
    {
        public String lastMsg = "";
        private int totalNumber = 0;

	public WebService()
	{
	   
	}

        public void SendMsg(String msg)
        {
            lastMsg = "WEB_SERVICE received HTTP request: ";
	    lastMsg += msg;
	    totalNumber++;
        }

        // public property
        public int TotalNumber
        {
            get 
            {
                return totalNumber;
            }

            set
            {
                lock(this)
                {
                    totalNumber = value;
                }
            }
        }

	public string LastMessage
	{
	    get 
	    {
		return lastMsg;
	    }

	}

    }
}
