# [TIM und der Advantage Database Server](TimUndAds.md) #

Support für den ADS wird aktiviert, indem (1) in der XYZ.CH `#define DEF_ADS` steht und (2) im Verzeichnis s:\obj\xyz eine leere Datei `xbase.ind` existiert. Letzteres führt in der `build.bat` vor allem dazu, dass die TIM4.EXE nicht mit `rmake` sondern mit `pbuild` gemacht wird. Außerdem muss zur Laufzeit (3) in der `TIM.INI` `UseAdsDbe on` stehen.

Wenn in der `TIM.INI` das `UseAdsDbe` auf `off` steht, dann wird die ADSDBE gar nicht mit `DbeLoad()` geladen und das Verhalten ist genau so als ob `DEF_ADS` beim Kompilieren nicht eingeschaltet wäre (außer dass ein TIM ohne DEF\_ADS den Eintrag `UseAdsDbe` ignoriert).

Wenn `UseAdsDbe` auf `on` steht, wird der Eintrag `UseDbe` der TIM.INI ignoriert.

Um zu sehen wo man dran ist, kann man in der `NEWS.TXT` folgenden Befehl einfügen:
```
{=AdsDiag()}
```

Das führt im Hauptmenü zu einem Text im Stil:

```
Active DacSession: DBE=ADSDBE;SERVER=L:   
isUsed() : .t.                            
isCompound() : .f.                        
isDefault() : .t.                         
Server Type : LOCAL, Version : "7.0.0.1     "  
ANSI_LANG : "ENGL(AMER)", OEM_LANG : "USA     "
```


Seit 20100609 gibt es einen Eintrag `AdsConnect` in der `TIM.INI`, dessen Standardwert äquivalent zum bisherigen Verhalten ist:

```
AdsConnect "DBE=ADSDBE;SERVER="+left(AppName(.t.),2)
```

Bis 20100609 musste die Datenbank obligatorisch auf dem gleichen Laufwerk wie die TIM4.EXE stehen.

Jetzt kann man außerdem mit den DacSession connection parameters experimentieren, zum Beispiel:

```
AdsConnect "DBE=ADSDBE;SERVER=\\alaska01\data;ADS_LOCAL_SERVER;UID=demo;PWD=demo"
```

Siehe Dokumentation zur ADS Database Engine für mehr Beispiele.