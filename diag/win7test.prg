#include "Directry.ch"
#include "common.ch"

#IFDEF __XPP__
   #include "DLL.ch"

   #include "Dbfdbe.ch"
   #include "Ntxdbe.ch"
   #include "Foxdbe.ch"
   #include "Cdxdbe.ch"
   #define MSG_DBFDBE_NOT_LOADED   "Database-Engine DBFDBE nicht geladen"
   #define MSG_NTXDBE_NOT_LOADED   "Database-Engine NTXDBE nicht geladen"
   #define MSG_DBFNTX_NOT_CREATED  "DBFNTX Database-Engine;konnte nicht erzeugt werden"

PROCEDURE dbeSys()
   SET COLLATION TO GERMAN
   IF !DbeLoad("DBFDBE",.T.)
      ALERT(MSG_DBFDBE_NOT_LOADED,{"OK"})
   ENDIF
   IF !DbeLoad("NTXDBE",.T.)
      ALERT(MSG_DBFDBE_NOT_LOADED,{"OK"})
   ENDIF
   IF !DbeBuild("DBFNTX","DBFDBE","NTXDBE")
      ALERT(MSG_DBFNTX_NOT_CREATED,{"OK"})
   ENDIF

   IF !DbeLoad("CDXDBE",.T.)
      ALERT("Database-Engine CDXDBE nicht geladen",{"OK"})
   ENDIF
   IF !DbeLoad("FOXDBE",.T.)
      ALERT("Database-Engine FOXDBE nicht geladen",{"OK"})
   ENDIF
   IF !DbeBuild("FOXCDX","FOXDBE","CDXDBE")
      ALERT("FOXCDX Database-Engine;konnte nicht erzeugt werden",{"OK"})
   ENDIF

   DbeInfo(COMPONENT_ORDER, CDXDBE_MODE,CDXDBE_FOXPRO2X )
   DbeInfo(COMPONENT_ORDER,DBE_LOCKMODE,LOCKING_EXTENDED)
   DbeSetDefault( "FOXCDX" )

   RETURN

#ENDIF

PROCEDURE Main(cMax)
LOCAL cHost := "."
*LOCAL cHost := "\\A-pc\_e\0"
*LOCAL cHost  := "\\A-hp\ALASKA\0"
LOCAL cFile  := "TESTOPS.DBF"
LOCAL cNode  := NETNAME()
LOCAL i
LOCAL nStart
LOCAL nStop
LOCAL nRec
LOCAL nper   := 0
LOCAL nMax   := 1000
LOCAL nLast  := 0
LOCAL nError := 0
LOCAL nCount := 0

LOCAL Use_NTX := .f.

DEFAULT cMax TO 1000

   IF PCOUNT() > 0
      IF VAL(cMax) > 0
         nMax  := VAL(cMax)
      ENDIF
   ENDIF

   SET DECIMALS TO 4

   IF .NOT. FILE(cHost+"\"+cFile)
      #IFDEF __XPP__
         MSGBOX("File not found")
      #ELSE
         Alert("File not found")
      #ENDIF
      QUIT
   ENDIF

   #IFDEF __XPP__
      IF FILE(cHost+"\"+STRTRAN(cFile,".DBF",".CDX"))
         Use_NTX := .F.
      ENDIF
   #ELSE
      //
      // Cl*pper v5.2e
      //
      Use_NTX := .T.
   #ENDIF

   CLS
   ? "SMB2 Demo, "+LTRIM(STR(nMax,10,0))+" to add records, please wait ..."
   //
   // Testtime USE
   //
   nStart := SECONDS()
   #IFDEF __XPP__
      IF Use_NTX
         USE (cHost+"\"+cFile) SHARE VIA "DBFNTX"
      ELSE
         USE (cHost+"\"+cFile) SHARE VIA "FOXCDX"
      ENDIF
   #ELSE
      USE (cHost+"\"+cFile) SHARE
   #ENDIF

   IF NetErr()
      #IFDEF __XPP__
         Msgbox("USE SHARE Error")
      #ELSE
         Alert("USE SHARE Error")
      #ENDIF
      QUIT
   ELSE
      nStop  := SECONDS()-nStart
      ? ""
      ? "USE DBF      "+LTRIM(STR(nStop,10,4))+" Sec."
      #IFDEF __XPP__
         IF Use_NTX
            SET INDEX TO (cHost+"\"+"TESTOPS1.NTX"),;
                         (cHost+"\"+"TESTOPS2.NTX"),;
                         (cHost+"\"+"TESTOPS3.NTX"),;
                         (cHost+"\"+"TESTOPS4.NTX")
         ELSE
            SET INDEX TO (cHost+"\"+"TESTOPS.CDX")
         ENDIF
      #ELSE
         SET INDEX TO (cHost+"\"+"TESTOPS1.NTX"),;
                      (cHost+"\"+"TESTOPS2.NTX"),;
                      (cHost+"\"+"TESTOPS3.NTX"),;
                      (cHost+"\"+"TESTOPS4.NTX")
      #ENDIF
   ENDIF

   ? "USE Sec."+LTRIM(STR(nStop))
   ? ""
   IF nStop > 1
      ? "if longer than 1sec. use http://support.microsoft.com/kb/150384"
   ENDIF

   nLast := TESTOPS->( LASTREC() )
   //
   // Test APPEND BLANK
   //
   ? "starte DBF APPEND BLANK, please wait ..."
   nStart := SECONDS()
   FOR i := 1 TO nMax
*     APPEND BLANK
      TESTOPS->( DbAppend() )
      IF NetErr()
         TONE(1234)
         nError++
      ELSE
         nRec := TESTOPS->(RECNO())
         IF TESTOPS->(DbRLock(nRec))
            REPLACE TESTOPS->TESTSTRING   WITH STRZERO(i) // Replicate("A",10)
            REPLACE TESTOPS->TESTNUM      WITH RECNO()
            REPLACE TESTOPS->TESTDATE     WITH DATE()
            REPLACE TESTOPS->TESTTIME     WITH TIME()
            REPLACE TESTOPS->TESTNODE     WITH cNode

            TESTOPS->(DbRUnlock(nRec))
            //
            // need for Win7 SP1 RC
            //
            TESTOPS->(DbSkip(0))
         ELSE
            #IFDEF __XPP__
               Msgbox("DbRLock("+LTRIM(STR(nRec))+") Error")
            #ELSE
               Alert("DbRLock("+LTRIM(STR(nRec))+") Error")
            #ENDIF
         ENDIF
         IF (i % (nMax/100)) == 0
            nStop := SECONDS()-nStart
            nper  := nStop/i
            @ 7,0 Say "Prozent "+LTRIM(STR(i/(nMax/100),10,0 ))+"% per Record "+LTRIM(STR(nper))+" Sec."
         ENDIF
      ENDIF
   NEXT
   nStop  := SECONDS()-nStart

   ? "APPEND BLANK Sec."+LTRIM(STR( nStop ))
   ? ""
   nper  := nStop/nMax
   ? "per Record "+ LTRIM(STR(nper))+" Sec."

   IF nper > 0.04
      IF nper > 0.5
         ? "you have a BIG Performance Problem"
      ELSE
         ? "if Time are to long use http://support.microsoft.com/kb/825433"
      ENDIF
   ENDIF
   ? ""
   ? nRec := LASTREC(), RECCOUNT()

   #IFDEF __XPP__
      IF Use_NTX
         SET ORDER TO 2
      ELSE
         ORDSETFOCUS("MYNUM")
      ENDIF
   #ELSE
      SET ORDER TO 2
   #ENDIF
   ? ""
   ? "Index Order  "+OrdSetFocus()
   ? "SEEK for     "+LTRIM(STR(INT(nMax+nLast)))
   SEEK(nMax+nLast)
   IF FOUND()
      ? "FOUND "+LTRIM(STR(nRec))
   ELSE
      ? "hm ...       "
   ENDIF

   #IFDEF __XPP__
      IF Use_NTX
         SET ORDER TO 1
      ELSE
         ORDSETFOCUS("MYSTRING")
      ENDIF
   #ELSE
      SET ORDER TO 1
   #ENDIF
   ? ""
   ? "Index Order  "+OrdSetFocus()
   ? "SEEK for     "+LTRIM(STR(INT(nMax/2)))
   SEEK(STRZERO(nMax/2))
   IF FOUND()
      ? "found        "+LTRIM(STR(RECNO()))
   ELSE
      ? "hm ...       "
   ENDIF

   TESTOPS->(DbGoTop())
   ? "COUNT TO nCount"
   nStart := SECONDS()
   COUNT TO nCount FOR TESTOPS->TESTNODE = cNode
   nStop  := SECONDS()-nStart
   ? LTRIM(STR(nCount))+" Records "+LTRIM(STR(nStop,10,4))+" Sec. "+LTRIM(STR(nStop/nCount,10,4))+" per/Rec"

   CLOSE DATABASE

   IF nError > 0
      WAIT "seems NOT all Records in DBF, only "+LTRIM(STR(nRec))+" ? press any key ..."
   ELSE
      WAIT "is it "+LTRIM(STR(nRec))+"? press any key ..."
   ENDIF

   CLS

RETURN

#IFDEF __XPP__

FUNCTION NETNAME()
LOCAL nDll, cName := SPACE( 255 ), nSize := 255, cReturn := ''
   nDll := DllLoad( "kernel32.dll" )
   IF nDll <> 0
      IF !EMPTY( DllCall( nDll, DLL_STDCALL, "GetComputerNameA", @cName, @nSize ) )
         cReturn := LEFT( cName, nSize )
      ENDIF
      DllUnload( nDll )
   ENDIF
RETURN ( cReturn )

#ELSE
   // Clipper v5.2e does have NetName()
#ENDIF