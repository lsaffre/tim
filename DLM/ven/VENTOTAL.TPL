[etc if VEN->IdReg$"I".and."I"$JnlAttrib(VEN->IdJnl)]
IntraStat : ��[=repl("�",10)]���[=repl("�",LenQte())]���[=repl("�",LenQte())]���[=repl("�",LenMont())]Ŀ
            � [=padr("Code",10)] � [=padl("Kg",LenQte())] � [=padl("m�",LenQte())] � [=padl(VEN->IdDev,LenMont())] �
[etc do DbfScan({oHsi(),oInt()},1,\
  VEN->IdJnl+VEN->IdDoc,\
  "HSI->IdJnl+HSI->IdDoc=='"+VEN->IdJnl+VEN->IdDoc+"'",\
  "IntExist(HSI->IdInt)","toStream(\
    '            � '+INT->Code+' � '+HSI->QteStat+' � '+HSI->Qte+' � '\
    +HSI->MontDev+' �'+chr(13)+chr(10)\
  )"\
)]
            ��[=repl("�",10)]���[=repl("�",LenQte())]���[=repl("�",LenQte())]���[=repl("�",LenMont())]��
[etc endif]
[etc if 'T'$PAR->Attrib]

[=tr("",\
  "F�r die Richtigkeit des Betrags von",\
  "Certifi� conforme pour le montant de"]
[ven tvac /format full text] [=VEN->IdDev]:


................
[=UsrName(VEN->Auteur)]
[etc endif]

[etc line]
[etc if 'O'$VEN->Attrib]
[set align r]
[etc if !empty(VEN->Remise)]
[=tr("Gross total","Gesamt brutto","Total brut")] :     [=ntomf(val(VEN->MontR))]
[=tr("Discount","Rabatt","Remise")] [=ltrim(VEN->Remise)] % :     [=ntomf(\
  val(VEN->Mont)-val(VEN->MontT)-val(VEN->MontR)\
)]
[etc endif]
[=tr("Total : ","Gesamtbetrag :","Total : ")] [=VEN->IdDev] [ven htva]
[ven memo_tax]
[etc if VenMtva(VEN->IdDev)!=0]
��������������
[=tr("Total incl. tax :","Gesamt inkl. MWSt. :","Total T.V.A. comprise")] [=VEN->IdDev] [ven tvac]
[etc endif]
[etc if .f..and.VEN->IdDev!="EUR"]
([=MsgMontant(TplLang())] EUR : [=ltrim(ntomf(Dev2Db(VEN->IdDev,VEN->Periode,val(VEN->Mont)),2))])
[etc endif]
[etc if .f..and.VEN->IdDev=="EUR".and.PAR->Pays=="D  "]
([=MsgMontant(TplLang())] DEM : [=ltrim(ntomf(Db2Dev("DEM",VEN->Periode,val(VEN->Mont)),2))])
[etc endif]
[etc if .f..and.VEN->IdDev=="EUR".and.PAR->Pays=="B  "]
([=MsgMontant(TplLang())] BEF : [=ltrim(ntomf(Db2Dev("BEF",VEN->Periode,val(VEN->Mont)),0))])
[etc endif]
[etc endif]

