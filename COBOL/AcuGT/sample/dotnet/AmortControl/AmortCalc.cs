using System;

namespace AmortControl
{
	/// <summary>
	/// Summary description for AmortCalc.
	/// </summary>
	/// 
	public class AmortCalc
	{
 
		public double       MonthlyPayment;
		public double       TotalInterest;
		public double       TotalPayment;
		public double       WhatIfTotalInterest;
		public double       WhatIfTotalPayment;
		public uint         WhatIfMonths;

		public double	     [] Yearly_Interest = new double[360];
		public double	     [] Yearly_Principal = new double[360];
		public double	     [] Life_Interest = new double[360];
		public double	     [] Life_Principal = new double[360];
		public double	     [] Month_Interest = new double[360];
		public double	     [] Month_Principal = new double[360];

		public AmortCalc()
		{
			
		}

		public void ProcData(double AmortizAmount,
						uint Months,
						double InterestRate,
						double WhatIfMonthlyPayment)
		{
			double	Extended_Rate;
			double	Double_One = 1;
			double	Months_In_Year = 12;
			double	Monthly_Interest_Rate;
			uint     i, m, n;
			double	Monthly_Interest;
			double	Monthly_Principal;
			double  Mortgage_Amount;
			double  YTD_Principal;
			double  YTD_Interest;
			double  LTD_Principal;
			double  LTD_Interest;

			Mortgage_Amount = AmortizAmount;
			MonthlyPayment =  WhatIfMonthlyPayment;
            
			if (InterestRate > .9)
				InterestRate *= .01;
   
			Monthly_Interest_Rate = Double_One + (InterestRate / Months_In_Year);
			Extended_Rate = Monthly_Interest_Rate;

			for (i = 0; i < (Months - 1); i++)
				Extended_Rate = Extended_Rate * Monthly_Interest_Rate;

			Extended_Rate = Double_One - Extended_Rate;
			Extended_Rate *=  -1;
			Extended_Rate /= (InterestRate / Months_In_Year);
   
			Monthly_Principal   =  Mortgage_Amount * (Double_One / Extended_Rate);
			Monthly_Interest    =  Mortgage_Amount * (InterestRate / Months_In_Year);
			if (MonthlyPayment == 0)
				MonthlyPayment	= Monthly_Principal + Monthly_Interest;

			for ( i = 0; i < 360; i++)
			{
				Yearly_Principal[i] = 0.0;
				Yearly_Interest[i]  = 0.0;
				Life_Principal[i] = 0.0;
				Life_Interest[i]  = 0.0;
				Month_Interest[i]  = 0.0;
				Month_Principal[i]  = 0.0;
			}

			YTD_Principal = 0.0;
			YTD_Interest  = 0.0;
			LTD_Principal = 0.0;
			LTD_Interest  = 0.0;
			TotalInterest = 0.0;
			TotalPayment  = 0.0;
			WhatIfTotalInterest = 0.0;
			WhatIfTotalPayment  = 0.0;
			WhatIfMonths = 0;

			m = 0;

			while (m < Months)
			{
				for (n = 0; n < 12; n++)
				{
					if (Mortgage_Amount <= 0)
					{
						WhatIfMonths = m; 
						m = Months;
						 break;
					}
					Monthly_Interest    =  Mortgage_Amount * (InterestRate / Months_In_Year);
					Monthly_Principal   =  MonthlyPayment - Monthly_Interest;
					if (Monthly_Principal > Mortgage_Amount)
							Monthly_Principal = Mortgage_Amount;

					Month_Interest[m]   = Monthly_Interest;
					Month_Principal[m]  = Monthly_Principal; 

					YTD_Principal += Monthly_Principal;
					LTD_Principal += Monthly_Principal;
					Yearly_Principal[m] = YTD_Principal;

					YTD_Interest  += Monthly_Interest;
					LTD_Interest  += Monthly_Interest;  
					Yearly_Interest[m] = YTD_Interest;

					Life_Principal[m] = LTD_Principal;
					Life_Interest[m]  = LTD_Interest;
             
             
					Mortgage_Amount -= Monthly_Principal;
					m++;

				}
				/* Next year */
				YTD_Principal = 0.0;
				YTD_Interest  = 0.0;
			}

			if (WhatIfMonthlyPayment > 0)
			{ 
				WhatIfTotalInterest = LTD_Interest;
				WhatIfTotalPayment =  WhatIfTotalInterest + LTD_Principal;
			}
			else
			{
				TotalInterest = LTD_Interest;
				TotalPayment =  TotalInterest + LTD_Principal;
			}
		}
	}
}
