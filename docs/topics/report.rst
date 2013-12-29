Der Reportgenerator
===================


Report properties
-----------------

.. c:macro:: RPT_AREA     
.. c:macro:: RPT_ORDER    
.. c:macro:: RPT_START    
.. c:macro:: RPT_WHILE    
.. c:macro:: RPT_FILTER   
.. c:macro:: RPT_GROUPS   
.. c:macro:: RPT_COLUMNS  
.. c:macro:: RPT_TOTALS   
.. c:macro:: RPT_INDEX    
.. c:macro:: RPT_ONEACH   
.. c:macro:: RPT_HDR1     
.. c:macro:: RPT_HDR2     
.. c:macro:: RPT_HDR3     
.. c:macro:: RPT_DETAIL   
.. c:macro:: RPT_VALRECORD    
.. c:macro:: RPT_TEXTWIDTH    
.. c:macro:: RPT_TEXTCOLUMNS  
.. c:macro:: RPT_NOVALUE      
.. c:macro:: RPT_BEFORE       
.. c:macro:: RPT_AFTER        

.. c:macro:: RPT_COLSEP       
   column separator
   
.. c:macro:: RPT_ROWSEP      
   row separator
   
.. c:macro:: RPT_PRETTL      
.. c:macro:: RPT_POSTTTL     
.. c:macro:: RPT_PRINTLINE   
.. c:macro:: RPT_HEADER      
.. c:macro:: RPT_TOCSV       
.. c:macro:: RPT_RECNOS      
.. c:macro:: RPT_FORLOOP     
.. c:macro:: RPT_LINES       
.. c:macro:: RPT_TOHTML      

Report Groups
-------------

.. c:macro:: GRP_KEY      

.. c:macro:: GRP_STOP    

.. c:macro:: GRP_COUNT   
   Anzahl der verarbeiteten Records
.. c:macro:: GRP_KEYVALUE 

.. c:macro:: GRP_TEXT     

.. c:macro:: GRP_VALUES  

.. c:macro:: GRP_WHEN       

   ob mich irgendwelche Total dieser Gruppe möglicherweise
   interessieren. Wenn GRP_WHEN nein sagt, werden die Totale erst gar
   nicht nach ihrer Meinung gefragt.

.. c:macro:: GRP_ALIGN     

.. c:macro:: GRP_HEADER    

   Wird ausgeführt, bevor der erste Record *verarbeitet* wird
   (unabhängig davon, ob dieser Record gedruckt wird oder nicht).
 
.. c:macro:: GRP_BEFORE   

   Wird ausgeführt, bevor der erste Record *gedruckt* wird.
   Oder, wenn kein einziger Record gedruckt wird, vor dem ersten Total,
   das gedruckt wird.

.. c:macro:: GRP_DTLCOUNT 

   Anzahl der effektiv ausgedruckten Records

.. c:macro:: GRP_AFTER    

   Wird ausgeführt, bevor das erste TOTAL der Gruppe gedruckt wird.
   Kriegt 2 Parameter mit : GRP_COUNT und GRP_DTLCOUNT
   Muss .t. oder .f. zurück geben.
   Wenn .f., dann werden die TOTALs nicht gedruckt.

.. c:macro:: GRP_DONE     

   array of booleans indicating whether the total has been printed

.. c:macro:: GRP_TTLCOUNT 

   array of record counts per total
   
.. c:macro:: GRP_FORMAT
.. c:macro:: FORMAT_BOLD

.. c:macro:: GRP_AFTERTTL 

   20050621 : 
   mit ``afterTotals {||PrintLine()}`` kann man angeben, dass nach
   den Totals der Gruppe eine Leerzeile kommt.

.. c:macro:: GRP_STARTED   


Report Columns
--------------

.. c:macro:: CLN_HEADER
.. c:macro:: CLN_WIDTH 

.. c:macro:: CLN_WHEN  
   xl die Bedingung
 
.. c:macro:: CLN_VALUE  

   xn (ggf. der Wert, der summiert wird)
  
.. c:macro:: CLN_TEXT   

   xc (der Text, der gedruckt wird)
   
.. c:macro:: CLN_XSUM
  
.. c:macro:: CLN_TYPE 

.. c:macro:: CLN_DECPOS 

   used when TYPE is N

.. c:macro:: TTL_WHEN   

   Ob das Total ausgedruckt wird
   
.. c:macro:: TTL_TEXT   

   Die "Überschrift" des Totals
   
.. c:macro:: TTL_FOR    

   Welche Records in diesem Total summiert werden
   
.. c:macro:: TTL_AFTER  

   Wird nach Ausdruck des Totals ausgeführt
   



Funktionen
----------

.. function:: RepPrint(cIdRep,cIdDlg,cTitle,cTplIni,cPreview,lToCsv)

   Druckt einen Report.
  
  
.. function:: _rupture(lFinal) 
   
   Called when a group key has changed.
   Prints GRP_HEADER and executes GRP_BEFORE if needed.
   Prints the cached RPT_LINES.
   
