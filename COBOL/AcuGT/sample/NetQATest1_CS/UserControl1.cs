using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Windows.Forms;

namespace NetQATest1_CS
{
	/// <summary>
	/// Summary description for UserControl1.
	/// </summary>
	public class UserControl1 : System.Windows.Forms.UserControl
	{
	    private System.Windows.Forms.ListBox CarsList;
	    private System.Windows.Forms.ListBox AnimalsList;
	    public CCars ViewCars;
	    public CAnimals ViewAnimals;
	    string userData;
	    int userintData;
	    uint useruintData;
            float userfloatData;
	    double userdoubleData;
	    byte userbyteData;
	    short usershortintData;
	    ushort userushortintData;
	    char usercharData;

	    public event AnimalCarChanged raiseAnimalCar;
		/// <summary> 
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		
		public void CarCallback(int idxCar, string carDesc)
		{
		   raiseAnimalCar(carDesc);
		}
		
		public void AnimalCallback(int idxAnimal, string animalDesc)
		{
		    raiseAnimalCar(animalDesc);
		}
		public UserControl1()
		{
		    StartItUp();
		}
		public void StartItUp()
		{
			// This call is required by the Windows.Forms Form Designer.
			InitializeComponent();

			// TODO: Add any initialization after the InitForm call
			AnimalsList.Items.Add("cows");
			AnimalsList.Items.Add("horses");
			AnimalsList.Items.Add("pigs");
			AnimalsList.Items.Add("dogs");
			AnimalsList.Items.Add("cats");
			AnimalsList.Items.Add("lions");
			AnimalsList.Items.Add("tigers");
			AnimalsList.Items.Add("bears");
			
			CarsList.Items.Add("Ford");
			CarsList.Items.Add("GM");
			CarsList.Items.Add("Toyota");
			CarsList.Items.Add("Hundai");
			CarsList.Items.Add("Chrysler");
			CarsList.Items.Add("BMW");
			CarsList.Items.Add("Mercedes");
			CarsList.Items.Add("Peugeot");
			ViewCars = new CCars();
			ViewAnimals = new CAnimals();
			ViewAnimals.raiseAnimalChange += new AnimalsChanged(AnimalCallback);
			ViewCars.OnCarChange += new CCars.CarsChanged(CarCallback);	
		}

		public UserControl1(string userStuff, int intData, uint uintData,
		                    float floatData, double doubleData,
				    byte byteData, short shortintData,
		                    ushort ushortintData, char charData)
		{
		    userData = userStuff;
		    userintData = intData;
		    useruintData = uintData;
		    userfloatData = floatData;
		    userdoubleData = doubleData;
		    userbyteData   = byteData;
		    usershortintData = shortintData;
		    userushortintData = ushortintData;
		    usercharData = charData;
		    StartItUp();
		}
		
		
		/// <summary> 
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Component Designer generated code
		/// <summary> 
		/// Required method for Designer support - do not modify 
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
		    this.CarsList = new System.Windows.Forms.ListBox();
		    this.AnimalsList = new System.Windows.Forms.ListBox();
		    this.SuspendLayout();
		    // 
		    // CarsList
		    // 
		    this.CarsList.BackColor = System.Drawing.SystemColors.Info;
		    this.CarsList.Cursor = System.Windows.Forms.Cursors.Hand;
		    this.CarsList.Location = new System.Drawing.Point(8, 8);
		    this.CarsList.Name = "CarsList";
		    this.CarsList.Size = new System.Drawing.Size(96, 147);
		    this.CarsList.TabIndex = 0;
		    this.CarsList.SelectedValueChanged += new System.EventHandler(this.CarsList_SelectedValueChanged);
		    this.CarsList.SelectedIndexChanged += new System.EventHandler(this.CarsList_SelectedIndexChanged);
		    // 
		    // AnimalsList
		    // 
		    this.AnimalsList.BackColor = System.Drawing.SystemColors.Info;
		    this.AnimalsList.CausesValidation = false;
		    this.AnimalsList.Cursor = System.Windows.Forms.Cursors.Hand;
		    this.AnimalsList.Location = new System.Drawing.Point(128, 8);
		    this.AnimalsList.Name = "AnimalsList";
		    this.AnimalsList.Size = new System.Drawing.Size(104, 147);
		    this.AnimalsList.TabIndex = 1;
		    this.AnimalsList.SelectedValueChanged += new System.EventHandler(this.AnimalsList_SelectedValueChanged);
		    this.AnimalsList.SelectedIndexChanged += new System.EventHandler(this.AnimalsList_SelectedIndexChanged);
		    // 
		    // UserControl1
		    // 
		    this.CausesValidation = false;
		    this.Controls.Add(this.AnimalsList);
		    this.Controls.Add(this.CarsList);
		    this.Name = "UserControl1";
		    this.Size = new System.Drawing.Size(248, 168);
		    this.ResumeLayout(false);

		}
		#endregion

	    private void CarsList_SelectedValueChanged(object sender, System.EventArgs e)
	    {
	     
	    }

	    private void CarsList_SelectedIndexChanged(object sender, System.EventArgs e)
	    {
		ViewCars.TheCar = (NetQATest1_CS.CCars.cars) CarsList.SelectedIndex;
	    }

	    private void AnimalsList_SelectedValueChanged(object sender, System.EventArgs e)
	    {
	    
	    }

	    private void AnimalsList_SelectedIndexChanged(object sender, System.EventArgs e)
	    {
		ViewAnimals.myPet = (NetQATest1_CS.animals) AnimalsList.SelectedIndex;
	    }
	}
}
