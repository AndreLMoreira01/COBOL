using System;
using System.IO;
using System.Text;
using System.Reflection;

namespace NetQATest1_CS
{
	/// <summary>
	/// Acucorp QA test for non windowed .NET assembly
	/// Tests classes, properties, enums, events, and functions 
	/// </summary>
	
	public enum animals : int
	{
	    cows,
	    horses,
	    pigs,
	    dogs,
	    cats,
	    lions,
	    tigers,
	    bears
	}
	
	public delegate void AnimalsChanged(int animal, string desc);
	public delegate void AnimalCarChanged(string desc);
	
	public class CAnimals
	{
	// test functions, non nested events, properties
	
	    StreamWriter w;
	    int iterations;
	    public animals pets;
	    
	    public string [] animalNames = new string []
	    {
		"cows",
		"horses",
		"pigs",
		"dogs",
		"cats",
		"lions",
		"tigers",
		"bears"
	    };
	    
	    public CAnimals()
	    {
	        w = new StreamWriter("NetQATest1Log.txt");
	        iterations = 1;	
	    }
		
	    public CAnimals(int duplines)
	    {
		w = new StreamWriter("NetQATest1Log.txt");
		iterations = duplines;	
	    }
	    
	    ~CAnimals()
	    {
		w.Close();
	    }
	    
	    public event AnimalsChanged raiseAnimalChange;
	    
	    public animals myPet
	    {
		get { return pets; }
		set 
		{ 
		    pets =  value;
		    raiseAnimalChange((int) pets, animalNames[(int) pets]);
		    ToLog(animalNames[(int) pets]);
		}
	    }
	    
	    public int printIteration
	    {
		get { return iterations; }
		set { iterations = value; }
	    }
	    
	    public int TestInOut( ref int IntInOut1, ref string StringInOut, ref int IntInOut2)
	    {
		w.WriteLine("Client called CAnimals::TestInOut() with msg: " +
			IntInOut1.ToString() + StringInOut + IntInOut2.ToString());
		w.Flush();
		
		IntInOut1 = 9999;
		StringInOut = "Lions and Tigers and Bears";
		IntInOut2 = 8888;
		return 100;
	    }
		
	    public int ToLog(string StringIn)
	    {
		int i; 
		for ( i = 0; i <  iterations; i++)
		{
		    w.WriteLine("Client called CAnimals::ToLog() with msg: " + StringIn);
		}
		w.Flush();
		return 1;
	    }
		
	}
	
	public class CCars
	{
	    StreamWriter w;
	    int iterations = 1;
	    cars lastCar;
	    
	    // test nested delegates and events
	    
	    public CCars()
	    {
		w = new StreamWriter("NetQATest2Log.txt");
	    }
	    
	    ~CCars()
	    {
		w.Close();
	    }
	    
	    public enum cars : int
	    {
		Ford,
		GM,
		Toyota,
		Hundai,
		Chrysler,
		BMW,
		Mercedes,
		Puegot
	    }
	    
	    public string [] carNames = new string []
	    {
		"Ford",
		"GM",
		"Toyota",
		"Hundai",
		"Chrysler",
		"BMW",
		"Mercedes",
		"Puegot"
	    };
	
	    public delegate void CarsChanged(int car, string desc);
	    public event CarsChanged OnCarChange;
	    
	    public cars TheCar
	    {
		get { return lastCar; }
		set 
		{ 
		    lastCar =  value;
		    OnCarChange((int) lastCar, carNames[(int) lastCar]);
		    ToLog(carNames[(int) lastCar]);
		}
	    }
	
	    public int ToLog(string StringIn)
	    {
		int i; 
		for ( i = 0; i <  iterations; i++)
		{
		    w.WriteLine("Client called CCars::ToLog() with msg: " + StringIn);
		}
		w.Flush();
		return 1;
	    }
		
	
	}
}
