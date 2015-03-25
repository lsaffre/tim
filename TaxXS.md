# Einkauf Dienstleistungen von einer Firma außerhalb der EU #

Bei Einkauf Dienstleistungen von einer Firma außerhalb der EU kommt der Basisbetrag
nach 87 und die (theoretisch berechnete) MWSt nach 56 (geschuldete) und 59
(abziehbare).

Wer diesen Fall hat, muss einen MWSt-Code "XS" einrichten.
Es kann auch einen NXS geben, der dann nach 87 und 56 kommt, aber nicht nach 59.

Hier ein Beispiel für die Konfiguration der MWSt-Codes:

```
 Id  Bezeichnung                         Regimes %-Satz Attr G-Kto  Intra
┬───┬───────────────────────────────────┬───────┬──────┬────┬──────┬──────
│IS │Dienstleistungen Intracom 21%      │I      │    21│    │411011│451700
│NIS│Dienstl. Intracom 21% n. abz.      │S      │    21│    │      │451700
│X  │Import von außerhalb EU            │X      │      │    │      │
│XS │Dienstl. außerhalb EU 21%          │X      │    21│    │411011│451700
│XS6│Dienstl. außerhalb EU 21%          │X      │     6│    │411011│451700
│NXS│Dienstl. außerhalb EU 21% n.a.     │X      │    21│T   │      │451700
```

Zum Beispiel eine PKW-Reparatur, die zu 50% absetzbar ist:

```
Konto  Bezeichnung                      M   Netto      MWSt       Brutto
──────┬────────────────────────────────┬───┬──────────┬──────────┬──────────┬
612610│Reparturen LKW                  │XS │    500.00│    105.00│          │
612610│Reparturen LKW                  │NXS│    500.00│    105.00│          │
      │                                │   │          │          │          │
```

Diese Rechnung schreibt 1000 € ins Fach 87, 210 € ins Fach 56, 105 € ins Fach 59
und 1105 € ins Fach 82.

Falls es sich bei den DL um "services fournis par des organismes à caractère social"
handelt, ist die theoretische MWSt 6 statt 21%. In so einem Fall kann man XS entweder auf tolerant setzen und den Betrag bei jeder Rechnung manuell korrigieren, oder einen Code XS6 anlegen.


## Siehe auch ##
  * [MWSt-Codes](TAX.md)
  * [Änderungen MWSt. 2010](Vat2010.md)