
use "C:\Users\thomas.frye\Desktop\Domination and Mutualism\Combined data file License\Combined Data License Treatment.dta"

gen treatment=0
replace treatment=1 if Period>10

egen groupid=group(Group Session)
egen subjectid=group(Subject Session)

gen timegroup=0
replace timegroup=1 if Period>10

sort subjectid timegroup

collapse PAX DON License treatment Profit, by(subjectid timegroup)

gen pax1=0
replace pax1=PAX if treatment==0
gen pax2=0
replace pax2=PAX if treatment==1
gen don1=0
replace don1=DON if treatment==0
gen don2=0
replace don2=DON if treatment==1

gen prof1=0
replace prof1=Profit if treatment==0
gen prof2=0
replace prof2=Profit if treatment==1

sort subjectid

collapse (max) pax1 pax2 don1 don2 License treatment Profit prof1 prof2, by(subjectid)




signrank pax1=pax2
signrank don1=don2

ranksum pax1, by(License)
ranksum pax2, by(License)

ranksum don1, by(License)
ranksum don2, by(License)

signrank prof1=prof2
ranksum prof1, by(License)
ranksum prof2, by(License)

signrank prof1=prof2 if License==1
signrank prof1=prof2 if License==0













