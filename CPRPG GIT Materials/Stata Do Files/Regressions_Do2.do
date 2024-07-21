use "C:\Users\thomas.frye\Desktop\Domination and Mutualism\Combined data file Baseline\combined data.dta"

gen spillover=0
replace spillover=1 if Period>5 & Period<11 & Session<3
replace spillover=1 if Period<6 & Session>2 | Period>10 & Session>2
gen ABA=0
gen BAB=0
replace ABA=1 if Session<3
replace BAB=1 if Session>2
egen groupid=group(Group Session)
egen subjectid=group(Subject Session)


gen timegroup=0
replace timegroup=1 if Period<6
replace timegroup=2 if Period>5 & Period<11
replace timegroup=3 if Period>10

replace TimeSubmit=180-TimeSubmit
bysort Session Period: egen maxtime=max(TimeSubmit)
gen lagmaxtime=maxtime[_n-1]
gen lagmaxtimetreat=lagmaxtime*spillover


xtset subjectid Period
gen lag1sumx=sumx[_n-1]
gen lag1padon=PAdon[_n-1]
gen lag1savings=savings[_n-1]
gen PAXinteraction=PAX*spillover
gen DONinteraction=DON*spillover
gen saveinteraction=savings*spillover
gen lag1sumxinteraction=lag1sumx*spillover
gen lag1padoninteraction=lag1padon*spillover
gen lag1savingsinteraction=lag1savings*spillover
gen savingsinteraction=savings*spillover
gen collapse=0
replace collapse=1 if sumx>roundthresh
gen conserve=0
replace conserve=1 if sumd>=roundthresh





*Regressions to test the correlation of past group outcome and treatment effect on present individual decisions*

reg PAX spillover  i.Session i.Period, cluster(groupid)

reg DON spillover  i.Session i.Period, cluster(groupid)

reg PAX spillover lag1sumx lag1padon  i.Session i.Period, cluster(groupid)

reg DON spillover lag1sumx lag1padon  i.Session i.Period, cluster(groupid)

reg PAX spillover lag1sumx lag1padon lag1sumxinteraction lag1padoninteraction i.Session i.Period, cluster(groupid)

reg DON spillover lag1sumx lag1padon lag1sumxinteraction lag1padoninteraction i.Session i.Period, cluster(groupid)

*Mean Group Contributions Figures*

twoway (connected meanabapaxtotal Period if ABA==1, sort) (connected meanabadontotal Period if ABA==1, sort), xline(5.5) xline(10.5)

twoway (connected meanabapaxtotal Period if ABA==0, sort) (connected meanabadontotal Period if ABA==0, sort), xline(5.5) xline(10.5)

duplicates drop iidgroup Period, force















