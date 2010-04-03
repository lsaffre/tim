[etc do SetDateFormat(tr("yyyy-mm-dd","dd.mm.yy","dd/mm/yy"))]
[etc do SetTplHeader({||fparse("MAHNH.INC")})]
[etc do SetTplFooter({||fparse("VENSTDF.INC")},.t.)]
[set montant S10]
[set apswidth 76]
[set marginleft 0.8]
[set margintop 3]

[etc if TplLang()=="D"]
Sehr geehrter Kunde !

Wir erlauben uns, Sie auf folgende noch ausstehende Rechnungen aufmerksam
zu machen :
[etc else]
Cher client,

Nous attirons votre attention sur les factures ‚chues suivantes :
[etc endif]

[=fparse("MAHNC.INC")]

[etc if TplLang()=="D"]
Wir bitten Sie, die Zahlung der berf„lligen Rechnungen zu prfen.

Sollten Sie in der Zwischenzeit die n”tigen Zahlungen schon in Auftrag
gegeben haben, so bitten wir Sie, diesen Kontoauszug als gegenstandslos 
zu betrachten.
[etc else]
Nous vous prions de r‚gler le solde sans tarder.

Si vous avez effectu‚ votre paiement entre-temps, veuillez consid‚rer le
pr‚sent rappel comme nul et non avenu.
[etc endif]

[etc if !empty(getvar("MahnMemo"))]
[=hardcr(getvar("MahnMemo"))]

[etc endif]
[=tr("Best regards","Mit freundlichen Gráen",\
  "Avec nos meilleurs compliments")]




[=UsrName()]
[=Fonction()]
