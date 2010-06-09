** Copyright (c) 1992-2001 PAC Systems
** Copyright (c) 2001-2008 Luc Saffre
**
** This file is part of TIM.
**
** TIM is free software: you can redistribute it and/or modify it
** under the terms of the GNU General Public License as published by
** the Free Software Foundation; either version 3 of the License, or
** (at your option) any later version.
**
** TIM is distributed in the hope that it will be useful, but WITHOUT
** ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
** or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
** License for more details.
**
** You should have received a copy of the GNU General Public License
** along with TIM. If not, see <http://www.gnu.org/licenses/>.


** Based on DBESYS.PRG ditributed with Alaska Xbase++ compiler

#ifdef __XPP__

#define MSG_DBE_NOT_LOADED   " database engine not loaded"
#define MSG_DBE_NOT_CREATED  " database engine could not be created"

#include "TIM.CH"
#include "DMLB.CH"
#include "DBFDBE.CH"
#include "FOXDBE.CH"

#ifdef DEF_ADS

// Alaska Data Access Chain library is required.
#pragma library("ADAC20B.LIB")

STATIC soSession := NIL

#endif DEF_ADS


*******************************************************************************
* DbeSys() is always executed at program startup
*******************************************************************************
PROCEDURE dbeSys()
/* 
 *   The lHidden parameter is set to .T. for all database engines 
 *   which will be combined to a new abstract database engine.
 */
#ifdef DEF_ADS
// LOCAL cServerDrive := left(AppName(.t.),2)
local cAdsConnect := AdsConnect()
#endif DEF_ADS
* LOCAL aDbes := { { "DBFDBE", .T.},;
*                  { "NTXDBE", .T.},;
*                  { "FOXDBE", .T.},;
*                  { "CDXDBE", .T.},;
*                  { "DELDBE", .F.},;
*                  { "SDFDBE", .F.} }
* LOCAL aBuild :={ ;
*   { "DBFNTX", 1, 2 },;
*   { "FOXCDX", 3, 4 };
* }
* LOCAL i

  /*
   *   Set the sorting order and the date format
   */
  SetCollation(DbeCollation())
  * SET COLLATION TO GERMAN
  * SET COLLATION TO AMERICAN
  * SET DATE TO AMERICAN

  #ifdef DEF_ADS
    if UseAdsDbe()
      IF ! DbeLoad( "ADSDBE", .f.)
        raise( "Database Engine ADSDBE not loaded")
      ENDIF
*      aDbes := {{ "ADSDBE", .F.}}
*      aBuild := {}
    endif
  #endif DEF_ADS

  #ifdef DEF_FOX

    IF ! DbeLoad( "FOXDBE", .T.)
      raise( "Database Engine FOXDBE not loaded")
    ENDIF

    IF ! DbeLoad( "CDXDBE" , .T.)
      raise( "Database Engine CDXDBE not loaded" )
    ENDIF

    IF ! DbeBuild( "FOXCDX", "FOXDBE", "CDXDBE" )
      raise( "Database Engine DBFCDX not created" )
    ENDIF

    * DbeSetDefault("FOXDBE")
    DbeInfo( COMPONENT_DATA, DBE_EXTENSION, "FOX" )
                 
  #endif

  #ifdef DEF_DBF

    IF ! DbeLoad( "DBFDBE", .T.)
      raise( "Database Engine NTXDBE not loaded")
    ENDIF

    IF ! DbeLoad( "NTXDBE" , .T.)
      raise( "Database Engine NTXDBE not loaded")
    ENDIF

    IF ! DbeBuild( "DBFNTX", "DBFDBE", "NTXDBE" )
      raise( "Database Engine DBFNTX not created")
    ENDIF

  #endif DEF_DBF

  /* 
   *   load all database engines 
   */
*  FOR i:= 1 TO len(aDbes)
*      IF ! DbeLoad( aDbes[i][1], aDbes[i][2])
*         Alert( aDbes[i][1] + MSG_DBE_NOT_LOADED , {"OK"} )
*      ENDIF
*  NEXT i

  DbeSetDefault(UseDbe()) // "DBFNTX")

  #ifdef DEF_ADS
    if UseAdsDbe()
    
      DbeSetDefault("ADSDBE")

      // connect to the ADS server
      soSession := dacSession():New( cAdsConnect )
      // soSession := dacSession():New( "DBE=ADSDBE;SERVER="+cServerDrive )

      // check if we are connected to the ADS server
      IF ( !soSession:isConnected( ) )
        //~ raise("Error connecting to ADS on "+cServerDrive+" : "+utos(soSession:getLastError()))
        raise("Error connecting to ADS using "+cAdsConnect+" : "+utos(soSession:getLastError()))
      ENDIF
      // SetCollation(DbeCollation())
      // Warning(ntrim(DbeCollation()))
    endif
  #endif DEF_ADS


  /* 
   *   create database engines 
   */
*  FOR i:= 1 TO len(aBuild)
*      IF ! DbeBuild( aBuild[i][1], aDbes[aBuild[i][2]][1], aDbes[aBuild[i][3]][1])
*         Alert( aBuild[i][1] + MSG_DBE_NOT_CREATED , {"OK"} )
*      ENDIF
*  NEXT i

RETURN

FUNCTION dbf_ext()
RETURN "."+DbeInfo( COMPONENT_DATA, DBE_EXTENSION )

FUNCTION dbt_ext()
RETURN "."+DbeInfo( COMPONENT_DATA, DBE_USER+1)

/*** hier ist es egal, welche DBE benutzt wird: alle drei unterstÅtzten
DBEs haben ihre XXX_MEMOFILE_EXT definiert als (DBE_USER+1)

DBFDBE_MEMOFILE_EXT
FOXDBE_MEMOFILE_EXT
ADSDBE_MEMOFILE_EXT
***/

FUNCTION ntx_ext()
RETURN "."+DbeInfo( COMPONENT_ORDER, DBE_EXTENSION )


#ifdef DEF_ADS

// #defines taken from ADSDBE.CH and DAC.CH

#define DAC_USER              0x0000FFFF
#define ADSDBE_SERVER_TYPE    (DAC_USER+1)  // RO
#define ADSDBE_SERVER_VERSION (DAC_USER+2)  // RO
#define ADSDBE_OEM_LANG       (DAC_USER+3)  // RO
#define ADSDBE_ANSI_LANG      (DAC_USER+4)  // RO

FUNCTION ADS_ServerType()
local x := soSession:setProperty(ADSDBE_SERVER_TYPE)
RETURN "NETWARE"  if x == 1
RETURN "NT"       if x == 2
RETURN "LOCAL"    if x == 3
RETURN "WIN9X"    if x == 4
RETURN "NETWARE5" if x == 5
RETURN "LINUX"    if x == 6
RETURN "Unknown (" + utos(x) + ")"
               

FUNCTION AdsDiag()
local s := ''
if soSession == NIL
  s += "soSession is NIL"
elseif ! soSession:isConnected()
  s += ("Connection to server failed!") + CR_LF
  s += ("Error code :" + utos(soSession:getLastError())) + CR_LF
  s += ("Description:" + utos(soSession:getLastMessage())) 
else
  s += ("Active DacSession: "+soSession:getConnectionString()) + CR_LF
  s += ("isUsed() : " + utos(soSession:isUsed())) + CR_LF
  s += ("isCompound() : " + utos(soSession:isCompound())) + CR_LF
  s += ("isDefault() : " + utos(soSession:isDefault())) + CR_LF
  s += "Server Type : "+ADS_ServerType() 
  s += ", Version : "+utos(soSession:setProperty(ADSDBE_SERVER_VERSION)) + CR_LF
  s += "ANSI_LANG : "+utos(soSession:setProperty(ADSDBE_ANSI_LANG)) 
  s += ", OEM_LANG : "+utos(soSession:setProperty(ADSDBE_OEM_LANG))
endif
RETURN s

FUNCTION AdsDisconnect
if soSession != NIL
  soSession:disconnect()
  soSession := NIL
endif
RETURN .t.


* dummy functions for backward compatibility

* AX_CacheRecords(n)
* Get/Set the number of records to read-ahead and cached on the client
* AX_CacheRecords( [<nNumRecords>] ) -> numeric
* <nNumRecords>  The number of records to be read-ahead and cached on
* the client after a skip operation
FUNCTION AX_CacheRecords(n)
RETURN -1 // return the previous setting

FUNCTION ax_error
RETURN 0 if soSession == NIL
RETURN soSession:getLastError()

#endif DEF_ADS

#else

FUNCTION ntx_ext() ; RETURN ".NTX"
FUNCTION dbf_ext() ; RETURN ".DBF"
FUNCTION dbt_ext() ; RETURN ".DBT"

#endif __XPP__


//
// EOF
