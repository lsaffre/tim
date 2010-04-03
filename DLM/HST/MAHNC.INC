[set margintop 2.0]
[tab define " Ä "]
[etc do p_AddColumn(\
 10, "TL",\
 tr("Doc.no.","Dok.Nr.","Nø doc."),"[= HST->IdJnl] [= HST->IdDoc]")]
[etc do p_AddColumn(\
 0, "TL",\
 tr("Remark","Bemerkung","Remarque"),\
 "[=trim(HstDocName(HST->IdJnl,HST->IdDoc,HST->Line))]")]
[etc do p_AddColumn(\
 len(dtocf(UserDate())), "TL",\
 tr("Date","Datum","Date"),"[=dtocf(HST->Date)]")]
[etc do p_AddColumn(\
 10, "TR",\
 tr("Debit","Debit","D‚bit"),"[hst debit]")]
[etc do p_AddColumn(\
 10, "TR",\
 tr("Credit","Kredit","Cr‚dit"),"[hst credit]")]
[tab begin]
[par hstlist "[tab exec]"]
[tab end]
[set align r]
[=repl("Ä",21)]
Total :     [par hstdebit] [par hstcredit]
[=tr("","Saldo","Solde")] : [= PAR->IdDev] [par hstsolde d] [par hstsolde c]
[set align l]
