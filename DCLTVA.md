# MWSt-Erklärung #

Menü: [Programm | Druckmenü | MWSt | MWSt-Erklärung ](Menus.md)

Siehe auch: [Vat2010](Vat2010.md)


```
    ╔═════════════════ MWSt-Erklärung ════════════════╗
    ║ Periode von-bis↕0901-0903                       ║
    ║ MWSt-Nummer BE-0446.513.123                     ║
    ║ MWSt-Nummer Buchhalter BE-0446.513.123          ║
    ║ Diverse Regularisierungen [61]           0      ║
    ║                           [62]           0      ║
    ║ Generalkonto MWSt Bankkosten   ↕                ║
    ║ Anzahlung                 [91]           0      ║
    ║ Druckparametersatz↕DCLTVA                       ║
    ║   als RTF-Datei                                 ║
    ║ X Seitenvorschau                                ║
    ║   PDF-Datei generieren statt zu drucken         ║
    ║   Dateiname                                     ║
    ╚═════════════════════════════════════════════════╝
```

## Übersicht ##

TIM druckt die MWSt-Erklärung lediglich auf Papier aus.
Er könnte auch eine XML-Datei für InterVAT machen, aber das hat bisher noch niemand angefragt, weil alle Benutzer diese paar Zahlen stattdessen einfach in InterVAT manuell eintippen.

## Konfigurationsdateien ##

[DCLTVA.ACT](http://code.google.com/p/tim/source/browse/DLM/SPRL/DCLTVA.ACT)
> Berechnet die Werte der Felder der MWSt-Erklärung.

[DCLTVA.DLG](http://code.google.com/p/tim/source/browse/DLM/SPRL/DCLTVA.DLG)
> Dialogfenster

[DCLTVA.LST](http://code.google.com/p/tim/source/browse/DLM/SPRL/DCLTVA.LST)
> Vorlage für Text-Version der MWSt-Erklärung.