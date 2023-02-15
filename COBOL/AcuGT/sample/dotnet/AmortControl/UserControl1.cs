using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Windows.Forms;

namespace AmortControl
{
	public delegate void CalcFired();
	/// <summary>
	/// Summary description for UserControl1.
	/// </summary>
	public class UserControl1 : System.Windows.Forms.UserControl
	{
		string strTotalPayment = "";
		string strTotalInterest = "";
		string strMonthPayment = "";
		string strWhatTotalPayment = "";
		string strWhatTotalInterest = "";
		string strWhatMonths = "";
		
		public event CalcFired FireCalc;
		private System.Windows.Forms.Panel panel1;
		private System.Windows.Forms.Splitter splitter1;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.GroupBox groupBox1;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.GroupBox groupBox2;
		private System.Windows.Forms.Label label7;
		private System.Windows.Forms.Label label8;
		private System.Windows.Forms.Label label9;
		private System.Windows.Forms.GroupBox groupBox3;
		private System.Windows.Forms.ListView listView1;
		public System.Windows.Forms.ColumnHeader columnHeader1;
		private System.Windows.Forms.ColumnHeader columnHeader2;
		private System.Windows.Forms.ColumnHeader columnHeader3;
		private System.Windows.Forms.ColumnHeader columnHeader4;
		private System.Windows.Forms.ColumnHeader columnHeader5;
		private System.Windows.Forms.ColumnHeader columnHeader6;
		private System.Windows.Forms.TextBox inMonths;
		private System.Windows.Forms.TextBox inAmount;
		private System.Windows.Forms.TextBox inRate;
		private System.Windows.Forms.TextBox payMonth;
		private System.Windows.Forms.TextBox payInterest;
		private System.Windows.Forms.TextBox payTotal;
		private System.Windows.Forms.TextBox whatPayment;
		private System.Windows.Forms.TextBox whatInterest;
		private System.Windows.Forms.TextBox whatAmount;
		private System.Windows.Forms.Label whatMonths;
		private System.Windows.Forms.TextBox whatNumMonths;
		private System.Windows.Forms.Button calcBtn;
		private System.Windows.Forms.ColumnHeader columnHeader7;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public UserControl1()
		{
			// This call is required by the Windows.Forms Form Designer.
			InitializeComponent();

			// TODO: Add any initialization after the InitForm call

		}
	
		public string TotalInterest
		{
		    get { return strTotalInterest; }
		}
		
		public string TotalPayment
		{
		    get { return strTotalPayment; }
		}
		
		public string MonthPayment
		{
		    get { return strMonthPayment; }
		}
		
		public string WhatIfTotalInterest
		{
		    get { return strWhatTotalInterest; }
		}
		
		public string  WhatIfTotalPayment
		{
		    get { return strWhatTotalPayment; }
		}
		
		public string  WhatIfMonths
		{
		    get { return strWhatMonths; }
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if( components != null )
					components.Dispose();
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
		    this.panel1 = new System.Windows.Forms.Panel();
		    this.calcBtn = new System.Windows.Forms.Button();
		    this.whatPayment = new System.Windows.Forms.TextBox();
		    this.whatInterest = new System.Windows.Forms.TextBox();
		    this.whatAmount = new System.Windows.Forms.TextBox();
		    this.label7 = new System.Windows.Forms.Label();
		    this.label8 = new System.Windows.Forms.Label();
		    this.label9 = new System.Windows.Forms.Label();
		    this.groupBox3 = new System.Windows.Forms.GroupBox();
		    this.whatNumMonths = new System.Windows.Forms.TextBox();
		    this.whatMonths = new System.Windows.Forms.Label();
		    this.payTotal = new System.Windows.Forms.TextBox();
		    this.payInterest = new System.Windows.Forms.TextBox();
		    this.payMonth = new System.Windows.Forms.TextBox();
		    this.label6 = new System.Windows.Forms.Label();
		    this.label5 = new System.Windows.Forms.Label();
		    this.label4 = new System.Windows.Forms.Label();
		    this.groupBox1 = new System.Windows.Forms.GroupBox();
		    this.label3 = new System.Windows.Forms.Label();
		    this.inAmount = new System.Windows.Forms.TextBox();
		    this.label1 = new System.Windows.Forms.Label();
		    this.label2 = new System.Windows.Forms.Label();
		    this.inMonths = new System.Windows.Forms.TextBox();
		    this.inRate = new System.Windows.Forms.TextBox();
		    this.groupBox2 = new System.Windows.Forms.GroupBox();
		    this.splitter1 = new System.Windows.Forms.Splitter();
		    this.listView1 = new System.Windows.Forms.ListView();
		    this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
		    this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
		    this.columnHeader3 = new System.Windows.Forms.ColumnHeader();
		    this.columnHeader4 = new System.Windows.Forms.ColumnHeader();
		    this.columnHeader5 = new System.Windows.Forms.ColumnHeader();
		    this.columnHeader6 = new System.Windows.Forms.ColumnHeader();
		    this.columnHeader7 = new System.Windows.Forms.ColumnHeader();
		    this.panel1.SuspendLayout();
		    this.groupBox3.SuspendLayout();
		    this.groupBox1.SuspendLayout();
		    this.SuspendLayout();
		    // 
		    // panel1
		    // 
		    this.panel1.AutoScroll = true;
		    this.panel1.AutoScrollMargin = new System.Drawing.Size(20, 20);
		    this.panel1.BackColor = System.Drawing.SystemColors.ControlLight;
		    this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
		    this.panel1.Controls.Add(this.calcBtn);
		    this.panel1.Controls.Add(this.whatPayment);
		    this.panel1.Controls.Add(this.whatInterest);
		    this.panel1.Controls.Add(this.whatAmount);
		    this.panel1.Controls.Add(this.label7);
		    this.panel1.Controls.Add(this.label8);
		    this.panel1.Controls.Add(this.label9);
		    this.panel1.Controls.Add(this.groupBox3);
		    this.panel1.Controls.Add(this.payTotal);
		    this.panel1.Controls.Add(this.payInterest);
		    this.panel1.Controls.Add(this.payMonth);
		    this.panel1.Controls.Add(this.label6);
		    this.panel1.Controls.Add(this.label5);
		    this.panel1.Controls.Add(this.label4);
		    this.panel1.Controls.Add(this.groupBox1);
		    this.panel1.Controls.Add(this.groupBox2);
		    this.panel1.Dock = System.Windows.Forms.DockStyle.Left;
		    this.panel1.Location = new System.Drawing.Point(0, 0);
		    this.panel1.Name = "panel1";
		    this.panel1.Size = new System.Drawing.Size(232, 429);
		    this.panel1.TabIndex = 11;
		    // 
		    // calcBtn
		    // 
		    this.calcBtn.Location = new System.Drawing.Point(72, 376);
		    this.calcBtn.Name = "calcBtn";
		    this.calcBtn.TabIndex = 5;
		    this.calcBtn.Text = "Calculate";
		    this.calcBtn.Click += new System.EventHandler(this.calcBtn_Click);
		    // 
		    // whatPayment
		    // 
		    this.whatPayment.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
		    this.whatPayment.Location = new System.Drawing.Point(88, 312);
		    this.whatPayment.Name = "whatPayment";
		    this.whatPayment.ReadOnly = true;
		    this.whatPayment.Size = new System.Drawing.Size(104, 20);
		    this.whatPayment.TabIndex = 12;
		    this.whatPayment.TabStop = false;
		    this.whatPayment.Text = "";
		    // 
		    // whatInterest
		    // 
		    this.whatInterest.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
		    this.whatInterest.Location = new System.Drawing.Point(88, 288);
		    this.whatInterest.Name = "whatInterest";
		    this.whatInterest.ReadOnly = true;
		    this.whatInterest.Size = new System.Drawing.Size(104, 20);
		    this.whatInterest.TabIndex = 13;
		    this.whatInterest.TabStop = false;
		    this.whatInterest.Text = "";
		    // 
		    // whatAmount
		    // 
		    this.whatAmount.Location = new System.Drawing.Point(88, 264);
		    this.whatAmount.Name = "whatAmount";
		    this.whatAmount.Size = new System.Drawing.Size(104, 20);
		    this.whatAmount.TabIndex = 4;
		    this.whatAmount.Text = "";
		    // 
		    // label7
		    // 
		    this.label7.Location = new System.Drawing.Point(16, 312);
		    this.label7.Name = "label7";
		    this.label7.Size = new System.Drawing.Size(72, 16);
		    this.label7.TabIndex = 12;
		    this.label7.Text = "Life Payment";
		    // 
		    // label8
		    // 
		    this.label8.Location = new System.Drawing.Point(16, 288);
		    this.label8.Name = "label8";
		    this.label8.Size = new System.Drawing.Size(64, 16);
		    this.label8.TabIndex = 13;
		    this.label8.Text = "Life Interest";
		    // 
		    // label9
		    // 
		    this.label9.Location = new System.Drawing.Point(16, 264);
		    this.label9.Name = "label9";
		    this.label9.Size = new System.Drawing.Size(48, 16);
		    this.label9.TabIndex = 14;
		    this.label9.Text = "Monthly";
		    // 
		    // groupBox3
		    // 
		    this.groupBox3.BackColor = System.Drawing.SystemColors.ControlLight;
		    this.groupBox3.Controls.Add(this.whatNumMonths);
		    this.groupBox3.Controls.Add(this.whatMonths);
		    this.groupBox3.Location = new System.Drawing.Point(8, 240);
		    this.groupBox3.Name = "groupBox3";
		    this.groupBox3.Size = new System.Drawing.Size(200, 128);
		    this.groupBox3.TabIndex = 15;
		    this.groupBox3.TabStop = false;
		    this.groupBox3.Text = "What If";
		    // 
		    // whatNumMonths
		    // 
		    this.whatNumMonths.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
		    this.whatNumMonths.Location = new System.Drawing.Point(80, 96);
		    this.whatNumMonths.Name = "whatNumMonths";
		    this.whatNumMonths.ReadOnly = true;
		    this.whatNumMonths.Size = new System.Drawing.Size(104, 20);
		    this.whatNumMonths.TabIndex = 16;
		    this.whatNumMonths.TabStop = false;
		    this.whatNumMonths.Text = "";
		    // 
		    // whatMonths
		    // 
		    this.whatMonths.Location = new System.Drawing.Point(8, 96);
		    this.whatMonths.Name = "whatMonths";
		    this.whatMonths.Size = new System.Drawing.Size(48, 16);
		    this.whatMonths.TabIndex = 17;
		    this.whatMonths.Text = "Months";
		    // 
		    // payTotal
		    // 
		    this.payTotal.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
		    this.payTotal.Location = new System.Drawing.Point(88, 192);
		    this.payTotal.Name = "payTotal";
		    this.payTotal.ReadOnly = true;
		    this.payTotal.Size = new System.Drawing.Size(104, 20);
		    this.payTotal.TabIndex = 18;
		    this.payTotal.TabStop = false;
		    this.payTotal.Text = "";
		    // 
		    // payInterest
		    // 
		    this.payInterest.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
		    this.payInterest.Location = new System.Drawing.Point(88, 168);
		    this.payInterest.Name = "payInterest";
		    this.payInterest.ReadOnly = true;
		    this.payInterest.Size = new System.Drawing.Size(104, 20);
		    this.payInterest.TabIndex = 19;
		    this.payInterest.TabStop = false;
		    this.payInterest.Text = "";
		    // 
		    // payMonth
		    // 
		    this.payMonth.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
		    this.payMonth.Location = new System.Drawing.Point(88, 144);
		    this.payMonth.Name = "payMonth";
		    this.payMonth.ReadOnly = true;
		    this.payMonth.Size = new System.Drawing.Size(104, 20);
		    this.payMonth.TabIndex = 20;
		    this.payMonth.TabStop = false;
		    this.payMonth.Text = "";
		    // 
		    // label6
		    // 
		    this.label6.BackColor = System.Drawing.SystemColors.ControlLight;
		    this.label6.Location = new System.Drawing.Point(16, 192);
		    this.label6.Name = "label6";
		    this.label6.Size = new System.Drawing.Size(72, 16);
		    this.label6.TabIndex = 21;
		    this.label6.Text = "Life Payment";
		    // 
		    // label5
		    // 
		    this.label5.BackColor = System.Drawing.SystemColors.ControlLight;
		    this.label5.Location = new System.Drawing.Point(16, 168);
		    this.label5.Name = "label5";
		    this.label5.Size = new System.Drawing.Size(64, 16);
		    this.label5.TabIndex = 22;
		    this.label5.Text = "Life Interest";
		    // 
		    // label4
		    // 
		    this.label4.BackColor = System.Drawing.SystemColors.ControlLight;
		    this.label4.Location = new System.Drawing.Point(16, 144);
		    this.label4.Name = "label4";
		    this.label4.Size = new System.Drawing.Size(48, 16);
		    this.label4.TabIndex = 23;
		    this.label4.Text = "Monthly";
		    // 
		    // groupBox1
		    // 
		    this.groupBox1.BackColor = System.Drawing.SystemColors.ControlLight;
		    this.groupBox1.Controls.Add(this.label3);
		    this.groupBox1.Controls.Add(this.inAmount);
		    this.groupBox1.Controls.Add(this.label1);
		    this.groupBox1.Controls.Add(this.label2);
		    this.groupBox1.Controls.Add(this.inMonths);
		    this.groupBox1.Controls.Add(this.inRate);
		    this.groupBox1.Location = new System.Drawing.Point(8, 8);
		    this.groupBox1.Name = "groupBox1";
		    this.groupBox1.Size = new System.Drawing.Size(200, 104);
		    this.groupBox1.TabIndex = 24;
		    this.groupBox1.TabStop = false;
		    this.groupBox1.Text = "Input Data";
		    // 
		    // label3
		    // 
		    this.label3.BackColor = System.Drawing.SystemColors.ControlLight;
		    this.label3.Location = new System.Drawing.Point(16, 72);
		    this.label3.Name = "label3";
		    this.label3.Size = new System.Drawing.Size(32, 16);
		    this.label3.TabIndex = 25;
		    this.label3.Text = "Rate";
		    // 
		    // inAmount
		    // 
		    this.inAmount.Location = new System.Drawing.Point(80, 48);
		    this.inAmount.Name = "inAmount";
		    this.inAmount.TabIndex = 2;
		    this.inAmount.Text = "";
		    // 
		    // label1
		    // 
		    this.label1.BackColor = System.Drawing.SystemColors.ControlLight;
		    this.label1.Location = new System.Drawing.Point(16, 24);
		    this.label1.Name = "label1";
		    this.label1.Size = new System.Drawing.Size(48, 16);
		    this.label1.TabIndex = 26;
		    this.label1.Text = "Months";
		    // 
		    // label2
		    // 
		    this.label2.BackColor = System.Drawing.SystemColors.ControlLight;
		    this.label2.Location = new System.Drawing.Point(16, 48);
		    this.label2.Name = "label2";
		    this.label2.Size = new System.Drawing.Size(48, 16);
		    this.label2.TabIndex = 27;
		    this.label2.Text = "Amount";
		    // 
		    // inMonths
		    // 
		    this.inMonths.Location = new System.Drawing.Point(80, 24);
		    this.inMonths.Name = "inMonths";
		    this.inMonths.TabIndex = 1;
		    this.inMonths.Text = "";
		    // 
		    // inRate
		    // 
		    this.inRate.Location = new System.Drawing.Point(80, 72);
		    this.inRate.Name = "inRate";
		    this.inRate.TabIndex = 3;
		    this.inRate.Text = "";
		    // 
		    // groupBox2
		    // 
		    this.groupBox2.BackColor = System.Drawing.SystemColors.ControlLight;
		    this.groupBox2.Location = new System.Drawing.Point(8, 120);
		    this.groupBox2.Name = "groupBox2";
		    this.groupBox2.Size = new System.Drawing.Size(200, 112);
		    this.groupBox2.TabIndex = 28;
		    this.groupBox2.TabStop = false;
		    this.groupBox2.Text = "Payments";
		    // 
		    // splitter1
		    // 
		    this.splitter1.BackColor = System.Drawing.SystemColors.HotTrack;
		    this.splitter1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
		    this.splitter1.Location = new System.Drawing.Point(232, 0);
		    this.splitter1.Name = "splitter1";
		    this.splitter1.Size = new System.Drawing.Size(8, 429);
		    this.splitter1.TabIndex = 29;
		    this.splitter1.TabStop = false;
		    // 
		    // listView1
		    // 
		    this.listView1.BackColor = System.Drawing.SystemColors.ControlLightLight;
		    this.listView1.BorderStyle = System.Windows.Forms.BorderStyle.None;
		    this.listView1.CausesValidation = false;
		    this.listView1.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
												this.columnHeader1,
												this.columnHeader2,
												this.columnHeader3,
												this.columnHeader4,
												this.columnHeader5,
												this.columnHeader6,
									this.columnHeader7});
		    this.listView1.Dock = System.Windows.Forms.DockStyle.Fill;
		    this.listView1.ForeColor = System.Drawing.SystemColors.ControlText;
		    this.listView1.GridLines = true;
		    this.listView1.HideSelection = false;
		    this.listView1.Location = new System.Drawing.Point(240, 0);
		    this.listView1.MultiSelect = false;
		    this.listView1.Name = "listView1";
		    this.listView1.Size = new System.Drawing.Size(496, 429);
		    this.listView1.TabIndex = 30;
		    this.listView1.View = System.Windows.Forms.View.Details;
		    // 
		    // columnHeader1
		    // 
		    this.columnHeader1.Text = "Month";
		    this.columnHeader1.Width = 46;
		    // 
		    // columnHeader2
		    // 
		    this.columnHeader2.Text = "Interest";
		    // 
		    // columnHeader3
		    // 
		    this.columnHeader3.Text = "Principal";
		    // 
		    // columnHeader4
		    // 
		    this.columnHeader4.Text = "Interest YTD";
		    this.columnHeader4.Width = 76;
		    // 
		    // columnHeader5
		    // 
		    this.columnHeader5.Text = "Principal YTD";
		    this.columnHeader5.Width = 78;
		    // 
		    // columnHeader6
		    // 
		    this.columnHeader6.Text = "Interest LTD";
		    this.columnHeader6.Width = 78;
		    // 
		    // columnHeader7
		    // 
		    this.columnHeader7.Text = "Principal LTD";
		    this.columnHeader7.Width = 78;
		    // 
		    // UserControl1
		    // 
		    this.BackColor = System.Drawing.SystemColors.Window;
		    this.Controls.Add(this.listView1);
		    this.Controls.Add(this.splitter1);
		    this.Controls.Add(this.panel1);
		    this.Name = "UserControl1";
		    this.Size = new System.Drawing.Size(736, 429);
		    this.panel1.ResumeLayout(false);
		    this.groupBox3.ResumeLayout(false);
		    this.groupBox1.ResumeLayout(false);
		    this.ResumeLayout(false);

		}
		#endregion

		private void calcBtn_Click(object sender, System.EventArgs e)
		{
			double AmortizAmount = 0;
			uint Months = 0;
			double InterestRate = 0;
			double WhatIfMonthlyPayment = 0.0;
			int i = 0;
			int j = 0;
			int k = 0;
			int l = 0;
			int idx = 0;
			string lastErrorMsg;

			AmortCalc calc = new AmortCalc();

			if (this.inAmount.Text.Length < 1)
			{
				MessageBox.Show("missing Mortgage Amount", "ERROR");
				this.inAmount.Focus();
				return;
			}
			if (this.inMonths.Text.Length < 1)
			{
				MessageBox.Show("missing Months", "ERROR");
				this.inMonths.Focus();
				return;
			}
			if (this.inRate.Text.Length < 1)
			{
				MessageBox.Show("missing Interest Rate", "ERROR");
				this.inRate.Focus();
				return;
			}
			try
			{
			    AmortizAmount = Convert.ToDouble(this.inAmount.Text);
			}
			catch (System.Exception e1)
			{
			    Exception innerE = e1.InnerException;
			    if ((innerE != null) && (innerE.Message.Length > 0))
				lastErrorMsg = innerE.Message;
			    else
			    {
				if (e1.Message.Length > 0)
				    lastErrorMsg = e1.Message;
				else
				    lastErrorMsg = "invalid amount";	
			    }
			    MessageBox.Show(lastErrorMsg);
			    this.inAmount.Focus();
			    return;
			}
			try
			{
			    InterestRate = Convert.ToDouble(this.inRate.Text);
			}
			catch (System.Exception e1)
			{
			    Exception innerE = e1.InnerException;
			    if ((innerE != null) && (innerE.Message.Length > 0))
				lastErrorMsg = innerE.Message;
			    else
			    {
				if (e1.Message.Length > 0)
				    lastErrorMsg = e1.Message;
				else
				    lastErrorMsg = "invalid rate";	
			    }
			    MessageBox.Show(lastErrorMsg);
			    this.inRate.Focus();
			    return;
			}
			for ( i=0; i < this.inMonths.Text.Length; i++)
			{
			    if ((this.inMonths.Text[i] < '0') || (this.inMonths.Text[i] > '9'))
			    {
				lastErrorMsg = "Months must be numeric";
				break;
			    }
			}
			Months = 0;
			if (i == this.inMonths.Text.Length)
			    Months = Convert.ToUInt32(this.inMonths.Text);
			if ((Months == 0) || (Months > 360))
			{
			    MessageBox.Show("Months must be from 1 to 360");
			    this.inMonths.Focus();
			    return;
			}
			if (this.whatAmount.Text.Length > 0)
			{
			    try
			    {
			    WhatIfMonthlyPayment = Convert.ToDouble(this.whatAmount.Text);
			    }
			    catch (System.Exception e1)
			    {
				Exception innerE = e1.InnerException;
				if ((innerE != null) && (innerE.Message.Length > 0))
				    lastErrorMsg = innerE.Message;
				else
				{
				    if (e1.Message.Length > 0)
					lastErrorMsg = e1.Message;
				    else
					lastErrorMsg = "invalid What If Monthly Payment";	
				}
				MessageBox.Show(lastErrorMsg);
				this.whatAmount.Focus();
				return;
			    }
			}

			calc.ProcData(AmortizAmount,
						Months,
						InterestRate,
						WhatIfMonthlyPayment);
			if (this.whatAmount.Text.Length == 0)
			{
				this.payMonth.Text = calc.MonthlyPayment.ToString("N");
				this.payInterest.Text = calc.TotalInterest.ToString("N");
				this.payTotal.Text = calc.TotalPayment.ToString("N");
				
				strTotalPayment = this.payTotal.Text;
				strTotalInterest = this.payInterest.Text;
				strMonthPayment = this.payMonth.Text;
			}
			if (this.whatAmount.Text.Length > 0)
			{
				this.whatInterest.Text = calc.WhatIfTotalInterest.ToString("N");
				this.whatPayment.Text = calc.WhatIfTotalPayment.ToString("N");
				this.whatNumMonths.Text = calc.WhatIfMonths.ToString();
				
				strWhatTotalPayment = this.whatPayment.Text;
				strWhatTotalInterest = this.whatInterest.Text;
				strWhatMonths = this.whatNumMonths.Text;
			}
			this.listView1.Items.Clear();
			i = 0;
			while (( i < 360) && (calc.Month_Principal[i] > 0))
			{
				k = i + 1;  // make k one based
				if ( ( k > 12) &&  ( k % 12) == 1)
				{
					this.listView1.Items.Add(" ", i + j);
					this.listView1.Items[i + j].BackColor = Color.LightYellow;
					this.listView1.Items[i + j].UseItemStyleForSubItems  = true;
					j++;
				}
				idx = j + i;
				l = i + 1;
				this.listView1.Items.Add(l.ToString(), idx);
				//this.listView1.Items[idx].BackColor = Color.LightGray;
				this.listView1.Items[idx].UseItemStyleForSubItems  = true;
				this.listView1.Items[idx].SubItems.Add( calc.Month_Interest[i].ToString("N"));
				this.listView1.Items[idx].SubItems.Add(calc.Month_Principal[i].ToString("N"));
				this.listView1.Items[idx].SubItems.Add(calc.Yearly_Interest[i].ToString("N"));
				this.listView1.Items[idx].SubItems.Add(calc.Yearly_Principal[i].ToString("N"));
				this.listView1.Items[idx].SubItems.Add(calc.Life_Interest[i].ToString("N"));
				this.listView1.Items[idx].SubItems.Add(calc.Life_Principal[i].ToString("N"));

				i++;
			}
			if (FireCalc != null)
			    FireCalc();
		}
	}
}
