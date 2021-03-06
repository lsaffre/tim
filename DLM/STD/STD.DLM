// std.dlm
// raus seit 20030108: do ActExec("STARTUP")
CustData NAT TPL
// Siehe 19990209
ClearOnRebuild
OnRebuild {|cText| IndCreate("DBCHECK",cText)}
OnRebuild {|cText| IndCreate("REBUILD",cText)}
OnRebuild {|cText| IndDelete("TIMTEST")}
OnRebuild {|cText| Warning( \
    cText,NIL,"REBUILD",.t.,CfgDataBase() + " : " + \
    utr("System messages","Systemmeldungen","Messages syst�me") \
) }
PreLogin !IndExist("DBCHECK").or.ActExec("DBCHECK")\
.or.Confirm(\
  "Das Reorganisieren hat nicht ganz geklappt. "\
  +"Wollen Sie trotzdem in der Datenbank arbeiten ?"\
)

// OnLogin setvar("asMail"," ")
do DlgDefault("mailhost","")
do DlgDefault("mailfrom","")
do DlgDefault("mailsupport","")
do DlgDefault("mailto","luc.saffre@gmx.net")
do DlgDefault("mailtpl","MAIL.EML")
do DlgDefault("fontName","")
do DlgDefault("fontNamePdf","")

do setvar("email",padr("",100),.t.) // lPersistent is .t.
do setvar("phone",padr("",100),.t.) // lPersistent is .t.

