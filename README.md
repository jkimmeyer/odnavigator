# odnavigator
Kommunaler Open Data Navigator für Deutschland der Metriken und Visualisierungen zur einfacheren Navigation bietet. Der Prototyp kann zur Zeit unter https://calm-tor-81670.herokuapp.com/ getestet werden. Falls Interesse an der Bachelorarbeit oder einer Zusammenarbeit besteht, melden Sie sich bitte per E-Mail.

API-Docs: ```localhost:3000/api/documentation``` oder [API Docs](https://github.com/jkimmeyer/odnavigator/blob/master/api.pdf)

Reindex Datasets and calculate metrics:

```shell
$ rails c
$ FetchDatasetsService.call()
```

## Nächste Schritte
[Nächste Schritte](https://github.com/jkimmeyer/odnavigator/issues)

## Projekt Setup
[Installation and Setup](https://github.com/jkimmeyer/odnavigator/blob/master/doc/install.md)

## Projekt Idee
Der ODNavigator ist 2018 im Rahmen meiner Bachelorarbeit entstanden. Durch den Open Data Navigator soll es auch den "normalen" Bürgern einer Stadt ermöglicht werden, die kommunalen Open Data Landschaft zu verstehen und untersuchen zu können.

Die entwickelten Metriken dienen außerdem dazu, dass Datenbereitsteller erkennen können, was sie konkret an ihrer aktuellen Datenbereitstellung verbessern können. In Zukunft soll die Möglichkeit geboten werden, dass neben den Datenportalen auch innerhalb der Datensätze detailreicher navigiert werden kann. 

Der nächste Schritt wird sein, diese Anwendung zur Marktreife zu bringen. Um dieses Vorhaben durchzuführen, ist es sinnvoll, sich zunächst an den erstellten Issues zu orientieren und diese zu lösen.

## Erläuterung zur Code-Struktur
[Code-Struktur](https://github.com/jkimmeyer/odnavigator/blob/master/doc/code_struktur.md)

## Alternativen
- [opendatainception.io](https://opendatainception.io)
- [data.opendatasoft.com](https://data.opendatasoft.com/pages/home/)
- [opendatamonitor.eu](https://www.opendatamonitor.eu)
- [offenedaten.de](https://www.offenedaten.de)

## Regeln für Beteiligung
- Öffnen eines Pull-Requests in einem Feature-Branch
- Art der Änderung deutlich beschreiben
- Auf Review warten
- Nachbesserungen durchführen
- Zunächst nur Änderungen an Code-Teilen

## Continuous Integration
tbd. 
![Build Status](https://travis-ci.com/jkimmeyer/odnavigator.svg?token=RNrpHhqDGiujTBgM6w2s&branch=master)
