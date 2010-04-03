[=fparse("ADRPAR.TPL")]
[=FntCtrl("5cpi")][B][=iif(getvar("MahnLevel")=="0",\
  tr("","Kontoauszug","Extrait de compte"),\
  iif(getvar("MahnLevel")=="1",\
  tr("","ERSTE MAHNUNG","PREMIER RAPPEL"),\
  tr("","ZWEITE MAHNUNG","DEUXIEME RAPPEL")))][b][=FntCtrl("12cpi")]

[=tr("Date","Datum","Date")] : [=dtocf(getvar("MahnDate"))]
