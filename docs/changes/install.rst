﻿Upgrade notes
=============

When you upgrade an existing TIM installation then you should read and execute the instructions between the dates of the old and the new version. 

19970702 

- Der Integritätstest sucht jetzt ebenfalls nach einer Datei VEN.WRN, die zumindest existieren sollte (selbst wenn sie leer ist).

19970708 

- Die bisherigen Datenobjekte MVP (Historik Partnerkonten) und MVT (Historik Generalkonten) sind jetzt in einem einzigen Datenobjekt HST zusammengefasst. Die Konvertiertung geschieht größtenteils automatisch (970708.ind). hst*.qry aus Standarddatenbank übernehmen. mvp*.* und mvt*.* können nach der Konvertierung gelöscht werden. Eventuell FLT.DBF aus der Standarddatenbank übernehmen (oder manuell anpassen). mnu*.dbc manuell anpassen.

10. Juli 1997. Verschiedene Rechnungsbuchkolonnen in der
Standard-Datenbank wurden aus mnemotechnischen Gründen umbenannt, um mit
den entsprechenden Rasternummern der MWSt-Erklärung überein zu stimmen :
Einkauf : abzugsfähige MWSt. Belgien ("02") wird "59"; MWSt. Intracom
("03") wird "55"; MWSt. Vertragspartner ("04") wird "57". Verkauf :
(ähnlich) 14. Juli 1997. Die Funktion XtvEdit() habe ich
rausgeschmissen; falls noch darauf zugegriffen wird: mnu.dbc manuell
anpassen.

24. Juli 1997 Finanzjournale können jetzt ebenfalls das Attribut F
(chronologische Erfassung forcieren) kriegen. Normalerweise sollte
dieses Attribut für alle FIN-Journale gesetzt werden.

5. August 1997. In den Datenzeilen aller `.hcl`-Dateien muss am Ende ein
weiteres Alt-124 ("|") hinzugefügt werden. Default-Wert für dieses neue
Feld ist "ntomf(nSum)" (braucht nicht eingetragen zu werden).

30. August 1997. Analytische Buchhaltung : HistAna() wurde komplett neu
geschrieben (bei Installation beachten)

4. September 1997. Analytische Buchhaltung. Ein Korrespondenz-Eintrag
kann jetzt auch einem Analysekonto zugewiesen werden (neues Feld
MSG->IdAna und neue Indexdatei MSG3). [Shift-F8] auf einem Analysekonto
zeigt die Korrespondenz pro Dossier. Anwendung : TIM für Anwälte.

5. September 1997. Seit heute gibt es die Standard-Datenbank auch in 
französisch. 
Neue Funktionen DbfSwapLng(adTables,cRootFieldname,c1,c2) und SwapLng(c1,c2). 

6. September 1997. 

- Neuer Eintrag LineFeed in Druckertreibern. Standardwert = CR_LF. Beim Ausdrucken mit dem Druckertreiber HTML.DRV kann das CR_LF um ein "<br>" erweitert werden. 
- Außerdem wird seit heute die Escape-Sequenz von Initialize, {set special} und des Schriftgrads nur noch zu Beginn der ersten Seite gedruckt. 

7. September 1997. Ein paar Erweiterungen für Export-Filter : Header, Trailer, 
convert...to... und NoTitles sowie die Möglichkeit, Feldnamen mit einem Ausdruck 
statt eines konstanten Strings zu definieren. Die Funktion Daten exportieren 
wurde intern leicht verändert. Es gibt jetzt die neue Funktion 
DbfExport(adTables,nOrder,cStart,xlWhile,xlFilter,cExpFile), die man z.B. in 
einer Menü-Datei benutzen kann, um oft verwendete Datenexporte 
benutzerfreundlicher einzubauen. Bei Installation beachten: ArtEdit(), 
ParMviEdit(), LnkLniEdit() und PickGen() : der Parameter bFilter ist jetzt nicht 
mehr ein code block, sondern ein Ausdruck. Eventuell Menüdateien anpassen. 
Exportfilter : Der Eintrag OutputFile muss jetzt einen Ausdruck, nicht mehr 
einen konstanten Wert haben. Manuell anpassen. 

30. September 1997. Agenda. Die Tarife, die man einem Termin zuweisen kann, sind 
jetzt nicht mehr als Artikel zu definieren, sondern in einer eigenen Datei. Bei 
Installation beachten : Bestehende Druckmasken für Dienstleistungsberichte 
müssen manuell angepasst werden. Evtl. können die Tarife aus der ART.DBF 
übernommen werden. Dateien TAC*.QRY, TAC*.MSK und TRMTAC.QRY aus der 
Standard-Datenbank übernehmen. TRM4.NTX neu erstellen. In der Datei TRM.DBF 
wurden einige Felder umbenannt, falls der Inhalt übernommren werden soll, muss 
sie vor dem tim /check manuell angepasst werden: TRM->IdArt wird TRM->IdTac. 
  
8. Oktober 1997. Man kann jetzt in den Rechnungsbüchern das Format der (bisher 
hard-codierten) Kolonnen "Dok.Nr.", "Datum" und "Konto" selbst bestimmen. Bei 
Installation beachten : Bestehende Layout-Dateien (``*.hcl``) müssen wie folgt 
manuell konvertiert werden (aus Standard-Datenbank übernehmen). (1) hcl-Dateien 
für HistJnl() müssen jetzt ebenfalls die drei Kolonnen "Dok.Nr.", "Datum" und 
"Konto" definieren. (2) hcl-Dateien für VnlListe() müssen die Kolonnen "Art.Nr" 
und "Bezeichnung" definieren. (3) hcl-Dateien für HistAna() müssen die Kolonnen 
"Konto" und "Bezeichnung" definieren. 
Technische Dokumentation : die Funktion HclIsFirst() gibt true zurück, wenn der 
erste Record einer Gruppe gedruckt wird. HistJnl() gruppiert pro Dokument 
(HST->IdJnl+HST->IdDoc). VnlListe() gruppiert pro Artikel (VNL->IdArt). 
HistAna() gruppiert pro Analysekonto (MVA->IdAna). HclHistPar() gruppiert pro 
Partner (HST->IdPar). Die Funktion IsSame(uValue) gibt true zurück, wenn sie 
beim vorherigen Aufruf bereits mit dem gleichen Wert für uValue gerufen wurde. 
Ein Aufruf ohne Parameter, bzw. IsSame(NIL), reinitialisiert die Funktion und 
gibt immer true zurück. IsSame() wird in HistJnl() automatisch vor jedem Beginn 
einer neuen Record-Gruppe reinitialisiert. 

15. Oktober 1997. (Fakturation) Bei Installation beachten : wenn in
einer Datenbank die Gutschriften in einem eigenen Journal erfasst
werden, dann kann es vorkommen, dass die MWSt-Erklärung dies extra
berücksichtigen muss. Die Funktionen CttBase() und CttTaxe() sehen
nämlich alle Beträge als positiv an, deren Dokument die gleiche
Buchungsrichtung (D/C) hat wie das Journal. In den Feldern 81 bis 83
müssen die Gutschriften jedoch abgezogen (nicht hinzugezählt) werden.

20. Oktober 1997. Bei Installation beachten : (Konfiguration
MWSt-Erklärung). Die MWSt in Einkauf-Gutschriften auf
innergemeinschaftliche Warenlieferungen darf nicht im Feld 63 vermerkt
werden, sondern wird jetzt in den Feldern 61 und 62 eingetragen. Das
MWSt-Amt achtet nämlich darauf, dass der Betrag im Feld 63 nicht höher
als 21% des Betrags im Feld 85 (Basis der "normalen" Gutschriften).

21. Oktober 1997. Die Funktion HclHistPar() (sh. 8.10.1997) wurde
umbenannt in HclHstPar(). VnlListe() wurde umbenannt in HclVnlArt(). Der
Eintrag NoCheckIdDoc in der tim.dbi erkennt jetzt eine weitere Klausel
"until".

[technisch] ClnTit2() setzt jetzt die Kolonnentitel von numerischen
Kolonnengegen den rechten Rand, während die Titel der anderen Kolonnen
weiterhin gegen den linken Rand gesetzt sind. Dies wird z.B. sichtbar
beim Ausdruck der Rechnungsbücher.

30. Oktober 1997. In der NAT.DBC muss eine neue Kolonne Standardwährung 
hinzugefügt werden. 

5. November 1997. Neue Kolonne PGP_IDDEV in der PGP.DBC manuell anpassen. 

7. November 1997. In der Standarddatenbank fehlte noch die HSTPICK.QRY. 

9. November 1997. Neues Feld IPB->IdDev, Buchungsanweisungen. 

12. November 1997. 

- VNL->Date ist jetzt kein standardmäßig definiertes Feld mehr. Gegebenenfalls in der vnl.act definieren und CustData VNL eintragen. Die Felder VNL->_VenDate, VNL->_IdDev, VNL->IsMemo sind verschoben, also ggf. die vnl*qry-Dateien anpasssen: 

    s/column 27/column 25/
    s/column 25/column 26/ 
    s/column 26/column 27/ 
    
    24 = IdInt, 25 = IsMemo (oder QteStat), 26 = _VenDate, 27 = _IdDev

13. November 1997.

- PAR->_ParName ist jetzt außerdem standardmäßig 40 statt 32 Zeichen
  lang. VEN->ParName wurde von 30 auf 40 Zeichen verlängert.
  Gegebenenfalls also picture "@k@s30" in den entsprechenden Kolonnen
  der qry-Dateien festlegen.
 
17. November 1997.

- VNA3.NTX muss rekonstruiert werden, weil der Sortierschlüssel erweitert
  wurde : wenn mehrere Einträge pro Tag pro Artikel, dann sind diese jetzt
  zusätzlich noch nach der Partnernummer sortiert.
- MnuLoad() macht jetzt kein padr(MenuItem,30) mehr. Also müssen alle
  Einträge in den mnu*.dbc-Dateien die korrekte Länge haben. Vorteil :
  Man kann jetzt auch ein Menü haben, dessen Optionen breiter als 30
  Zeichen sind.

22. November 1997. (nicht beachten; wieder annulliert am 25.11.97) Im
Datumformat für dtocf() muss jetzt ein Backslash ("\") vor jedem Platzhalter 
stehen. 

26. November 1997 (DEF_REMISE). VNL->PrixR berücksichtigt jetzt nicht mehr die 
Menge (VNL->Qte). TIM macht die Konvertierung automatisch (971126.ind) 

Sonntag, 14. Dezember 1997::

    - q *.qry : repl all "attr S" with "skip .t."
    - q *.qry : delete "aoffset" entries

Mittwoch, 17. Dezember 1997
Neue Felder ART->GP und VNL->GP wenn DEF_PROVI.
Bei Installation beachten: field handles von cust-Feldern sind
dadurch um 1 verschoben.

24.12.97                                                                
Bei Installation beachten::

  ren main.hlp index.hlp
  ren tim*.hlp main*.hlp

08.01.1998 
Automatik-Fakturierung.
VEN->[F6] gibt es jetzt nicht mehr. Wer will, kann das in der ven.act
definieren:
ddAddSpecial({||ParVnaEdit(VEN->IdPar)},"~Fakturierungsvorschläge [F6]",-5)

08.01.1998
``*.tcs``-Dateien vom HELP-Verzeichnis ins Datenbankverzeichnis verschieben.

12.01.1998
Zahlungsverkehr mit Fremdwährung (allgemeine Buchhaltung). Die neuen
Felder _DevDebit und _DevCredit sollten in FNLDEV.QRY eingebaut werden.

19980114
- Neues Feld GEN->IdDev :
  - tim /check
  - 980114.ind

19980115
- Kundenliste nach Umsatz.
  - Datei MNUPRINT.DBC :
    ~Fakturierung|~Kundenliste Umsatz|RepPrint("PAR002","PAR002","...")
  - PAR002.REP und PAR002.DLG : Aus Standard-Datenbank übernehmen.

19980116
Automatik-Fakturierung.
PAR->[F6] gibt es jetzt nicht mehr. Wer will, kann das in der par.act
definieren:
ddAddSpecial({||ParVnaEdit(PAR->IdPar)},"~Fakturierungsvorschläge [F6]",-5)

19980127
- Die neue Tabelle IPR.DBF (Basispreise) übernimmt ab heute die
  Entscheidung, welches Preisfeld der Artikelstammdaten in einem
  Fakturationsdokument als Standardvorgabe verwendet werden soll.
  Damit entlastet sie die Tabelle PGP.DBC, die wieder zu ihrem
  ursprünglichen Ziel zurückschrumpft, nämlich eine Tabelle der
  Partner-Preisgruppen zu sein.
  Bei Installation beachten :
  - Befehl "Basispreise" in MNUBOSS.DBC einbauen.
  - Bisherige PGP.DBC manuell in die IPR.DBF übertragen.
  - PGP.DBC manuell anpassen.

19980204
- Automatik-Fakturierung. Bei Installation beachten.
  Verschiedene Anpassungen.

19980209
- Report-Generator (RepPrint()). Die when= Klausel eines total kriegt
  jetzt nicht mehr nGroup als Parameter, sondern die Anzahl der Records,
  die (für diese Gruppe) in diesem Total berücksichtigt wurden.
  => "q *.rep" und nachschauen, ob dieser Parameter benutzt wird.

19980216
- Bei Installation beachten : Der Eintrag Inputfile aller *.imp-Dateien
  muss jetzt zwischen Anführungszeichen stehen.
  => "q *.imp" und
    Inputfile import.txt
  ersetzen durch
    Inputfile "import.txt"

19980227
- Daten exportieren. Wenn der Dateiname im Exportfilter (*.exp) keine
  Pfadangabe enthält, schreibt TIM die Datei jetzt nicht mehr nach
  c:\tim\export, sondern nach c:\tim\temp.

19980305
- Wenn DEF_ART und nicht DEF_ACF, dann ist das Feld ART->RefExt jetzt
  standardmäßig vordefiniert. Bei Installation beachten : wenn in der
  ART.ACT also ein Feld RefExt definiert war, muss dieses versteckt
  (Attribut H setzen) und die ART*.MSKs sowie die ART*.QRYs angepasst
  werden. Eintrag LenRefExt in der TIM.DBI ist das gleiche wie
  LenAcfRef.

19980309
- DEF_MULT. Neues Feld VNL->Mult = Multiplikator.
  Field handles von cust-Feldern aus der VNL.ACT haben sich dadurch um 1
  erhöht. Also "q vnl*.qry" und "q vnl*.msk" : handle++ if handle >= 38.

19980312
- Das DLGATTR_R wird jetzt nicht mehr berücksichtigt.
  Bei Installation beachten : für jedes field mit attrib="R" muss
  stattdessen ein "before DlgDefine()" angegeben werden.
  Also q *.dlg und nach attrib="R" suchen.

xxxx
- Der Eintrag title in Dialogdateien muss jetzt eine expression (kein
  Codeblock mehr) sein.
  q *.dlg

19980324
  Fakturierung. Die Taste [F5] auf einem Partner ist jetzt
  konfigurierbar. Um die bisherige Belegung zu behalten, muss folgender
  Eintrag in der par.act gemacht werden :
  ddAddSpecial(\
    {||ParVenEdit(PAR->IdPar)},\
    "~Fakturationsdokumente  [F5]",\
    -4\
  )
  Eine mögliche Alternative zur bisherigen Belegung wäre :
  ddAddSpecial(\
    {||DbfEdit(\
       { oVen(),oPar(),oPlz() },\
       "Fakturationsdokumente",\
       "VENPAR",NIL,NIL,\
       PAR->IdPar,"VEN->IdPar",\
       NIL,\
       "VenCreate('" + PAR->IdPar + "')"\
    )},\
    "~Fakturationsdokumente  [F5]",\
    -4\
  )
  (Wobei VENPAR.QRY die Dokumente aller Journale pro Partner nach Datum
  sortiert).

19980326
- In der tim.dbi kann jetzt ein neuer Eintrag OnMainMenu stehen (oder
  mehrere). Bei Installation beachten : die bisherigen Standardvorgaben
  folgendermaßen eintragen :
  OnMainMenu SayAgenda(UserDate())  // DEF_PRESTO
  oder
  OnMainMenu memodisplay(\
    StrParse(memoread(dbPath()+"\news.txt")),\
    1,0,21,80\
  )

19980330
- Die Artikelattribute sind jetzt nicht mehr hard-codiert und können und
  müssen jetzt in der Datei ARTATTR.DBC definiert werden.

19980402
- PLZ.QRY kopieren nach PLZNAT.QRY

19980421
- DEF_VNA. Um das bisherige Verhalten bei [Insert] auf der VNA.DBF
  beizubehalten, müssen folgende Einträge in der tim.dbi hinzugefügt
  werden:
  PreVnaCreate "B" $ UsrAttrib()
  PreVnaCreate Confirm(\
    "Fakturationsvorschlag manuell erstellen.",\
    MsgSure()\
  )

19980423
- DEF_TAX und DEF_VEN. REGATTR_A in der REGATTR.DBC eintragen und
  eventuell für alle MWSt-Regimes einschalten.
- DEF_VNA. Die Taste [F6] auf einem Artikel war bisher noch
  hard-codiert. Jetzt nicht mehr. Datei ART.ACT anpassen :
  ddAddSpecial(\
    {||ArtVnaEdit(ART->IdArt)},\
    "Fakturierungs~vorschläge   [F6]",\
    -5\
  )

19980430
- ren ???.ACT ???.DEF
- DEF_VEN. Der Eintrag OnVenCreate in der TIM.DBI kann (und muss) durch
  einen entsprechenden Eintrag ddOnCreate() in der VEN.DEF ersetzt
  werden.
  Beispiel :
  OnVenCreate({||VenCarry(...)})     // tim.dbi
  ersetzen durch
  ddOnCreate('VenCarry(...)')        // ven.act


19980507
- Neuer Eintrag PrePerAppend in der tim.dbi.
  Standardwert = {||.f.}.
  Außer in Ausnahmefällen (CUST_CPAS) ist folgende Belegung
  angebrachter:
  PrePerAppend {|cPeriode|Confirm(\
    cPeriode + MsgPerExist(), \
    "Neue Buchungsperiode erstellen (J/N) ?" \
  )}

19980519
- tim.dbi :
  OnVnlIdValidate {|| xyz} ersetzen durch (einen oder mehrere)
  VnlIdValidate xyz.
  OnVenParValidate {|| xyz} ersetzen durch (einen oder mehrere)
  VenParValidate xyz.

19980525 CUST_HOLZ
- Neues Feld CLS_MZ -> Datei CLS.DBC anpassen
- PrjStmList() hat jetzt andere Parameter.

19980526 DEF_IVT
- [Shift-F7] in einer Artikelliste zeigt jetzt kein
  Zwischenmenü mehr an. Für DEF_IVT bei Installation beachten.

19980603
- Aufrufe VenPrint() umbenennen nach VenDoPrint(),
  Aufrufe VenDlgPrint() nach VenPrint().
- ArtP1Validate() setzt jetzt ART->DatPrix auf UserDate(). Okay?
- [F12] auf VNL (VnlGetMemo()) ist jetzt nicht mehr hard-codiert und muss
  also in der VNL.DEF zugewiesen werden:
  ddAddSpecial(\
    {||VnlGetMemo()},\
    MnuMemoedit(),\
    -41\
  )

19980610
- Datei GRAATTR.DBC aus Standarddatenbank übernehmen.
- GraPickAttrib() in der GRA.DEF zuweisen :
  ddAddSpecial(\
    {||GraPickAttrib()}, \
    "~Attribute                     ",\
    -36\
  )
- Der bisherige Befehl "before" in *.rep-Dateien wurde umbenannt
  in "ValidateRecord" (wird automatisch gemacht).

19980611
- PreVnaCollect in der TIM.DBI kann z.B. entscheiden, ob
  die Zwischensummen automatisch weiterfakturiert werden sollen. Siehe
  auch Änderung vom 19980512. Standardwert:
  PreVnaCollect {|| VNL->Code $ "GAFTM#"}

19980617
- Das neue Tool fparse.exe ersetzt ab sofort die bisherige btp2bat.exe.
- CUST_CPAS. ParSalden() setzt jetzt nicht mehr die PUBLIC-Variable
  MemParSalden. Dieser Mechanismus versagt nämlich, wenn mehrere
  Benutzer gleichzeitig auf die Idee kommen, die Prozedur zu starten.
  Stattdessen: (1) siehe nächster Punkt.
               (2) Eintrag OnMainMenu in der tim.dbi:
               OnMainMenu DlgDefine("ParSalDate",IndDate("PARSALD"))
               (3) in der PARMAHN.MSK das virtuelle Feld "MemParSalden"
               ersetzen durch DlgValue("ParSalDate")
- Arbeiten mit Indikatordateien.
  Die folgenden Funktionen sind interessant, (1) um zu kontrollieren, ob
  (und wenn ja, wann) eine Prozedur zuletzt ausgeführt worden ist, bzw.
  (2) um zu gewährleisten, dass eine Prozedur nur von einem Benutzer auf
  einmal ausgeführt werden kann:
  - IndOpen("TEST") öffnet eine Datei TEST.IND im Datenbankverzeichnis.
    Die Datei bleibt exklusiv geöffnet, bis IndClose() oder IndDelete()
    gerufen wird (oder bis dass TIM beendet wird).
  - IndClose("TEST") schließt die Datei und lässt sie stehen.
  - IndDelete("TEST") schließt und löscht die Datei.
  - IndDate("TEST") gibt das Datum der Datei (oder ctod("") wenn sie
    nicht existiert)
  - IndExist("TEST") gibt .t. zurück, wenn die Datei existiert.
  Anwendungsbeispiel: Statt die Funktion ParSalden() direkt aus der
  MNU.DBC heraus zu rufen, wird mit ActExec("PARSALD") die Datei
  PARSALD.ACT ausgeführt, die folgenden Inhalt hat:
    !IndExist("PARSALD").or.Confirm(\
      "Wurde zuletzt am "+dtoc(IndDate("PARSALD"))+" ausgeführt.",\
      MsgSure(),"N"\
    )
    IndOpen("PARSALD","(Partnersalden)").or.!Warning(\
      "Wird momentan von einem anderen Benutzer ausgeführt !"\
    )
    ParSalden().or.!IndDelete("PARSALD")
    IndClose("PARSALD")
    SetMnuDone()

19980623
- Konfiguration MWSt-Erklärung. Nicht-abzugsfähige MWSt wurde im Feld 84
  und 85 nicht berücksichtigt.
- mnu*.dbc : in den Aufrufen von VenTvaListe() muss cIdReg manuell durch
  xlParFilter ersetzt werden. Der bisherige Parameter cIdReg wurde
  intern in der Bedingung "PAR->IdReg $ cIdReg" ausgewertet.

19980630
- DEF_ARC (Aufräumen). Die bisherige Funktion Aufraeumen() heißt jetzt
  JnlClean() : MNUBOSS.DBC anpassen.
  + Datei JNLPICK.QRY machen.

19980701
- Datei setup.btp im Programmverzeichnis löschen Diese Datei (die nichts
  anderes tut als FPARSE mit den korrekten Installationsparametern
  aufzurufen) wird jetzt einmalig von der install.bat erstellt. Datei
  setup.bat ggf. korrigieren.

19980702
- Wenn DEF_CONSOLE, müssen die folgenden Einträge in der par.def hinzu
  gefügt werden:
    ddOnDelete('\
      SendConsole("PAR delete " + PAR->IdPar + " : " + trim(ParName()))\
    ')
    ddOnCreate('\
      SendConsole("PAR create " + PAR->IdPar)\
    ')
    // diese Konsolenmeldung war eigentlich unnötig...
    // ddPreEdit({||ParPreEdit().and.\
    //   SendConsole("PAR modify " + PAR->IdPar + " : " + trim(ParName()))\
    // })
    ddSetAttrib("S")
    // Tabellenattribut "S" heißt, dass jede einzelne Änderung in der
    // Vollbildmaske zur console.msg protokolliert wird.
- "keep report on" in der tim.ini ersetzen durch
    OnLogin() SetKeepReport(.t.)
  in der tim.dbi
  N.B.: "keep report off" ist der Standardwert und kann einfach
  rausgeholt werden.

19980702
  *.dlg :
    field name="preview" ... value="X" ...
  muss ersetzt werden durch
    field block={|x|SetPreview(x)}
  Dadurch ist es jetzt möglich, den Druckparametersatz und Seitenbereich
  (Seite von... bis) in eine dlg-Datei einzubauen. Bisher war das nicht
  möglich. Dazu benutzt man den folgenden field-Befehl :
    field block={|x|SetRange(x)} [value=space(10)]
    field block={|x|SetTplIni(x)} [value="STD"]

19980720
- CUST_AVOD :
  - Aus Standarddatenbank AVOD übernehmen :
    *.dlg, *.rep, 980617.ind, *.def, ipr*.*, dev*.qry, gen.qry, ifc.qry,
    reg.qry, ven.wrn, flt.dbf, fnl*.qry, fin*.qry, hst*.qry, ctr*.qry,
    *.def
  - Anpassen : tim.dbi, mnu*.dbc, ctr.dbf
  - Löschen : ???.act
  - Manuell ändern : Generalkonten 4010..4060 umbenennen nach
    6010..6060.

19980722 (CUST_HOLZ)
- STM.DEF : Felder VKLIdDoc und VKLLine sowie EKLIdDoc und EKLLine
  manuell definieren.
- Bestehende Daten manuell konvertieren. Anschließend evtl. die Felder
  STM->IdJnl, STM->IdDoc und STM->Line löschen. Sie werden nicht mehr
  benutzt.
- STMVEN.QRY -> STMVKL.QRY und STMEKL.QRY
- Einträge OnStmCreate oder PreStmCopy in der tim.dbi sind jetzt evtl.
  nicht mehr nötig.

19980727
- DEF_VNLALT : in tim.dbi und vnl.def alle "VNL->" durch "FIELD->"
  ersetzen.
  vor tim /check : ren vnl.db* vnldef.*
  ! alle Fakturationsdokumente müssen registriert sein !
- Die Funktion Umbenennen [Alt-F2] muss (wenn man sie benutzen will)
  manuell in der jeweiligen def-Datei deklariert werden. K_ALT_F2 = -31
  - GEN.DEF :
    ddAddSpecial({||GenRename()}, MsgMnuRename(), -31 )
  - PAR.DEF :
    ddAddSpecial({||ParRename()}, MsgMnuRename(), -31 )
  - ART.DEF :
    ddAddSpecial({||ArtRename()}, MsgMnuRename(), -31 )
  - GRA.DEF :
    ddAddSpecial({||GraRename()}, MsgMnuRename(), -31 )
  - VEN.DEF :
    ddAddSpecial({||VenRename()}, MsgMnuRename(), -31 )
  - FIN.DEF :
    ddAddSpecial({||FinRename()}, MsgMnuRename(), -31 )
  - PLS.DEF :
    ddAddSpecial({||PlsRename()}, MsgMnuRename(), -31 )
- Neue Funktion HstDevTest() ins Verwaltermenü einbauen.

19980811
- DEF_VNLALT :
  - Dateien VNLDEF.QRY und VNLPRE.QRY aus 300D übernehmen.
  - MNUBOSS.DBC manuell anpassen :
  |~Globallisten|~VNLPRE.DBF                   |ArtVnlInit()!=NIL.and.DbfEdit({oVnl(DocStatOpen()),oVen(),oPar(),oArt(),oGen()},"VNLPRE.DBF")
  |~Globallisten|~VNLDEF.DBF                   |ArtVnlInit()!=NIL.and.DbfEdit({oVnl(DocStatClosed()),oVen(),oPar(),oArt(),oGen()},"VNLDEF.DBF")
  |~Globallisten|~VnlClean()                   |VnlClean()
  |~Globallisten|~unregistrierte Dokumente     |DbfEdit(...)
  - Alle Dokumente müssen registriert sein. Datei VNL.DB* umbenennen
    nach VNLDEF.DB*. Dateien VNL*.NTX löschen. TIM /CHECK.

19980907 CUST_CPAS
  Vorbereitungen Euro für ÖSHZ :
  - Verschiedene Journale werden immer nur in der Grundwährung (je nach
    Periode) ausgestellt. Die Währung soll zwar sichtbar, aber nicht
    editierbar sein.
    - TIM.DBI : CustData +IMP
    - IMP.DEF (neu) : ddFldSetWhen("IdDev","IMP->IdJnl$'REG GUT ...'")
  - Folgende Dateien müssen aus der bisherigen Testdatenbank EURO
    übernommen werden:
    IMP*.QRY, IMP*.MSK
    IML*.QRY,
    TPL.DB*
    TIM.DBI
    IMP.DEF
    DEV.DB*
    DEV.QRY
    (Wegen Parsalden)
    PARSALD.ACT
    MNU.DBC
    PAR*.MSK
    MVI*.QRY

19980907 DEF_VEN
  In der VEN.DEF folgenden Eintrag hinzufügen :
  ddEditDetail("VEN->Etat!=DocStatNew().or.VenDetail()")
  hinzufügen. Ansonsten kommt nach dem Bearbeiten des oberen
  Bildschirmteils nicht mehr automatisch der untere, sondern man muss
  ein zusätzliches [Enter] drücken...

19980925 DEF_PLS
Die Aufrufe ParMbrEdit(PAR->IdPar) ("Info-Einträge" oder "ist Mitglied
in ...") und ParMbrBrowse(PAR->IdPar) ("Info-Editor") sind jetzt nicht
mehr hard-codiert.
Also in der PAR.DEF hinzufügen :
  ddAddSpecial( \
    {||ParMbrEdit(PAR->IdPar)},   \
    "~Info-Einträge          [Sh-F6]" , \
    -15\
  )
  ddAddSpecial( \
    {||ParMbrBrowse(PAR->IdPar)}, \
    "In~fo-Editor               [F6]" , \
    -5\
  )

19980930 DEF_PLS
- Datei PLSATTR.DBC aus Standarddatenbank übernehmen.
- PlsPickAttrib() in der PLS.DEF zuweisen :
  ddAddSpecial(\
    {||PlsPickAttrib()}, \
    "~Attribute                     ",\
    -36\
  )

19981019
- DEF_RPQ (Mengenrabatte) IFCATTR_U. Testen: wird VnlReset(Stückpreis)
  korrekt ausgeführt, wenn bei Sammelrechnung ein neuer Mengenrabatt
  anwendbar ist?

19981028
- Statt VnlPuMult() gibt es jetzt VnlPu() und VnlPuF(). Die erstere gibt
  den (gerundeten) Stückpreis als numerischen Wert, die zweitere das
  gleiche in formatiert (Leerzeichen wenn 0).

19981113
- Die Tabelle NAT.DBC ist jetzt als DBF-Datei implementiert.
  - Dateien NAT.DEF, NAT.QRY, NATPICK.QRY, NAT.MSK und NATCREA.DLG
    aus Standarddatenbank übernehmen.
  - Die Konvertierung an sich geht automatisch (981113.ind; tim /check).
  - Achtung: die Funktion NatField(cIdNat,nField) wurde ersetzt durch
    NatField(cIdNat,xuField).
  - tim.dbi : CustData NAT eintragen

19981116
- Fakturation mit Zwischensummen: Evtl. VNL.DEF anpassen
    ddPostDelete("VnlTotRefresh()")
  Dadurch werden nach dem Löschen eines Records auch die Zwischensummen
  neu berechnet.
- Maskenbefehle, die mit {==xcExpr} beginnen, können (und müssen) manuell
  auf {=xcExpr} verändert werden. Maskenbefehle vom Typ {=xcExpr} wurden
  bisher nochmals intern durch StrParse() geschickt, bevor sie durch
  xparse() geschickt wurden. Das doppelte "=" hieß dann, dass xcExpr
  *nicht* durch StrParse() geschickt werden soll. Seit heute aber wird
  xcExpr überhaupt nicht mehr durch StrParse() geschickt.

19981218
- DEF_ACF. Allgemeine Parameter, MemPickArtMode "P" gibt es jetzt nicht
  mehr, sondern stattdessen wird je nach Journal und Alias in einer
  PICKART.ACT die Funktion ParArtPick() gerufen.

19981222
- AppNormEnd(cCommand) schreibt die Datei AFTER.BAT jetzt nicht mehr ins
  Programmverzeichnis, sondern ins Benutzerverzeichnis.
  -> Neue Datei tim.btp installieren.

19990126
- DEF_FIN. Evtl. FNLFILL.DLG aus Standarddatenbank aufspielen.

19990201
- DEF_ALA : F9 ArtAlaEdit(ART->IdArt) jetzt nicht mehr hardcodiert.
  Also ART.DEF ddAddSpecial(...) anpassen.

19990202
- DEF_HOLZ. Neue Datei STMATTR.DBC aus Standarddatenbank kopieren.

19990203
- DEF_VNA. Neuer Eintrag PreVnaUndo in der tim.dbi, falls die VNA.DEF
  benutzerdefinierte Felder hat.

19990209
- Evtl. DBCHECK einbauen :
  - DBCHECK.DLG
  - TIM.DBI (sh. 220d)
  - MNU.DBC : "Datenbank-Check"

19990216
- FinOtiCreate() macht jetzt Interbankdateien in Version 3 oder 5 statt
  bisher 2
- Der Parameter cRemise in ParVnaAuto() wurde wieder rausgeholt.
  VEN->Remise muss z.B. über eine ddOnCreate()-Anweisung gesetzt werden.

19990217
- Liste der innergemeinschaftlichen Kunden.
  - Dateien LSTTVAI.DLG und LSTTVAI.LST aufspielen.
  - MNUPRINT.DBC : DlgExec() statt VenTvaListe()
  - evtl. INC-Textblock TVA-I anpassen. pnQuarter() statt PerText()

19990223
- DEF_VENREMISE. Dateien VNR*.* aus Standarddatenbank übernehmen. Evtl.
  auch Befehl "Konfigurierung|Ermäßigungen" in MNUBOSS.DBC eintragen.
  Letzteres ist nur nötig, wenn man die Standardeinstellungen verändern
  will.

19990225
- dbback.btp :
  - "-x arjtemp.*"
  - auf der zweiten und dritten Diskette wurde formatiert statt del a:.
  - Hinweis "Programm passt noch mit auf gleiche Diskette" raus.

19990301
- Einen eventuellen Eintrag
    VenMatch {|| xyz}
  in der TIM.DBI ersetzen durch
    VenMatch xyz
  (also keine Codeblock-Klammern mehr).
- StaticMemo-Einträge in der tim.dbi durch #static-Anweisungen in den
  betreffenden Dateien ersetzen.

19990308
- VenTvaListe(). Prüfen, ob CTR->DC richtig gesetzt ist:
  Verkauf D, Einkauf C.

19990312
- DEF_STK. Neuer Typ STKTYPE_LAST ("L") für Einträge in der STK.DBC. Die
  STK.DBC muss ein weiteres Feld auf jeder Zeile haben, das nur benutzt
  wird für STKTYPE_LAST.

19990319
- Dateien DCLTVA.* aus Standarddatenbank 220D übernehmen.
- Sammelhistoriken rekonstruieren wegen CttRebuild()

19990323
- CUST_CPAS.
  - MNU.DBC anpassen : TraCentral() ersetzen durch ActExec("TRACTL")
  - Dateien TRACTL.ACT, RLB*.ACT und TRACTL.DLG aus Standarddatenbank
    übernehmen.

19990331
- *.hcl-Dateien evtl. aus Standarddatenbank übernehmen.
   - Kolonne "Datum" verbreitern oder dtocf() verwenden.
   - FINDEV und FINDB : "Endsaldo" -> "Salden"

19990331
- CUST_CPAS : die folgenden Textblocks müssen gemacht werden
  (ggf. leer sein)
   HHR R12A
   HHR R12E
   HHR R12DA
   HHR R12DE
 TPL->Width leer oder auf 0, damit es die gleiche Schrift wird.

19990419
- UsrIsAlone() macht jetzt nicht mehr selber die Warnung, wenn jemand
  anderer in der Datenbank arbeit.
  => mit "ts *.*" nach "UsrIsAlone" suchen
     oder mit "q *.act tim.dbi *.dlg"

19990428
- DEF_ACF.
  - ART.DEF :
    ddAddSpecial({||ArtAcfEdit()},MnuAcfEdit(),-11)
    Alternative:
    ddAddSpecial({||ArtAcfEdit(NIL,NIL,"ActExec('ARTACFUP')")},MnuAcfEdit(),-11)

  - PAR.DEF:
    ddAddSpecial({||ParAcfEdit(PAR->IdPar)},MnuAcfEdit(),-11)

19990503
- DEV->Cours2 muss jetzt *dividiv* sein (also nicht mehr mulitiplikativ,
  sondern so, wie der Wechselkurs normalerweise in den offiziellen
  Tabellen steht). Währungstabelle anpassen.
- TIM.DBI : ggf. PerDevFixed eintragen.

19990701
- Hier ein Trick, um die "letzte Dokumentnummer" komfortabler verwalten
  zu können.
  
  - Datei JNLIDDOC.DLG
     
  - VEN.DEF, FIN.DEF und ODS.DEF ::
     ddAddSpecial(\
       {||DlgExec("JNLIDDOC")}, \
       "~Letzte Dokumentnummer         ",\
       NIL,{||"S"$UsrAttrib()}\
     )

19990720
- VNA3.NTX (ORD_VNA_ARTDATE) enthält jetzt nicht mehr die Periode. Also
  neu erstellen und prüfen, ob auch alle reports noch funktionieren

19990801
- evtl. HSTDELE.DLG aufspielen

19990820
- evtl. PLZ*.QRY und entsprechende Einträge in der FLT.DBF aufspielen.

19990915
- CUST_RZKB : FnlHstFill() Defaultwert für scTagLine wurde verändert.

19991020
- HSTFIN.REP und HSTVEN.REP anpassen::

     header2 PerText()
     
  ersetzen durch::
  
   header2 PerText(cblock("JNL->IdJnl=='"+DlgValue("IdJnlVen")+"'"))

- DEF_ACF : ArtAcfEdit() ruft xlAfter jetzt immer auf, nicht nur, wenn
  man mit F10 rausgegangen ist. Evtl. in der aufgerufenen ACT-Datei
  hinzufügen::
  
    RETURN .t. if ddLastKey() == 27

19991021
- DEF_HST. Evtl. HSTPAR.PKG und PARHST01.REP aufspielen.

19991124

- CUST_CPASANA. In der BUD.DEF hinzufügen::

   ddAddField("IdGen","C",LenIdGen(),0,\
     "@k@!",NIL,\
     NIL,NIL,\
     NIL,{|x|PickGen(NIL,x)},NIL, \
     {|x| GetIdGen(x) } \
   }
   
- Folgende Dateien aus TEST übernehmen::

   ANA*.QRY+MSK+DB*
   MVA*.QRY
   CTA*.QRY
   GEN*.QRY+MSK+DB*
   ODA*.QRY+MSK
   CTR*.QRY
   BUD.MSK

- Journal "ANA" (Typ ODA) erstellen

- MNU.DBC anpassen

- JNLATTR_Y setzen für REG und/oder AAW


19991214
- FinOtiCreate() macht jetzt eine komplett andere Dateistruktur, die der
  Ciri-Interbank-Spezifikation entspricht.

19991221
- Evtl. FNLFILL.DLG aus der 220D übernehmen ("Zahlungsziel bis zum")

19991223 : DEF_TAX : MWSt-Erklärung
- VenCttUpdate() registriert ein negatives Dokument jetzt
  automatisch als Gutschrift. Also Sammelhistorik rekonstruieren.
- HSTVEN.REP anpassen : VenIsNc()
- DCLTVA.PKG aufspielen
- TAX.QRY aufspielen und RegList und xlValid eintragen.
- VNL.DEF : Die diversen Tests IdTax/IdReg mit ddOnPostEdit() sind nun
  unnütz und sollten rausgeschmissen werden.

20000117
- evtl. DCLTVA.ACT aufspielen.
- evtl. alle *.dlg prüfen und "Seiten von-bis" einbauen.

20000124
- Jedes [etc if] muss jetzt ein [etc endif]
  haben, denn wenn man mehrere [etc if]'s ohne [etc endif]
  hintereinander hatte, dann können anschließende [etc endif]
  überraschende Resultate hervorrufen.

20000127
- CUST_ETS :
  VnlIsModDetail {|| "D"$VNL->Attrib.or."H"$VNL->Attrib}
  in der TIM.DBI einbauen.

20000201
- DCLTVA.LST : set montant S12 statt Z12

20000210
- evtl. PARSEEK.* und ADRSEEK.* aufspielen. + Eintrag in der PAR.DEF
  bzw. ART.DEF sowie jeweils neue Ansicht "Text suchen".

20000215

- Dateien jnl*.qry und jnl.msk aufspielen.

- :command:`tim /check` wegen JNL->SeqType. A00215.IND initialisiert JNL->SeqType.
  Nummerierungsart nachprüfen.
  NoCheckIdDoc in der tim.dbi kann jetzt im Prinzip raus.
  CheckIdDoc ebenfalls.
  
- Der folgende Eintrag in der tim.dbi fehlte bisher::

    OnRebuild {|cText| IndDelete("TIMTEST")}

20000221
- Evtl. DBCHECK.DLG und DBCHECK.ACT aufspielen. (Auch in der MNU.DBC
  DlgExec() durch ActExec() ersetzen !)
  - "Der letzte Integritätstest..."
  - Fällt nicht mehr drauf rein, wenn man alle Ankreuzfelder ausschaltet
    und dann bestätigt.

20000504
- Memo2Tex() erkennt jetzt selber, wenn ein Memotext mit "#TeX" beginnt
  und macht im anderen Fall selber DrvCvtString().
  Also in den *.tex-Dokumentmasken alle
    [=Memo2Tex(x)]
  ersetzen durch
  [etc do ToStream(Memo2Tex(x))]
- Nachprüfen, ob in der tim.dbi der folgende Eintrag steht::

    OnRebuild {|cText| IndDelete("TIMTEST",cText)}
    
  wenn ja, ersetzen durch::
  
    OnRebuild {|cText| IndDelete("TIMTEST")}
  
  (Sonst kommt nach einem Absturz ein "Argument error : .not.")

20000511
- BUDATTR.DBC aus Standarddatenbank CPAS aufspielen.

20000515
- Evtl. ``ddAddSpecial({||ddPaste()},NIL,-1)`` in der VNL.DEF oder STM.DEF
  einfügen.

20000605
- evtl. makepdf.drv, prn2pdf.bat und pakepdf.exe aufspielen.
- (nicht mehr nötig seit 20010701:)
  {=p_SetCopies(x)} ersetzen durch {etc do p_SetCopies(x)}

20000706
- CUST_CPAS : CDC->Expr und BUD.DEF anpassen, 20000706.act ausführen.

20001127
- Falls vorhanden,
  Remise(x,y) ersetzen durch str(Remise(x,y),6,2)+"%"

2001-01-18
- Integritätstest laufen lassen :
  - meldet jetzt Dokumente, in denen VEN->Mont nicht mit
    HST->Mont übereinstimmte. VEN->Mont manuell korrigieren.
  - Wenn der TIM bereits 1996 benutzt wurde und "Inhalt widerspricht
    Historik" oder "MontDev ist leer" kommt :
    Historik 1996 rekonstruieren (vorher ggf. jnlundo)

2001-01-20
- HSTGEN.REP und GENHST.REP aufspielen und aktivieren. HistGen() und
  BalGen() sollten nicht mehr benutzt werden, weil sie den Beginnsaldo
  (noch) nicht richtig errechnen.
- In der MNUBOSS.DBC den Befehl Datenbank|Übertragsbuchung aktivieren.
  Der wird benutzt, um von BEF nach EUR zu konvertieren.
- JNL->IdDev für REP sollte auf BEF stehen, damit FNL->MontDev in BEF
  für Generalkonten beibehalten wird.
- In allen FIN*.MSK und FIN*.QRY die Währung sichtbar machen.
  Oder besser FINOPD.QRY und FINOPD.MSK aus 220d übernehmen.
- Eventuell JNLATTR_B für FIN-Journale mit JNL->IdDev == "BEF" setzen.

2001-01-24
- Der dritte Parameter von fparse() ist jetzt nicht mehr nBytes, sondern
  cCmdTags. LaTeX : texparse.act anpassen : "[]" als dritten Parameter für
  fparse()

2001-02-01 : DEF_BIL jetzt wieder im tim220d drin.
- GENHST.*, HSTGEN.*, HSTPAR.*, PARHST.*
- LSTTVA*.*
- BIL*.*, GENBIL.*
- Manuell anpassen :
  - TIM.DBI : CustData BIL
  - MNUPRINT.DBC

2001-02-16
- LSTTVA*.* aufspielen

2001-02-20
- HSTFIN.REP und DLG aufspielen.
- HSTVEN.REP, DLG und (neu:) HSTVEN.DBC
  (nicht mehr: Ausserdem evtl.
  DlgDefault("HstVenCols","...")
  in TIM.DBI)

2001-02-21
- DEF_INT (Intrastat) : JNLATTR_I setzen für Journale, die HSI
  generieren.

2001-04-11
- tim /check wegen HST->IdDev. A10411.IND erstellen lassen.
- aus Standarddatenbank übernehmen :
  - HST*.QRY aufspielen.
  - FNL*.EXP und FNL*.IMP
  - GENHST.REP
  - LSTTVAI.DLG
  - FNLFILL.DLG (und evtl. FNL.DEF sowie TIM.DBI anpassen)

2001-04-18
- DCLTVA.* aktualisieren.
- Neuen MWSt-Code IS0 anlegen. Für MWSt-Code IS Warnung "nicht in
  Gutschriften" einbauen. Integritätstest laufen lassen um evtl.
  gebuchte Dokumente auszumachen. Falls es davon welche gibt:
  ddFldSetWhen("Etat","'E'$UsrAttrib()") in der VEN.DEF einbauen und
  diese Dokumente manuell korrigieren.

2001-04-19
- Prüfen, ob StkReset() irgendwo aufgerufen wird. Ggf. Menüs anpassen.

2001-04-20
- Folgende *.dlg-Dateien riefen PickGen(x) statt PickGen(NIL,x) auf:
  hstgen, genhst, hstfilt, fnlfill

2001-04-21
- HSTVEN.* aufspielen. Jetzt kann man auch mit "*" eine Kolonne
  "hors décl." drucken lassen.

2001-05-10 :
- tim.dbi : ArtIdDev "BEF" oder ArtIdDev "EUR" eintragen.

Verwaltermenü Konfigurierung|Basispreise:
val(ART->Prix1)
ersetzen durch
ArtPrix1(VEN->Periode)

val(ART->PrixR) ersetzen durch
ArtPrixR(VEN->Periode)

2001-07-11
- evtl. OnLogin SetPeriode(PerActive()) in der tim.dbi
  eintragen. Sonst werden die Salden in "Offene Posten Partner" mal in
  BEF und mal in EUR angezeigt (je nach Inhalt von MemPer1, und MemPer1
  hängt davon ab, welche Liste man zuletzt ausgedruckt hat... das ist
  irritierend)

2001-07-12
- Dateien HSTGEN.* und HSTPAR.* von 220D aufspielen
  - Historik Generalkonten funktionierte nicht wenn Konten von-bis
  - Historik Partner fragte nicht nach Seiten von-bis

- HSTPARD.QRY und hstparm.qry zeigen jetzt die Summen korrekt an.

2001-07-17
- HSTVEN.REP aufspielen. (Nimmt jetzt auch Basisbeträge mit MWSt-Code
  "NC " in Fach 87 rein.)

2001-07-18
- hstven.* und ctr.qry aufspielen.
  tim/check und manuell CTR->HstCols setzen. (Standard ist "0ANCIS")
  DlgDefault("HstVenCols") in der tim.dbi ist jetzt nicht mehr nötig.
- genhst.* aufspielen

2001-07-19
- Falls ein Eintrag PublicDbfs in der TIM.INI benutzt wird, muss dieser
  ersetzt werden. Stattdessen muss eine eigene DLL in jeder TIM.DBI
  definiert werden:
  AddDllDir AppPath()

2001-07-23
- dcltva.rtf aufspielen. Könnte jetzt den Anforderungen des MWSt-Amts
  entsprechen.
- evtl. rtf.drv aufspielen.

2001-07-23
- PARHST.* übernehmen.
- HSTSATIS.* aufspielen und in MNUBOSS.DBC
  einbauen (Datenbank|Lettrierungen rekonstruieren)
  Um die Beginnsalden der Partnerkonten ins erste EUR-Jahr zu
  übernehmen, müssen diese im letzten BEF-Jahr (Periode 99)
  abgeschlossen und im ersten EUR-Jahr (Periode 00) wieder eröffnet
  werden.
- FNLFILL.DLG aufspielen.

2001-07-31
- tim /check weil jetzt DEF_PRJ und DEF_ANA ggf. leere Dateien erstellen
  wollen.
- DEF_PRJ und DEF_ANA (außer wenn DEF_IMP). Nach dem Aufspielen der
  neuen Version muss der Installationscode geändert werden, weil DEF_PRJ
  jetzt nicht mehr die Option J bewirkt. Idem für DEF_ANA mit Option Y.

2001-08-02
- TIM.DBI :
    AddDllDir AppPath()
  Jetzt obligatorisch für alle.
  Denn Druckertreiber werden jetzt ebenfalls nach dem DLL-Konzept
  gesucht.

2002-01-08 :
- Falls nText() irgendwo direkt aufgerufen wird:
  Interface geändert:
  Vorher : nText(nMont,cLangue,lFull,nDecPos)
  Jetzt : nText(cMont,cLangue,lFull)

2002-01-09
- HSTGEN.* und DCLTVA.* aufspielen.
- IPB.QRY aufspielen
- tim /check wegen IPB->IdDma
- evtl. Datei DMA.DBC (domaines d'activité (Geschäftsbereiche)) anlegen.
  Falls mindestens ein IPB->IdDma nicht leer ist, dann muss in der ART.DEF
  ein Feld IdDma definiert werden:
ddAddField("IdDma","C",1,0,"@k@!",NIL,\
  NIL,NIL,NIL,\
  {|x|PickDbcCode("DMA.DBC",x,"Geschäftsbereich")}\
)

2002-01-10
- tim /check wegen CTR->TplIni
- HSTVEN.DLG und CTR.QRY aus STD übernehmen
- MNUBOSS.DBC : Editor|inc-Dateien

2002-01-11
Die folgenden Anweisungen sind alle optional :
- Standard-DLM's aufspielen.
- (optinal) Falls mehrere Datenbanken : tim.ini bearbeiten
  SetDataRoot AppPath()+"\DATA"
- tim.DBI aufräumen : eigentlich sollte dort jetzt nur noch
  LoadDlm "SPRL"
  stehen, und dahinter nur noch die Einträge, die kundenspezifisch sind.
  "AddDllDir AppPath()" ist ersetzt durch das automatische AddDlm("STD")
  nach der TIM.INI
- *.col, *.drv vom Programmverzeichnis nach DLM\STD verschieben.

2002-01-14 DEF_FIN :
- DEV.QRY aus Standarddatenbank aufspielen.

- Falls komplette Buchhaltung: DEV->Delta für die
  Grundwährungen setzen. Zum Beispiel 30 BEF, 0.75 EUR.
  Wenn das Feld leer ist, testet TIM nicht.

2002-01-15
- #exec SetCmdTags("[","]") und FixY2K in der tim.dbi setzen.
  Die waren bisher in der STD.INI.
  Beide Einträge müssen noch *vor* dem LoadDlm "SPRL" kommen.
  Evtl. auch PerDevFixed prüfen.
  Der Standard ist jetzt eine Positivliste


2002-01-15 Inventur :
- JNL->IdGrj des Inventuren-Journals sollte "IVT", nicht "INV" sein.
- (storniert am 20020117) AddOption "IVT" einschalten. Die
  Standardroutinen sind jetzt vielleicht für quasi alle Fälle nutzbar.

2002-01-16 DEF_ANA :
- (storniert am 20020117) Wer analytische Buchhaltung benutzt, der muss
  jetzt in seiner TIM.DBI AddOption "ANA" eintragen.

2002-01-17 : CUST_HANSEN
- Falls AddOption-Einträge in der TIM.DBI waren : wieder rausholen und
  statt dessen die kundenspezifische .exe-Datei aufspielen.
- q *.rep : onNoValue durch OnNoValue ersetzen.

20020118 CUST_MATHAR:
- OnParSatisfy kriegt jetzt keinen Parameter mehr. Eintrag einfach
  löschen. Steht ja jetzt in der SPRL.INI

20020119
- AppShell() + "cmd /c" (wenn Win200) kommt jetzt automatisch

20020121
- SPRL.INI macht Datenbankcheck jetzt via PreLogin statt OnLogin

20020129 DEF_ARC :
- mnu.dbc : PickArchive() ersetzen durch SelectArchive()
- tim.dbi : "OnPickArchive" ersetzen durch "OnSetArchive"

20020212 DEF_ARC:
- TIM macht jetzt nicht mehr automatisch ein AddArchive der aktuellen
  Datenbank.
  Also muss in der tim.dbi noch ein weiterer AddArchive-Eintrag für die
  aktuelle Datenbank eingefügt werden.
  Vorschlag: die archivierenden
  Tabellen (xyz.dbf, xyz.dbt und xyz*.ntx) aus dem
  Haupt-Datenbankverzeichnis in ein Unterverzeichnis LFD verschieben und
  #exec AddArchive("LFD",NIL,"Aktuelle Datenbank",.f.)
  in der tim.dbi (noch VOR den bisherigen AddArchive-EintrÄgen)

20020503 (DEF_JNL)
- tim /check wegen IFC->IdPar

20020515 (DEF_INT)
- HSI.DEF soll jetzt kein addindex mehr machen
- tim /check
- Neue Datei hsiregio.dbc aufspielen
- HSIVEN.QRY anpassen.

20020620
- SetPrnFile() gibt jetzt nicht mehr NIL, sondern .t. zurück

20020923
- .msk-Dateien, in denen Strings mit "=" beginnen, müssen manuell
  konvertiert werden. Sonst kommt "Error BASE/1449  Syntax error: &"
  weil TIM solche Strings jetzt ausführt.

20020925
- Prüfen, ob getenv() benutzt wird. Evtl. auf getvar() umsteigen.
- DLM\STD aktualisieren.
- Evtl. Dateien c:\autoexec.act noch mal nachprüfen : sollten
  nur die beiden DlgDefine() machen und sonst nichts.

20021028
- tim /check wegen CTR->Attrib

20021029
- Wenn LoadDlm("SPRL") gemacht wird, muss jetzt auch LoadDlm("ART")
  gemacht werden. Weil SPRL.INI die ART nicht mehr als CustData
  deklariert.

20021118
- "initialize" in einer .rep-Datei muss jetzt ein Ausdruck, nicht ein zu
  parsender String sein. Wenn ein Report für []-Tags geschrieben war,
  dann funktionierte er nicht in einer Datenbank mit {}-Tags. Und
  umgekehrt. Außerdem ist das jetzt viel logischer.

- (storniert) *.mnu and mnu*.dbc :
  replace FinAuto(cIdJnl,cIdGen,lDcInvert,cTitle,cIdGen1,cIdGen2,cNB)
  with FinAuto(cIdJnl,cIdGenD,cIdGenC,lDcInvert,cTitle,cIdGen1,cIdGen2,cNB)

20021203

- Falls die Benutzerverzeichnisse bisher in einem Verzeichnis "USER\xxx"
  stehen, dann muss dieses Verzeichnis jetzt nach "HOME" umbenannt werden.

- (gx) Nachtrag zum Thema Home-Verzeichnis :
  nicht nur die TIM.BAT, sondern auch die Datei STARTUP.ACT war von
  unserer Entscheidung ("HOME" statt "USER") betroffen. Mit dieser
  Version solltest du jetzt das cd aus der tim.bat ganz raus holen,
  weil TIM sowieso noch mal von sich aus ein cd macht. (Das wird in der
  startup.act getan)

20021215
- Wenn man TIM /EXEC:xyz aufruft, dann ist xyz jetzt nicht mehr der Name
  einer act-Datei, sondern ein Ausdruck.
  Also eventuell bestehende
  tim /exec:rebuild
  ersetzen durch
  tim /exec:ActExec("rebuild")


20021217
- DEF_EVT : TIM /check wegen EVT->IdMsk

20021219
- tim /check wegen NAT->IsoCode

20021230
- tim.dbi : wenn LoadDlm("SPRL"), dann jetzt auch LoadDlm("HST")

20030128 DEF_MSG
- [Sh-F8] auf einem Partner jetzt nicht mehr hard-codiert.
- MSG*.NTX jetzt anders. m³

200302..

- (nicht mehr nötig seit 20030412) Falls Fakturationsdokumente mit
  Artikeln im Einkauf erstellt werden: ddAddField ART->IdCtrE


20030313

- tim /check wegen CTS->Anz

20030412
- tim /check wegen IPB->xlWhen



20040116
- Nicht vergessen, dass die IPB_GENBASE IPB->IdGen geleert werden
  muss, wenn es Artikel gibt, die ART->IdGen benutzen.

20040204

- ParVenAppend() macht jetzt nicht mehr selber Warning(), sondern nur
  noch SetMsg().

20040211

- if LoadDlm MSG :
    tim /check
  to set length of MSG->Titre to 80


20040326 :
- DLM\PRJ\PRJ.DEF macht jetzt auch "parent".

20041021
- VenVnlScan() macht jetzt nicht mehr
   RETURN ddScan(blAction) if indexord() != 1 // z.B. bei ArtVnlEdit


20041203

- PRESTO : In der PAR.DEF muss F8 auf Partner jetzt manuell definiert
  werden. Wird nicht mehr hardkodiert gemacht.

20050209

- JNLATTR_M für FIN-Journale setzen, um bisheriges Verhalten weiter zu
  haben.

20050225

- mirror.btp hat eine neue Kommandozeilensyntax.

20050908
- OnVenClose wird jetzt auch beim ENTregistrieren ausgeführt

20050911
- AfterVenClose ebenfalls.
- Wenn DEF_PRJ: VEN3.NTX neu generieren lassen.

20051015

- DEF_HSI : bei marmor musste ich nach dem Upgrade in der tim.dbi
  deklarieren::
  
    VnlIntdefault ""
    
  Weil das scheinbar vorher nie ausgefüllt wurde und die das bei marmor
  gar nicht mehr benutzen. Sonst kam beim Registrieren "??????????
  unbekannte Zollnummer"

20051202

- VOL.DBC muss jetzt eine weitere Kolonne VOL_NAME (an 3. Stelle) haben.

20051215

- rocatec : vnl.def kann wieder vereinfacht werden. Anschließend testen,
  ob in VNLART.QRY die Summen noch kommen.

20060109

- tim.btp schaut jetzt nach, ob eine backup.bat existiert. Die wird dann
  immer ausgeführt, auch wenn kein Datenbankname angegeben ist. Die
  dbback.btp mit %1 wird nicht mehr von tim.btp aus gestartet.

20060113

- bei AGV : Wenn neue DLM aufgespielt wird, muss in den
  Druckparametersätzen auch HPLJ4 nach HPLJ6 geändert werden. Testen, ob
  Produktionsplanung (LISTEX) richtig rauskommt.

20060126

- VEN.DEF und FIN.DEF : DlgExec("JNLIDDOC") nur wenn ``{||indexord()==1}``

20060511

- OpenMail() : wenn das TIM-Verzeichnis nicht im PATH ist, dann muss man
  jetzt einen expliziten Eintrag OpenMail in der tim.ini machen::
  
    OpenMail f:\anwprog\tim\timtools openmail

20060516

- TimTest() und PrintAct() machen jetzt nicht mehr SetDialog(.f.)

20060531

- MSG.DEF : ddFldHide("Etat") weil dieses Feld jetzt nicht mehr hidden
  ist.

20060714

- VenAppend() kopiert jetzt nicht mehr VEN->Attrib, sondern setzt die
  Standardattribute aus JNL->DocAttr ein. 

20060731

- Wenn in VNL.DEF oder VEN.DEF eine ddOnPostEdit() war, die auch im
  Integritätstest wichtig ist, dann muss die jetzt ddOnTest heißen.


20060810

- Buggefahr in StkReset(). 

20060824

- PreVnaUndo muss jetzt selber SetMsg() aufrufen, falls er nicht
  einverstanden ist.


20060825

- DEF_VNA.
  Zunächst in VNA.DEF ein manuelles Feld "Match" definieren, damit die
  Angaben nicht verloren gehen.
  Konvertierungsroutine für VNL->Match schreiben. VNL->Match enthält
  jetzt immer den primary key der befriedigten VNA. Eine VNA-Serie gibt
  es nicht mehr.
  20060825.ACT

20060828

- timtest() changed API::

   dlm\std\timtest.dlg
   dlm\std\dbcheck.act
   dlm\std\boss.mnu
   dlm\sprl\mnuboss.dbc

- Im CPAS in der tim.dbi ::

    do SetTest("MviTest",{||MviTest("ChkPeriode(MVI->Periode)==0")})
    do SetTest("MviDupTest",{||MviDupTest("ChkPeriode(MVI->Periode)==0")})
    to SetTest("MviCtbTest",{||MviCtbTest("ChkPeriode(MVI->Periode)==0")})
    do SetTest("ImpImlTest",{||ImpImlTest("ChkPeriode(IMP->Periode)==0")})
    do SetTest("ImlTest",{||ImlTest("ChkPeriode(IMP->Periode)==0")})
    do SetTest("CtbBudTest",{||CtbBudTest(\
        "inrange(left(CTB->Periode,2),left(MemPer1,2),left(MemPer2,2))"\
      )})

20060831

- dlm\art\artcts01.rep (Renner/Penner-Liste)
- dlm\sprl\par002.rep (Partnerliste nach Umsatz)


20061013

- N.B.: Damit ``/pc:xxx`` funktionieren kann, 
  muss in den autoexec.act das
  ``setvar("PC"...)`` durch ``DlgDefault("PC"...)`` ersetzt werden.

20061020

- Integritätstest vorher und nachher vergleichen: wegen den neuen
  Rundungsregeln in VenMvtRound().

20070530
--------

- DbfEdit() gibt jetzt .t. zurück. Das .f. war doch einfach unlogisch,
  und ich habe nicht das Gefühl, dass das viel Schaden anrichten wird.

Bei Umstieg Clipper/Xbase:

- dlm aktualisieren

- eupper() durch upper() ersetzen in allen Dateien 
  (vor allem .def, .act, .dlg, .exp)
  

20071003-20071231
-----------------
- Irgendwann in dieser Periode habe ich eine Änderung gemacht, 
  durch die nach dem Upgrade Rundungsdifferenzen beim 
  Integritätstest kommen:
  
  VKP A62250 : Total du document (60.60) en désaccord avec contenu (60.58)
  


20071120
--------
- AfterVenClose in der TIM.DBI : durfte bisher nur einmal vorkommen.
  Jetzt mehrmals. Und jetzt dürfen keine Codeblock-Klammern mehr drum
  sein, sondern es ist ein einfaches Event ohne Parameter.

20071126
--------
- Priorität zwischen IPB_GENBASE (IPB->IdGen) und ArtIdGen()
  (ART->IdGenX) wieder geändert. Evtl. muss UseArtIdGen benutzt werden.
  Siehe auch 20040116.

- NafDelete() : neue Prüfung "Suppression manuelle uniquement pour articles sans stock!"

20080229
--------
- Automatik-Fakturierung testen. VnaCopyfilter gibt es nicht mehr.

20080318
--------
- In .EXP-Dateien sollte die Zeile::

    OnSuccess AppShell("excel.bat "+i_OutputFile(),NIL,.f.)
    
  ersetzt werden durch::
  
    OnSuccess OpenCsv(i_OutputFile())    
    
  Dann ist die excel.bat nicht mehr nötig.
  
20080320
--------

- Einige fundamentale Änderungen im Reportgenerator. Buggefahr.

20090216
--------

- When upgrading DLM you must also upgrade timtools.

20090310
--------

- Integritätstest laufen lassen, weil TIM Bankkontonummern jetzt gründlicher prüft. 
  Evtl. auch BANCLEAN.ACT laufenlassen.
  
- Buggefahr in FinWriteZau() (Generieren von VME- und FBF-Dateien)

20090623
--------

- MFC.DBC muss eine neue Kolonne kriegen MFC_NAME4 (auch wenn nicht DEF_4LANG)


20110204
--------

- Änderung im Reportgenerator: :func:`PrintTotal` und `GRP_BEFORE`
  werden jetzt nicht mehr *nicht* ausgeführt, wenn `nDtlCount` 0 ist.
