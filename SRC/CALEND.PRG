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

#include "LIB.CH"

#ifdef LG_FRENCH
  #define MSG001 "Calendrier"
#else
  #define MSG001 "Kalender"
#endif

static cHighColor := "W/N"
static cNormColor := "N/W"

#define DAY_ROW 1
#define DAY_COL 2
#define DAY_DAY 3
#define DAY_COLOR 4
#define DAY_PRJ   5



FUNCTION PickDate(dDate)
local nCursor := setcursor(SC_NONE)
open window (MSG001) size 12,30
dDate := Calend(WinTop(),WinLeft(),dDate,{|d,k|ExKey(d,k)})
close window
setcursor(nCursor)
RETURN dDate

FUNCTION ExKey(dDate,nKey)
if nKey == K_ENTER
  RETURN .F.
* elseif nKey == 0
*   MsgDisplay("Woche " + ntrim(ft_woy(dDate)))
endif
RETURN .T.


**
** Calend
**
FUNCTION Calend(nRow,nCol,dHeute,bExKey)
local nMonth := month(dHeute)
local nYear := year(dHeute)
local aDays
local i
local nKey
local nDay
local cColor
local a := NIL
if empty(dHeute)
  dHeute := date()
endif
aDays := DispTrame(nRow,nCol,dHeute)
do while .t.
  * eval(bExKey,dHeute,0)
  SayDay(aDays[day(dHeute)],cHighColor)
  nKey := WaitKey() // inkey(0)
  SayDay(aDays[day(dHeute)])
  if nKey == K_RIGHT
    dHeute ++
  elseif nKey == K_LEFT
    dHeute --
  elseif nKey == K_UP
    dHeute -= 7
  elseif nKey == K_DOWN
    dHeute += 7
  elseif nKey == K_CTRL_DOWN
    dHeute := LastOfMonth(dHeute)
  elseif nKey == K_CTRL_UP
    dHeute := FirstOfMonth(dHeute)
  elseif nKey == K_HOME
    do while dow(dHeute) != 1
      dHeute -= 1
    enddo
  elseif nKey == K_END
    do while dow(dHeute) != 7
      dHeute += 1
    enddo
  elseif nKey == K_PGDN
    dHeute := SkipMonth(dHeute,1)
  elseif nKey == K_PGUP
    dHeute := SkipMonth(dHeute,-1)
  elseif nKey == K_CTRL_PGDN
    dHeute := SkipJahr(dHeute,1)
  elseif nKey == K_CTRL_PGUP
    dHeute := SkipJahr(dHeute,-1)
  elseif nKey == K_ESC
    dHeute := NIL
    exit
  else
    if !eval(bExKey,dHeute,nKey)
      exit
    endif
  endif
  if month(dHeute) != nMonth .or. year(dHeute) != nYear
    aDays := DispTrame(nRow,nCol,dHeute)
    nMonth := month(dHeute)
    nYear := year(dHeute)
  endif
enddo
RETURN dHeute

* 浜様様様様様様様様様様様様様様様融
* �            mai 1993            �
* �                                �
* �       So  Mo  Di  Mi  Do  Fr  Sa      �
* �     敖陳堕陳堕陳堕陳堕陳堕陳堕陳�     �
* �  18 �   �   �   �   �   �   �  1�     �
* �  19 �  2�  3�  4�  5�  6�  7�  8�     �
* �  20 �  9� 10� 11� 12� 13� 14� 15�     �
* �  21 � 16� 17� 18� 19� 20� 21� 22�     �
* �  22 � 23� 24� 25� 26� 27� 28� 29�     �
* �  22 � 30� 31�   �   �   �   �   �     �
* �     青陳祖陳祖陳祖陳祖陳祖陳祖陳�     �
* 藩様様様様様様様様様様様様様様様夕


FUNCTION DispTrame(nRow,nCol,dHeute)
local nWoche := 1
local aDays := {}
local dFirst := ntod(year(dHeute),month(dHeute),1)
local nMonth := month(dHeute)
local nTag
#ifdef LG_FRENCH
@ nRow,   nCol SAY "    Di Lu Ma Me Je Ve Sa "
#else
@ nRow,   nCol SAY "    So Mo Di Mi Do Fr Sa "
#endif
@ nRow+01,nCol SAY "   敖賃陳堕賃陳堕賃陳堕朕"
@ nRow+02,nCol SAY "   �  �  �  �  �  �  �  �"
@ nRow+03,nCol SAY "   �  �  �  �  �  �  �  �"
@ nRow+04,nCol SAY "   �  �  �  �  �  �  �  �"
@ nRow+05,nCol SAY "   �  �  �  �  �  �  �  �"
@ nRow+06,nCol SAY "   �  �  �  �  �  �  �  �"
@ nRow+07,nCol SAY "   �  �  �  �  �  �  �  �"
@ nRow+08,nCol SAY "   青珍陳祖珍陳祖珍陳祖潰"
**
@ nRow+09,nCol say padc( Mois(dHeute) + " " + str(year(dHeute),4), 25)
do while month(dFirst) == nMonth
  nTag := dow(dFirst)
  aadd( aDays, { ;
    nRow + 1 + nWoche, nCol + (nTag*3) + 1, day(dFirst) ;
  } )
  SayDay(atail(aDays))
  if nTag == 7
    * @ nRow + 1 + nWoche, nCol say str(ft_woy(dFirst),2)
    @ nRow + 1 + nWoche, nCol say left(ls_woy(dFirst),2)
    nWoche ++
  endif
  dFirst++
enddo
if nTag == 7
  @ nRow + 1 + nWoche, nCol say space(2)
else
  dFirst--
  @ nRow + 1 + nWoche, nCol say str(ft_woy(dFirst),2)
endif
RETURN aDays

**
** SkipJahr()
**
FUNCTION SkipJahr(d,n)
local dReturn := ntod( year(d)+n, month(d), day(d) )
do while empty(dReturn)
  d --
  dReturn := ntod( year(d)+n, month(d), day(d) )
enddo
RETURN dReturn

FUNCTION SayDay(aDay,cColor)
default cColor to cNormColor // aDay[DAY_COLOR]
@ aDay[DAY_ROW], aDay[DAY_COL] say str(aDay[DAY_DAY],2) ;
  color (cColor)
RETURN NIL


**
** Mois()
**
FUNCTION Mois(dDate)
local i := month(dDate)
#ifdef LG_FRENCH
  static a := {  ;
    "janvier",   ;
    "f�vrier",   ;
    "mars",      ;
    "avril",     ;
    "mai",       ;
    "juin",      ;
    "juillet",   ;
    "ao�t",      ;
    "septembre", ;
    "octobre",   ;
    "novembre",  ;
    "d�cembre" }
#else
  static a := {  ;
    "Januar",    ;
    "Februar",   ;
    "M�rz",      ;
    "April",     ;
    "Mai",       ;
    "Juni",      ;
    "Juli",      ;
    "August",    ;
    "September", ;
    "Oktober",   ;
    "November",  ;
    "Dezember" }
#endif
if i == 0 ; RETURN "" ; endif
RETURN a[i]

**
** FirstOfMonth() und LastOfMonth()
**
FUNCTION FirstOfMonth(d)
RETURN ntod( year(d), month(d), 1 )
**
FUNCTION LastOfMonth(d)
d := SkipMonth(d,1)
RETURN ntod( year(d), month(d), 1 ) - 1


FUNCTION FirstOfWeek(dDate)
do while dow(dDate) != 1
  dDate -= 1
enddo
RETURN dDate
