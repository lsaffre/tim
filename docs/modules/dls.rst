:staticmod:`DEF_DLS` -- Dienstleistungen
========================================

.. staticmod:: DEF_DLS

Definiert die Tabellen :class:`DLS` und :class:`DLA`.

DLS (Dienstleistungen)
----------------------

.. class:: DLS


  .. attribute:: IdDls
  
    Primary key.
  
  .. attribute:: IdPar
  
    Pointer to the :class:`PAR <Partner>`. 
    
  .. attribute:: Date
  
    Date. 
 
 
 .. function:: DlsWait(wwin)
 
    Called by ddedit in fullscreen mode on a DLS record to display 
    a table of related data (depending on wwin).