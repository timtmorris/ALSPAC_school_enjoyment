********************************************************************************
* 
* ALSPAC school enjoyment; data cleaning file.
* Tim Morris
* tim.morris@bristol.ac.uk
* 01/02/2021
* 
********************************************************************************

* Data cleaning
use "B2193_master_CID.dta" , clear
gen ageccac=(ccac991a)/12 if ccac991a>0
gen ageccad=(ccad991a)/12 if ccad991a>0
recode ccac100 (. 3=.) (1=1) (2=2),gen(enjccac)
recode ccad113 (.=.) (1 2=1) (3=2),gen(enjccad)
gen enj=enjccac+enjccad-1
recode enjccac (1=1) (2=0), gen(enj5)
recode enjccad (1=1) (2=0), gen(enj6)
recode mz024a (9=1) (10=2) (11=3) (12=4) (1=5) (2=6) (3=7) (4=8) (5=9) (6=10) (7=11) (8=12), gen(mob)
la def mob_lb 1"Sep" 2"Oct" 3"Nov" 4"Dec" 5"Jan" 6"Feb" 7"Mar" 8"Apr" 9"May" 10"Jun" 11"Jul" 12"Aug"
la val mob mob_lb
la var mob "Month of birth"
recode sex (1=0) (2=1), gen(female)
la var female "Female"
recode matedu (1 2=1) (3=2) (4=3) (5=4)
la var matedu "Maternal education"
la def matedu_lb 1"CSE/Vocational" 2"O-level" 3"A-level" 4"Degree", modify
la val matedu matedu_lb
la def V77_A 2"III Non-manual" 3"III Manual", modify
revrs socclassr
rename revsocclassr sep
egen iqstd=std(iq)
drop iq
rename iqstd iq
la var iq "IQ"
recode c804 (1=0) (2=1) (-1=.), gen(nonwhite)
foreach var of varlist kj307 kk464 km4246 kp1136 ccae100-ccae108 ccc120-ccc300 f8fs110-f8fs120 fdfs110-fdfs120 fg7360-fg7364 {
	replace `var'=. if `var'<0
}
foreach var of varlist f8fs114 f8fs113 f8fs112 f8fs111 f8fs110 fdfs117 fdfs118 {
	replace `var'=. if `var'==5
}
replace fdfs110=. if fdfs110==6
replace fdfs115=. if fdfs115==7
replace fdfs119=. if fdfs119==6
egen id=group(cidB2193 qlet)
keep id ageccac ageccad mob iq ks4_ptscnewe female matedu ks4year sep ks4_level2_em enj5 enj6 nonwhite ks3year ks2year ccad100 ccad101 ccac990a ccad990a ///
	kj307 kk464 km4246 kp1136 ccae100-ccae108 ccc120-ccc300 f8fs110-f8fs120 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119 fdfs120 fg7360-fg7364 
gen temp_hle=kj307
egen temp_work_confidence=rowtotal(ccc130 ccc200 ccc220 ccc230) 
egen temp_temperament=rowtotal(ccae101 ccae102 ccae103 ccae105 ccae100 ccae104 ccae108), missing
egen temp_intell_confidence=rowtotal(ccc180 ccc190 ccc300)
gen temp_friends_score_f8=f8fs110+f8fs111+f8fs112+f8fs113+f8fs114 
gen temp_teacher=kp1136

log using "attrition.log", replace
gen inclusion1=1 if female!=. & mob!=. & nonwhite!=.
gen inclusion2=1 if inclusion1==1 & ks4_ptscnewe!=. & ks4_level2_em!=. & ks4year!=.
gen inclusion3=1 if inclusion2==1 & enj5!=. & enj6!=. 
gen inclusion4=1 if inclusion3==1 & matedu!=. & sep!=.
gen inclusion5=1 if inclusion4==1 & iq!=.
gen inclusion6=1 if inclusion5==1 & temp_hle!=. & temp_work_confidence!=. & temp_temperament!=. & temp_intell_confidence!=. & temp_friends_score_f8!=. & temp_teacher!=.
tab1 inclusion*
log close
replace inclusion6=0 if inclusion6==.
summarize ageccac, meanonly
gen ageccac_cent = ageccac - r(mean)
summarize ageccad, meanonly
gen ageccad_cent = ageccad - r(mean)
replace ks4year=12 if ks2year==7 & ks4year==. | ks3year==10 & ks4year==.
replace ks4year=13 if ks2year==8 & ks4year==. | ks3year==11 & ks4year==.
replace ks4year=14 if ks2year==9 & ks4year==. | ks3year==12 & ks4year==.
compress
save "B2193_enjoyment.dta", replace

* END