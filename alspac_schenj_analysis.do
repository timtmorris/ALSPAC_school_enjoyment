********************************************************************************
* 
* ALSPAC school enjoyment; analysis file.
* Tim Morris
* tim.morris@bristol.ac.uk
* 01/02/2021
* 
********************************************************************************

* Analysis:
use "imputed.dta", clear
set cformat %9.2f
la var nonwhite "Ethnicity"
la var ageccac_cent "Age at 1st occasion"
la var ageccad_cent "Age at 2nd occasion"

log using "schenj_results.log", replace

* Descriptive statistics:
foreach var of varlist enj female mob sep matedu ks4year nonwhite ks4_level2_em like_teacher {
	tab `var' if _mj==0 & inclusion6==1
}
summ ks4_ptscnewe iq ageccac_cent ageccad_cent hle temperament work_confidence ///
	intell_confidence friends_score_f8 if _mj==0 & inclusion6==1, detail
foreach var of varlist enj female mob sep matedu ks4year nonwhite ks4_level2_em like_teacher {
	tab `var' if _mj==1
}
summ ks4_ptscnewe iq ageccac_cent ageccad_cent hle temperament work_confidence ///
	intell_confidence friends_score_f8 if _mj==1, detail
foreach var of varlist enj female mob sep matedu ks4year nonwhite ks4_level2_em like_teacher {
	mim: proportion `var'
	by `var', sort: gen `var'counter=1 if _n==1
	replace `var'counter=sum(`var'counter)
}
foreach var of varlist ks4_ptscnewe iq ageccac_cent ageccad_cent hle temperament work_confidence ///
	intell_confidence friends_score_f8 {
	misum `var', detail
	display r(`var'_p25)
	display r(`var'_p75)
}

********************************************************************************
* Patterning of school enjoyent.
* Imputed:
mim: mlogit enj i.sep female mob i.ks4year ageccac_cent ageccad_cent nonwhite , rrr b(1) nolog
qui mim, storebv
matrix b1=e(b)
matrix c1=e(V)
qui mim, clearbv
mim: mlogit enj i.matedu female mob i.ks4year ageccac_cent ageccad_cent nonwhite , rrr b(1) nolog
qui mim, storebv
matrix b2=e(b)
matrix c2=e(V)
qui mim, clearbv
mim: mlogit enj iq female mob i.ks4year ageccac_cent ageccad_cent nonwhite , rrr b(1) nolog
qui mim, storebv
matrix b3=e(b)
matrix c3=e(V)
qui mim, clearbv
mim: mlogit enj i.sep i.matedu iq female mob i.ks4year ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8, rrr b(1) nolog
qui mim, storebv
matrix b4=e(b)
matrix c4=e(V)
qui mim, clearbv
coefplot (matrix(b4), v(c4) mcolor(black) ciopts(color(black)) keep(*:)), ///
	drop(_cons  13.ks4year 14.ks4year ageccac_cent ageccad_cent) xscale(log) xlabel(0.5 1 2 4) ///
	xline(1) eform xtitle("Odds Ratio's (relative to no enjoyment)") graphregion(color(white)) ///
	ylabel(1 "III Manual" 2 "III Non-manual" 3 "I & II" 4 "O-level" ///
	5 "A-level" 6 "Degree" 7 "Cognitive ability" 8 "Female" 9 "Month of birth" ///
	10 "Non-white" 12 "Home learning environment" 13 "Likes teacher sometimes" ///
	14 "Likes teacher usually" 15 "Likes teacher always" 16 "Temperament" ///
	17 "Work confidence" 18 "Intelligence confidence" 19 "Friends score" ///
	20 "III Manual" 21 "III Non-manual" 22 "I & II" ///
	23 "O-level" 24 "A-level" 25 "Degree" 26 "Cognitive ability" ///
	27 "Female" 28 "Month of birth" 29 "Non-white" ///
	30 "Home learning environment" 31 "Likes teacher sometimes" ///
	32 "Likes teacher usually" 33 "Likes teacher always" 34 "Temperament" ///
	35 "Work confidence" 36 "Intelligence confidence" 37 "Friends score") ///	
		ylabel(5 "Mixed enjoyment" 25 "Enjoyed school", axis(2))
graph save "figures\graphs\enjoyment.gph", replace
graph export "figures\enjoyment.tif", replace width(2000)

* Complete case:
mlogit enj i.sep female mob i.ks4year ageccac_cent ageccad_cent nonwhite ///
	if _mj==0 & inclusion6==1, rrr b(1) nolog
mlogit enj i.matedu female mob i.ks4year ageccac_cent ageccad_cent nonwhite ///
	if _mj==0 & inclusion6==1, rrr b(1) nolog
mlogit enj iq female mob i.ks4year ageccac_cent ageccad_cent nonwhite ///
	if _mj==0 & inclusion6==1, rrr b(1) nolog
mlogit enj i.sep i.matedu iq female mob i.ks4year ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 if _mj==0 & inclusion6==1, rrr b(1) nolog

********************************************************************************
* Achievement and school enjoyment.
* Imputed:
mim: reg ks4_ptscnewe i.enj female mob i.ks4year ageccac_cent ageccad_cent nonwhite 
qui mim, storebv
matrix b5=e(b)
matrix c5=e(V)
qui mim, clearbv
mim: reg ks4_ptscnewe i.enj female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite 
qui mim, storebv
matrix b6=e(b)
matrix c6=e(V)
qui mim, clearbv
mim: reg ks4_ptscnewe i.enj female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8
qui mim, storebv
matrix b7=e(b)
matrix c7=e(V)
qui mim, clearbv
coefplot ///
	(matrix(b5), v(c5) msymbol(X) mcolor(dkgreen) ciopts(color(dkgreen))) ///
	(matrix(b6), v(c6) msymbol(s) mcolor(ebblue) ciopts(color(ebblue))) ///
	(matrix(b7), v(c7) msymbol(o) mcolor(dkorange) ciopts(color(dkorange))), ///
	drop(_cons 13.ks4year 14.ks4year ageccac_cent ageccad_cent) ///
	xline(0) xtitle("Change in GCSE points") graphregion(color(white)) ///
	legend(subtitle("Included covariates",size(small)) ///
	order (2 "Basic" 4 "Family background" 6 "All") size(small) row(1)) ///
	ylabel(1 "Mixed enjoyment" 2 "Enjoyed school" 3 "Female" 4 "Age in year" ///
	5 "Non-white" 6 "III Manual" 7 "III Non-manual" 8 "I & II" 9 "O-level" ///
	10 "A-level" 11 "Degree" 12 "Cognitive ability")
graph save "figures\graphs\gcse_points.gph", replace
graph export "figures\gcse_points.tif", replace width(2000)
mim: logit ks4_level2_em i.enj female mob i.ks4year ageccac_cent ageccad_cent nonwhite ///
	, nolog or
qui mim, storebv
matrix b8=e(b)
matrix c8=e(V)
qui mim, clearbv
mim: logit ks4_level2_em i.enj female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite ///
	, nolog or
qui mim, storebv
matrix b9=e(b)
matrix c9=e(V)
qui mim, clearbv
mim: logit ks4_level2_em i.enj female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8, nolog or
qui mim, storebv
matrix b10=e(b)
matrix c10=e(V)
qui mim, clearbv
coefplot ///
	(matrix(b8), v(c8) msymbol(X) mcolor(dkgreen) ciopts(color(dkgreen))) ///
	(matrix(b9), v(c9) msymbol(s) mcolor(ebblue) ciopts(color(ebblue))) ///
	(matrix(b10), v(c10) msymbol(o) mcolor(dkorange) ciopts(color(dkorange))), ///
	drop(_cons 13.ks4year 14.ks4year ageccac_cent ageccad_cent) ///
	eform xline(1) xscale(log range(0.5 8)) xlabel(0.5 1 2 4 8) ///
	xtitle("Odds Ratio of attaining 5+ A*-C GCSE's") graphregion(color(white) margin(r=30)) ///
	legend(off) ylabel("")
graph save "figures\graphs\gcse_odds.gph", replace
graph export "figures\gcse_odds.tif", replace width(2000)
grc1leg "figures\graphs\gcse_points.gph" "figures\graphs\gcse_odds.gph", graphregion(color(white)) 
graph export "figures\gcse_combined.tif", replace width(2000)

* Complete case:
eststo: reg ks4_ptscnewe i.enj female mob i.ks4year ageccac_cent ageccad_cent nonwhite  ///
	if _mj==0 & inclusion6==1
eststo: reg ks4_ptscnewe i.enj female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite ///
	if _mj==0 & inclusion6==1
eststo: reg ks4_ptscnewe i.enj female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 if _mj==0 & inclusion6==1
eststo: logit ks4_level2_em i.enj female mob i.ks4year ageccac_cent ageccad_cent nonwhite ///
	if _mj==0 & inclusion6==1, nolog or
eststo: logit ks4_level2_em i.enj female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite ///
	if _mj==0 & inclusion6==1, nolog or
eststo: logit ks4_level2_em i.enj female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 if _mj==0 & inclusion6==1, nolog or

********************************************************************************
* Testing interactions:
gen int1=enj*matedu
gen int2=enj*sep
gen int3=enj*iq
gen int4=enj*female
reg ks4_ptscnewe i.enj i.matedu female mob i.ks4year i.sep iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 int1 if _mj==0 & inclusion6==1
reg ks4_ptscnewe i.enj i.matedu female mob i.ks4year i.sep iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 int2 if _mj==0 & inclusion6==1
reg ks4_ptscnewe i.enj i.matedu female mob i.ks4year i.sep iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 int3 if _mj==0 & inclusion6==1
reg ks4_ptscnewe i.enj i.matedu female mob i.ks4year i.sep iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 int4 if _mj==0 & inclusion6==1
logit ks4_level2_em i.enj female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 int1 if _mj==0 & inclusion6==1, nolog or
logit ks4_level2_em i.enj female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 int2 if _mj==0 & inclusion6==1, nolog or
logit ks4_level2_em i.enj female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 int3 if _mj==0 & inclusion6==1, nolog or
logit ks4_level2_em i.enj female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 int4 if _mj==0 & inclusion6==1, nolog or

reg ks4_ptscnewe i.enj##i.female mob i.ks4year i.sep iq i.matedu ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 if _mj==0 & inclusion6==1
testparm i.enj#i.female
margins enj, by(female)
marginsplot, graphregion(color(white)) legend(order (3 "Males" 4 "Females")) ///
	plot1(lcolor(gs1) mcolor(gs1)) ///
	plot2(lcolor(gs6) mcolor(gs6) lpattern(dash)) ///
	ci1(lcolor(gs1)) ci2(lcolor(gs6)) ///
	ytitle("Estimated GCSE points") title("") xtitle("") ///
	xlabel(1 `" "No" "enjoyment" "' 2 `" "Mixed" "enjoyment" "' 3 `" "Enjoyed" "school" "') graphregion(margin(5 10 5 5))
graph save "figures\graphs\interaction_linear.gph", replace

logit ks4_level2_em i.enj##female mob i.ks4year i.sep i.matedu iq ageccac_cent ageccad_cent nonwhite ///
	hle i.like_teacher temperament work_confidence intell_confidence friends_score_f8 if _mj==0 & inclusion6==1, nolog or
testparm i.enj#i.female
margins enj, by(female)
marginsplot, graphregion(color(white)) legend(order (3 "Males" 4 "Females")) ///
	plot1(lcolor(gs1) mcolor(gs1)) ///
	plot2(lcolor(gs6) mcolor(gs6) lpattern(dash)) ///
	ci1(lcolor(gs1)) ci2(lcolor(gs6)) ///
	ytitle("Odds of 5+ A*-C GCSE's") title("") xtitle("")  ///
	xlabel(1 `" "No" "enjoyment" "' 2 `" "Mixed" "enjoyment" "' 3 `" "Enjoyed" "school" "') graphregion(margin(5 10 5 5))
graph save "figures\graphs\interaction_logit.gph", replace
gr combine "figures\graphs\interaction_linear.gph" ///
	"figures\graphs\interaction_logit.gph", graphregion(color(white)) ///
	note("")
graph export "figures\sinteraction.tif", replace width(2000)

********************************************************************************

log close

* END