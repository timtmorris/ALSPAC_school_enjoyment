********************************************************************************
* 
* ALSPAC school enjoyment; imputation file.
* Tim Morris
* tim.morris@bristol.ac.uk
* 01/02/2021
* 
********************************************************************************

* Running multiple imputation
use "B2193_enjoyment.dta", clear
drop if female==. | mob==. | nonwhite==. 
set seed 12345
replace ks4_ptscnewe=. if ks4_ptscnewe==0
replace ks4_ptscnewe=ks4_ptscnewe^2
egen nmiss=rmiss(enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu ageccac_cent ageccad_cent sep nonwhite ///
	temp_hle temp_work_confidence temp_temperament temp_intell_confidence temp_friends_score_f8 temp_teacher)
tab nmiss
drop temp_hle temp_work_confidence temp_temperament temp_intell_confidence temp_friends_score_f8 temp_teacher

* Running imputation:
set matsize 10000
ice o.enj5 o.enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu ageccac_cent ageccad_cent ccac990a ccad990a o.ccad100 ccad101 sep nonwhite o.kj307 kk464 km4246 kp1136 o.ccae100 o.ccae101 o.ccae102 o.ccae103 o.ccae104 o.ccae105 o.ccae106 o.ccae107 o.ccae108 o.ccc120 o.ccc130 o.ccc170 o.ccc180 o.ccc200 o.ccc220 o.ccc230 o.ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 o.f8fs110 o.f8fs111 o.f8fs112 o.f8fs113 o.f8fs114 o.fdfs110 o.fdfs115 o.fdfs117 o.fdfs118 o.fdfs119, eq( ///
enj5: enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu ageccac_cent sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
enj6: enj5 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu ageccad_cent sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
iq: enj5 enj6 female mob ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364, ///
ks4_ptscnewe: enj5 enj6 female mob iq ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ks4_level2_em: enj5 enj6 female mob iq ks4_ptscnewe ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ks4year: ageccac_cent ageccad_cent ccac990a ccad990a, ///
matedu: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year sep nonwhite, ///
ageccac_cent: enj5 enj6 mob ks4_ptscnewe ks4_level2_em ks4year ccac990a, ///
ageccad_cent: enj5 enj6 ccad100 ccad101 mob ks4_ptscnewe ks4_level2_em ks4year ccad990a, ///
sep: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu nonwhite, ///
kj307: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364, ///
kk464: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
km4246: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364, ///
kp1136: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364, ///
ccae100: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccae101: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccae102: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccae103: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccae104: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccae105: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccae106: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccae107: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccae108: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccc120: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 kj307 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccc130: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 kj307 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccc170: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 kj307 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccc180: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 kj307 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccc200: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 kj307 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccc220: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 kj307 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccc230: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 kj307 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
ccc300: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 kj307 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
f8fs110: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
f8fs111: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
f8fs112: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
f8fs113: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
f8fs114: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
fdfs110: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs115 fdfs117 fdfs118 fdfs119, ///
fdfs115: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs117 fdfs118 fdfs119, ///
fdfs117: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs118 fdfs119, ///
fdfs118: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs119, ///
fdfs119: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118, ///
fg7360: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7361 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
fg7361: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7362 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
fg7362: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7363 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
fg7363: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7364 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
fg7364: enj5 enj6 female mob iq ks4_ptscnewe ks4_level2_em ks4year matedu sep nonwhite kk464 km4246 kp1136 ccae100 ccae101 ccae102 ccae103 ccae104 ccae105 ccae106 ccae107 ccae108 ccc120 ccc130 ccc170 ccc180 ccc200 ccc220 ccc230 ccc300 fg7360 fg7361 fg7362 fg7363 f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119, ///
) saving(imputed, replace) m(100)

use imputed, clear
gen enj=1 if enj5==0 & enj6==0
replace enj=2 if enj5==0 & enj6==1 | enj5==1 & enj6==0
replace enj=3 if enj5==1 & enj6==1
tab enj if _mj==0
la def enj_lb 1"Enjoyed school" 2"Mixed enjoyment" 3"No enjoyment" 
la val enj enj_lb
rename kj307 hle
revrs ccae100 ccae104 ccae108
egen temperament=rowtotal(ccae101 ccae102 ccae103 ccae105 revccae100 revccae104 revccae108), missing
revrs ccc200 ccc230 ccc300
egen work_confidence=rowtotal(ccc130 revccc200 ccc220 revccc230), missing
egen intell_confidence=rowtotal(ccc180 ccc190 revccc300), missing
foreach var of varlist f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 {
	replace `var'=`var'-1
}
gen friends_score_f8=f8fs110+f8fs111+f8fs112+f8fs113+f8fs114 
rename fg7360 b5ex
rename fg7361 b5a
rename fg7362 b5c
rename fg7363 b5em
rename fg7364 b5i
revrs kp1136 
rename revkp1136 like_teacher
replace ks4_ptscnewe=sqrt(ks4_ptscnewe)
drop ageccac ageccad ks2year ks3year ccae100 ccae104 ccae108 ccae101 ccae102 ccae103 ///
	ccae105 revccae100 revccae104 revccae108 ccc130 revccc200 ccc200 ccc230 ccc300 ///
	revccc230 ccc180 ccc190 revccc300 kk464 km4246 kp1136 ///
	f8fs110 f8fs111 f8fs112 f8fs113 f8fs114 fdfs110 fdfs115 fdfs117 fdfs118 fdfs119 ///
	ccc120 ccc170 ccc220 ccae106 ccae107 _Ienj5_1- _Ifdfs119_4 f8fs120 fdfs120 kk464 km4246 
compress
save "imputed.dta", replace

* END