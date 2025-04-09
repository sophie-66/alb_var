
***********************************
* EXEMPLAR CODE PREDICTORS OF CVw *
***********************************; 

/* UNIVARIATE */ 
proc surveyreg data=work.alb_var ORDER=INTERNAL varmethod=taylor nomcar;
	weight WTMEC2YR;
	cluster sdmvpsu;
	strata sdmvstra;
	domain pop;
	model logcv100 = age10 / solution clparm; 
	ods output ParameterEstimates=estimates;
run; 

data work.a; set work.estimates; 
if pop=0 or pop= . then delete; 
est2 = (exp(estimate) - 1) * 100; 
lowercl2 = (exp(lowercl) - 1) * 100; 
uppercl2 = (exp(uppercl) - 1) * 100; 
run; 


/* MULTIVARIABLE */ 
proc surveyreg data=work.alb_var ORDER=INTERNAL varmethod=taylor nomcar;
	weight WTMEC2YR;
	cluster sdmvpsu;
	strata sdmvstra;
	domain pop;
	class race (REF=FIRST) riagendr (REF=FIRST) edu (REF=LAST) foodsecure (ref='1') insurance (ref='1') smoke (ref='0')
			cvdhist (ref='0') raas_ (REF='0') statin_ (ref='0') uacr_cat1 (ref=first) 
			mi (ref=first) heartdis (ref=first) chf (ref=first) stroke (ref=first) angina (ref=first) htn (ref='0') dm (ref='0');
	model logcv100 = age10 riagendr race edu insurance foodsecure smoke uacr_cat1 bmi5 lbxgh lbxcrp mi heartdis chf stroke angina htn dm tc50 gfr10_ sbp10 raas_ statin_ /solution clparm;
	ods output ParameterEstimates=estimates;
run; 
data work.a; set work.estimates; 
if pop=0 or pop= . then delete; 
est2 = (exp(estimate) - 1) * 100; 
lowercl2 = (exp(lowercl) - 1) * 100; 
uppercl2 = (exp(uppercl) - 1) * 100; 
run; 
