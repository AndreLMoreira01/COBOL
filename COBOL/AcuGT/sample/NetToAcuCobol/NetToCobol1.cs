using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace Sample1
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
	    private System.Windows.Forms.TextBox ProgramName;
	    private System.Windows.Forms.Label label1;
	    private System.Windows.Forms.TextBox Param1;
	    private System.Windows.Forms.Label label2;
	    private System.Windows.Forms.Label label3;
	    private System.Windows.Forms.TextBox Param2;
	    private System.Windows.Forms.TextBox Param3;
	    private System.Windows.Forms.TextBox Param4;
	    private System.Windows.Forms.TextBox Param5;
	    private System.Windows.Forms.TextBox Param6;
	    private System.Windows.Forms.TextBox Param7;
	    private System.Windows.Forms.TextBox Param9;
	    private System.Windows.Forms.TextBox Param8;
	    private System.Windows.Forms.Label label4;
	    private System.Windows.Forms.Label label5;
	    private System.Windows.Forms.Label label6;
	    private System.Windows.Forms.Label label7;
	    private System.Windows.Forms.Label label8;
	    private System.Windows.Forms.Label label9;
	    private System.Windows.Forms.Label label10;
	    private System.Windows.Forms.Label label11;
	    private System.Windows.Forms.Label label12;
	    private System.Windows.Forms.Label label13;
	    private System.Windows.Forms.Label label14;
	    private System.Windows.Forms.Label label15;
	    private System.Windows.Forms.TextBox Param14;
	    private System.Windows.Forms.TextBox Param13;
	    private System.Windows.Forms.TextBox Param12;
	    private System.Windows.Forms.TextBox Param11;
	    private System.Windows.Forms.TextBox Param10;
	    private System.Windows.Forms.Button ExecBtn;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public Form1()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
		    this.ProgramName = new System.Windows.Forms.TextBox();
		    this.label1 = new System.Windows.Forms.Label();
		    this.Param1 = new System.Windows.Forms.TextBox();
		    this.Param2 = new System.Windows.Forms.TextBox();
		    this.Param3 = new System.Windows.Forms.TextBox();
		    this.Param4 = new System.Windows.Forms.TextBox();
		    this.Param5 = new System.Windows.Forms.TextBox();
		    this.Param6 = new System.Windows.Forms.TextBox();
		    this.Param7 = new System.Windows.Forms.TextBox();
		    this.Param14 = new System.Windows.Forms.TextBox();
		    this.Param13 = new System.Windows.Forms.TextBox();
		    this.Param12 = new System.Windows.Forms.TextBox();
		    this.Param11 = new System.Windows.Forms.TextBox();
		    this.Param10 = new System.Windows.Forms.TextBox();
		    this.Param9 = new System.Windows.Forms.TextBox();
		    this.Param8 = new System.Windows.Forms.TextBox();
		    this.label2 = new System.Windows.Forms.Label();
		    this.label3 = new System.Windows.Forms.Label();
		    this.label4 = new System.Windows.Forms.Label();
		    this.label5 = new System.Windows.Forms.Label();
		    this.label6 = new System.Windows.Forms.Label();
		    this.label7 = new System.Windows.Forms.Label();
		    this.label8 = new System.Windows.Forms.Label();
		    this.label9 = new System.Windows.Forms.Label();
		    this.label10 = new System.Windows.Forms.Label();
		    this.label11 = new System.Windows.Forms.Label();
		    this.label12 = new System.Windows.Forms.Label();
		    this.label13 = new System.Windows.Forms.Label();
		    this.label14 = new System.Windows.Forms.Label();
		    this.label15 = new System.Windows.Forms.Label();
		    this.ExecBtn = new System.Windows.Forms.Button();
		    this.SuspendLayout();
		    // 
		    // ProgramName
		    // 
		    this.ProgramName.Location = new System.Drawing.Point(56, 24);
		    this.ProgramName.Name = "ProgramName";
		    this.ProgramName.Size = new System.Drawing.Size(336, 20);
		    this.ProgramName.TabIndex = 0;
		    this.ProgramName.Text = "";
		    // 
		    // label1
		    // 
		    this.label1.Location = new System.Drawing.Point(176, 8);
		    this.label1.Name = "label1";
		    this.label1.Size = new System.Drawing.Size(88, 16);
		    this.label1.TabIndex = 1;
		    this.label1.Text = "Program Name";
		    // 
		    // Param1
		    // 
		    this.Param1.Location = new System.Drawing.Point(8, 64);
		    this.Param1.Name = "Param1";
		    this.Param1.Size = new System.Drawing.Size(192, 20);
		    this.Param1.TabIndex = 2;
		    this.Param1.Text = "";
		    // 
		    // Param2
		    // 
		    this.Param2.Location = new System.Drawing.Point(8, 96);
		    this.Param2.Name = "Param2";
		    this.Param2.Size = new System.Drawing.Size(192, 20);
		    this.Param2.TabIndex = 3;
		    this.Param2.Text = "";
		    // 
		    // Param3
		    // 
		    this.Param3.Location = new System.Drawing.Point(8, 128);
		    this.Param3.Name = "Param3";
		    this.Param3.Size = new System.Drawing.Size(192, 20);
		    this.Param3.TabIndex = 4;
		    this.Param3.Text = "";
		    // 
		    // Param4
		    // 
		    this.Param4.Location = new System.Drawing.Point(8, 160);
		    this.Param4.Name = "Param4";
		    this.Param4.Size = new System.Drawing.Size(192, 20);
		    this.Param4.TabIndex = 5;
		    this.Param4.Text = "";
		    // 
		    // Param5
		    // 
		    this.Param5.Location = new System.Drawing.Point(8, 192);
		    this.Param5.Name = "Param5";
		    this.Param5.Size = new System.Drawing.Size(192, 20);
		    this.Param5.TabIndex = 6;
		    this.Param5.Text = "";
		    // 
		    // Param6
		    // 
		    this.Param6.Location = new System.Drawing.Point(8, 224);
		    this.Param6.Name = "Param6";
		    this.Param6.Size = new System.Drawing.Size(192, 20);
		    this.Param6.TabIndex = 7;
		    this.Param6.Text = "";
		    // 
		    // Param7
		    // 
		    this.Param7.Location = new System.Drawing.Point(8, 256);
		    this.Param7.Name = "Param7";
		    this.Param7.Size = new System.Drawing.Size(192, 20);
		    this.Param7.TabIndex = 8;
		    this.Param7.Text = "";
		    // 
		    // Param14
		    // 
		    this.Param14.Location = new System.Drawing.Point(256, 256);
		    this.Param14.Name = "Param14";
		    this.Param14.Size = new System.Drawing.Size(192, 20);
		    this.Param14.TabIndex = 15;
		    this.Param14.Text = "";
		    // 
		    // Param13
		    // 
		    this.Param13.Location = new System.Drawing.Point(256, 224);
		    this.Param13.Name = "Param13";
		    this.Param13.Size = new System.Drawing.Size(192, 20);
		    this.Param13.TabIndex = 14;
		    this.Param13.Text = "";
		    // 
		    // Param12
		    // 
		    this.Param12.Location = new System.Drawing.Point(256, 192);
		    this.Param12.Name = "Param12";
		    this.Param12.Size = new System.Drawing.Size(192, 20);
		    this.Param12.TabIndex = 13;
		    this.Param12.Text = "";
		    // 
		    // Param11
		    // 
		    this.Param11.Location = new System.Drawing.Point(256, 160);
		    this.Param11.Name = "Param11";
		    this.Param11.Size = new System.Drawing.Size(192, 20);
		    this.Param11.TabIndex = 12;
		    this.Param11.Text = "";
		    // 
		    // Param10
		    // 
		    this.Param10.Location = new System.Drawing.Point(256, 128);
		    this.Param10.Name = "Param10";
		    this.Param10.Size = new System.Drawing.Size(192, 20);
		    this.Param10.TabIndex = 11;
		    this.Param10.Text = "";
		    // 
		    // Param9
		    // 
		    this.Param9.Location = new System.Drawing.Point(256, 96);
		    this.Param9.Name = "Param9";
		    this.Param9.Size = new System.Drawing.Size(192, 20);
		    this.Param9.TabIndex = 10;
		    this.Param9.Text = "";
		    // 
		    // Param8
		    // 
		    this.Param8.Location = new System.Drawing.Point(256, 64);
		    this.Param8.Name = "Param8";
		    this.Param8.Size = new System.Drawing.Size(192, 20);
		    this.Param8.TabIndex = 9;
		    this.Param8.Text = "";
		    // 
		    // label2
		    // 
		    this.label2.Location = new System.Drawing.Point(208, 64);
		    this.label2.Name = "label2";
		    this.label2.Size = new System.Drawing.Size(16, 16);
		    this.label2.TabIndex = 16;
		    this.label2.Text = "1";
		    // 
		    // label3
		    // 
		    this.label3.Location = new System.Drawing.Point(208, 96);
		    this.label3.Name = "label3";
		    this.label3.Size = new System.Drawing.Size(16, 16);
		    this.label3.TabIndex = 17;
		    this.label3.Text = "2";
		    // 
		    // label4
		    // 
		    this.label4.Location = new System.Drawing.Point(208, 128);
		    this.label4.Name = "label4";
		    this.label4.Size = new System.Drawing.Size(16, 16);
		    this.label4.TabIndex = 18;
		    this.label4.Text = "3";
		    // 
		    // label5
		    // 
		    this.label5.Location = new System.Drawing.Point(208, 160);
		    this.label5.Name = "label5";
		    this.label5.Size = new System.Drawing.Size(16, 16);
		    this.label5.TabIndex = 19;
		    this.label5.Text = "4";
		    // 
		    // label6
		    // 
		    this.label6.Location = new System.Drawing.Point(208, 192);
		    this.label6.Name = "label6";
		    this.label6.Size = new System.Drawing.Size(16, 16);
		    this.label6.TabIndex = 20;
		    this.label6.Text = "5";
		    // 
		    // label7
		    // 
		    this.label7.Location = new System.Drawing.Point(208, 224);
		    this.label7.Name = "label7";
		    this.label7.Size = new System.Drawing.Size(16, 16);
		    this.label7.TabIndex = 21;
		    this.label7.Text = "6";
		    // 
		    // label8
		    // 
		    this.label8.Location = new System.Drawing.Point(208, 256);
		    this.label8.Name = "label8";
		    this.label8.Size = new System.Drawing.Size(16, 16);
		    this.label8.TabIndex = 22;
		    this.label8.Text = "7";
		    // 
		    // label9
		    // 
		    this.label9.Location = new System.Drawing.Point(456, 64);
		    this.label9.Name = "label9";
		    this.label9.Size = new System.Drawing.Size(16, 16);
		    this.label9.TabIndex = 23;
		    this.label9.Text = "8";
		    // 
		    // label10
		    // 
		    this.label10.Location = new System.Drawing.Point(456, 96);
		    this.label10.Name = "label10";
		    this.label10.Size = new System.Drawing.Size(16, 16);
		    this.label10.TabIndex = 24;
		    this.label10.Text = "9";
		    // 
		    // label11
		    // 
		    this.label11.Location = new System.Drawing.Point(456, 128);
		    this.label11.Name = "label11";
		    this.label11.Size = new System.Drawing.Size(24, 16);
		    this.label11.TabIndex = 25;
		    this.label11.Text = "10";
		    // 
		    // label12
		    // 
		    this.label12.Location = new System.Drawing.Point(456, 160);
		    this.label12.Name = "label12";
		    this.label12.Size = new System.Drawing.Size(24, 16);
		    this.label12.TabIndex = 26;
		    this.label12.Text = "11";
		    // 
		    // label13
		    // 
		    this.label13.Location = new System.Drawing.Point(456, 192);
		    this.label13.Name = "label13";
		    this.label13.Size = new System.Drawing.Size(24, 16);
		    this.label13.TabIndex = 27;
		    this.label13.Text = "12";
		    // 
		    // label14
		    // 
		    this.label14.Location = new System.Drawing.Point(456, 224);
		    this.label14.Name = "label14";
		    this.label14.Size = new System.Drawing.Size(24, 16);
		    this.label14.TabIndex = 28;
		    this.label14.Text = "13";
		    // 
		    // label15
		    // 
		    this.label15.Location = new System.Drawing.Point(456, 256);
		    this.label15.Name = "label15";
		    this.label15.Size = new System.Drawing.Size(24, 16);
		    this.label15.TabIndex = 29;
		    this.label15.Text = "14";
		    // 
		    // ExecBtn
		    // 
		    this.ExecBtn.Location = new System.Drawing.Point(192, 296);
		    this.ExecBtn.Name = "ExecBtn";
		    this.ExecBtn.TabIndex = 30;
		    this.ExecBtn.Text = "Execute";
		    this.ExecBtn.Click += new System.EventHandler(this.ExecBtn_Click);
		    // 
		    // Form1
		    // 
		    this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
		    this.ClientSize = new System.Drawing.Size(488, 332);
		    this.Controls.Add(this.ExecBtn);
		    this.Controls.Add(this.label15);
		    this.Controls.Add(this.label14);
		    this.Controls.Add(this.label13);
		    this.Controls.Add(this.label12);
		    this.Controls.Add(this.label11);
		    this.Controls.Add(this.label10);
		    this.Controls.Add(this.label9);
		    this.Controls.Add(this.label8);
		    this.Controls.Add(this.label7);
		    this.Controls.Add(this.label6);
		    this.Controls.Add(this.label5);
		    this.Controls.Add(this.label4);
		    this.Controls.Add(this.label3);
		    this.Controls.Add(this.label2);
		    this.Controls.Add(this.Param14);
		    this.Controls.Add(this.Param13);
		    this.Controls.Add(this.Param12);
		    this.Controls.Add(this.Param11);
		    this.Controls.Add(this.Param10);
		    this.Controls.Add(this.Param9);
		    this.Controls.Add(this.Param8);
		    this.Controls.Add(this.Param7);
		    this.Controls.Add(this.Param6);
		    this.Controls.Add(this.Param5);
		    this.Controls.Add(this.Param4);
		    this.Controls.Add(this.Param3);
		    this.Controls.Add(this.Param2);
		    this.Controls.Add(this.Param1);
		    this.Controls.Add(this.label1);
		    this.Controls.Add(this.ProgramName);
		    this.Name = "Form1";
		    this.Text = "Form1";
		    this.Load += new System.EventHandler(this.Form1_Load);
		    this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new Form1());
		}

	    private void Form1_Load(object sender, System.EventArgs e)
	    {
	    
	    }

	    
	    private void ExecBtn_Click(object sender, System.EventArgs e)
	    {
		object arg0 = null;
		object arg1 = null;
		object arg2 = null;
		object arg3 = null;
		object arg4 = null;
		object arg5 = null;
		object arg6 = null;
		object arg7 = null;
		object arg8 = null;
		object arg9 = null;
		object arg10 = null;
		object arg11 = null;
		object arg12 = null;
		object arg13 = null;
		object arg14 = null;
		object init  = null;
	    
		if (ProgramName.Text.Length == 0)
		{
		    MessageBox.Show ("Program Name Missing", "Error", 
			MessageBoxButtons.OK, MessageBoxIcon.Error);

		    return;
		}
		arg0 =  ProgramName.Text;
		if (Param1.Text.Length > 0)
		    arg1 = Param1.Text;
		if (Param2.Text.Length > 0)
		    arg2 = Param2.Text;
		if (Param3.Text.Length > 0)
		    arg3 = Param3.Text;
		if (Param4.Text.Length > 0)
		    arg4 = Param4.Text;
		if (Param5.Text.Length > 0)
		    arg5 = Param5.Text;
		if (Param6.Text.Length > 0)
		    arg6 = Param6.Text;
		if (Param7.Text.Length > 0)
		    arg7 = Param7.Text;
		if (Param8.Text.Length > 0)
		    arg8 = Param8.Text;
		if (Param9.Text.Length > 0)
		    arg9 = Param9.Text;
		if (Param10.Text.Length > 0)
		    arg10 = Param10.Text;
		if (Param11.Text.Length > 0)
		    arg11 = Param11.Text;
		if (Param12.Text.Length > 0)
		    arg12 = Param12.Text;
		if (Param13.Text.Length > 0)
		    arg13 = Param13.Text;
		if (Param14.Text.Length > 0)
		    arg14 = Param14.Text;
	   
		AcuGTObjects.AcuGTClass AcugtInterface = new AcuGTObjects.AcuGTClass();
		AcugtInterface.Initialize(ref init);
		AcugtInterface.Call(ref arg0,
					ref arg1,
					ref arg2,
					ref arg3,
					ref arg4,
					ref arg5,
					ref arg6,
					ref arg7,
					ref arg8,
					ref arg9,
					ref arg10,
					ref arg11,
					ref arg12,
					ref arg13,
					ref arg14);
		if (arg1 != null)  
		    Param1.Text = arg1.ToString();
		if (arg2 != null)
		    Param2.Text = arg2.ToString();
		if (arg3 != null)
		    Param3.Text = arg3.ToString();
		if (arg4 != null)
		    Param4.Text = arg4.ToString();
		if (arg5 != null)
		    Param5.Text = arg5.ToString();
		if (arg6 != null)
		    Param6.Text = arg6.ToString();
		if (arg7 != null)
		    Param7.Text = arg7.ToString();
		if (arg8 != null)
		    Param8.Text = arg8.ToString();
		if (arg9 != null)
		    Param9.Text = arg9.ToString();
		if (arg10 != null)
		    Param10.Text = arg10.ToString();
		if (arg11 != null)
		    Param11.Text = arg11.ToString();
		if (arg12 != null)
		    Param12.Text = arg12.ToString();
		if (arg13 != null)
		    Param13.Text = arg13.ToString();
		if (arg14 != null)
		    Param14.Text = arg14.ToString();
		AcugtInterface.Shutdown();    
		
	    }
	}
}
