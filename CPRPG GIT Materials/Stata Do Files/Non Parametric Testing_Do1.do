use "C:\Users\thomas.frye\Desktop\Domination and Mutualism\Combined data file Baseline\combined data.dta"

gen spillover=0
replace spillover=1 if Period>5 & Period<11 & Session<3
replace spillover=1 if Period<6 & Session>2 | Period>10 & Session>2
gen ABA=0
gen BAB=0
replace ABA=1 if Session<3

egen groupid=group(Group Session)
egen subjectid=group(Subject Session)

save "C:\Users\thomas.frye\Desktop\Domination and Mutualism\Combined data file Baseline\Initial Variables.dta"

use "C:\Users\thomas.frye\Desktop\Domination and Mutualism\Combined data file Baseline\Initial Variables.dta"

*Creating treatment blocks

gen timegroup=0
replace timegroup=1 if Period<6
replace timegroup=2 if Period>5 & Period<11
replace timegroup=3 if Period>10

*Collapse to use rank sum and signed rank tests

collapse PAX DON ABA spillover, by(subjectid timegroup)

gen pax1=0
replace pax1=PAX if timegroup==1
gen pax2=0
replace pax2=PAX if timegroup==2
gen pax3=0
replace pax3=PAX if timegroup==3

gen don1=0
replace don1=DON if timegroup==1
gen don2=0
replace don2=DON if timegroup==2
gen don3=0
replace don3=DON if timegroup==3

collapse (max) ABA pax1 pax2 pax3 don1 don2 don3, by(subjectid)

save "C:\Users\thomas.frye\Desktop\Domination and Mutualism\Combined data file Baseline\Final Collapsed Data for Nonparametric Testing.dta"


*W/In subjects signed rank tests

*use "C:\Users\thomas.frye\Desktop\Domination and Mutualism\Combined data file Baseline\Final Collapsed Data for Nonparametric Testing.dta"

signrank pax1=pax2 if ABA==1
signrank pax2=pax3 if ABA==1
signrank don1=don2 if ABA==1
signrank don2=don3 if ABA==1


signrank pax1=pax2 if ABA==0
signrank pax2=pax3 if ABA==0
signrank don1=don2 if ABA==0
signrank don2=don3 if ABA==0

*B/W subjects sum rank tests

use "C:\Users\thomas.frye\Desktop\Domination and Mutualism\Combined data file Baseline\Initial Variables.dta"

gen timegroup=0
replace timegroup=1 if Period<6
replace timegroup=2 if Period>5 & Period<11
replace timegroup=3 if Period>10

collapse PAX DON ABA spillover, by(subjectid timegroup)

gen pax1=0
replace pax1=PAX if timegroup==1
gen pax2=0
replace pax2=PAX if timegroup==2
gen pax3=0
replace pax3=PAX if timegroup==3

gen don1=0
replace don1=DON if timegroup==1
gen don2=0
replace don2=DON if timegroup==2
gen don3=0
replace don3=DON if timegroup==3

collapse (max) pax1 pax2 pax3 don1 don2 don3 ABA timegroup, by(subjectid)

ranksum pax1, by(ABA)
ranksum pax2, by(ABA)
ranksum pax3, by(ABA)

ranksum don1, by(ABA)
ranksum don2, by(ABA)
ranksum don3, by(ABA)



