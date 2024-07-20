
use "C:\Users\thomas.frye\Desktop\Domination and Mutualism\Combined data file License\Combined Data License Treatment.dta"

gen treatment=0
replace treatment=1 if Period>10


gen payscale=0
replace payscale=1 if Session>6
gen payscaletreat=payscale*treatment

replace TimeSubmit=180-TimeSubmit
bysort Session Period: egen maxtime=max(TimeSubmit)
gen lagmaxtime=maxtime[_n-1]
gen lagmaxtimetreat=lagmaxtime*treatment



egen subjectid=group(Subject Session)
egen groupid=group(Group Session)





xtset subjectid Period

gen licensetreat=License*treatment
gen lag1sumx=sumx[_n-1]
gen lag1sumd=sumd[_n-1]
gen lag1save=savings[_n-1]
gen lag2sumx=sumx[_n-2]
gen lag2sumd=sumd[_n-2]
gen lag2save=savings[_n-2]
gen lag1finalprod=finalprod[_n-1]
gen lag1padon=PAdon[_n-1]




gen lag1sumxinteraction=lag1sumx*treatment
gen lag1sumdinteraction=lag1sumd*treatment
gen lag1saveinteraction=lag1save*treatment
gen lag2sumxinteraction=lag2sumx*treatment
gen lag2sumdinteraction=lag2sumd*treatment
gen lag2saveinteraction=lag2save*treatment
gen lag1finalprodinteraction=lag1finalprod*treatment
gen lag1padoninteraction=lag1padon*treatment


gen lag1sumxLicensetreat=lag1sumxinteraction*License
gen lag1sumdLicensetreat=lag1sumdinteraction*License
gen lag1saveLicensetreat=lag1saveinteraction*License
gen lag2sumxLicensetreat=lag2sumxinteraction*License
gen lag2sumdLicensetreat=lag2sumdinteraction*License
gen lag2saveLicensetreat=lag2saveinteraction*License
gen lag1finalprodLicensetreat=lag1finalprodinteraction*License
gen lag1padonLicensetreat=lag1padoninteraction*License




gen lag1sumxLicense=lag1sumx*License 
gen lag1sumdLicense=lag1sumd*License
gen lag1saveLicense=lag1save*License 
gen lag2sumxLicense=lag2sumx*License 
gen lag2sumdLicense=lag2sumd*License 
gen lag2saveLicense=lag2save*License
gen lag1finalprodLicense=lag1finalprod*License
gen lag1padonLicense=lag1padon*License


*save "C:\Users\thomas.frye\Desktop\Domination and Mutualism\Combined data file License\combined Data License Treatment with all variables.dta"

*Regression estimating license-policy treatment effect on CPR and PG contributions, while including lagged variables for information subjects see between periods*

reg PAX  treatment License   payscale i.Period i.Session, cluster(groupid)

reg DON  treatment License  payscale  i.Period i.Session , cluster(groupid)


reg PAX  treatment License lagmaxtime payscale lagmaxtime  lag1sumx lag1sumd   i.Period i.Session, cluster(groupid)

reg DON  treatment License lagmaxtime payscale lagmaxtime  lag1sumx lag1sumd  i.Period i.Session , cluster(groupid)


reg PAX  treatment License licensetreat payscaletreat payscale lagmaxtime lagmaxtimetreat lag1sumx lag1sumd  lag1sumxinteraction lag1sumdinteraction i.Period i.Session, cluster(groupid)

reg DON  treatment License licensetreat payscaletreat payscale lagmaxtime lagmaxtimetreat lag1sumx lag1sumd  lag1sumxinteraction lag1sumdinteraction i.Period i.Session , cluster(groupid)















