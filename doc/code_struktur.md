# Kurzfassung der wichtigsten Bestandteile:

## Frontend

### Javascript

``app/assets/javascripts``

- API-Requests: Asynchrone Anfragen an das Backend, um die Daten der Metriken zu verarbeiten.
- Feature-Actions: Auf einem GeoJSON-Objekt ausgeführte Funktionen (z.B. Klick, Hover, etc.)
- Helpers: Hilfsfunktion zur Ermittlung von Farbwerten etc.
- Maps: Initialisierung der Karte und initiale Funktionen
- Markers: Funktion zur Generierung der Marker
- Navigation: Elemente zur Unterstützung im User-Interface (Suche funktioniert nicht)

### Stylesheets

``app/assets/stylesheets``

- Generische Komponenten: Styling wiederverwendbarer Komponenten.
- Globals: Global gültige Stylings u.a. genutzte Vorlage, um die Standard-Styles zu ersetzen.
- Spezifische Komponenten: Komponenten, die nur einmalig verwendet werden.
- Utilities: Werkzeuge zur Unterstützung im Styling - Grid für Positionierung, auch hier Vorlage verwendet.

###  Views

``app/views/maps``

- index.html: HTML Datei, mit welcher das User Interface bereitgestellt wird.


## Backend

### Controller

``app/controllers``

- API: API-Spezifische Controller, die die API rendern und auch die einzelnen Abfragen beantworten.
- DataPortals: Standard Controller für CRUD-Aktionen
- MapsController: Controller für das initiale Rendern der Karte.

### Models

``app/models``

- CityPortal: Abfragen der IDs aller Datensätze und Berechnung der Metriken.
- DataPortal: Ansprechpartner für die API-Anfragen, auf diesem Model sind die Metriken und die Details zu einem Datenportal gespeichert.
- DataResource: Funktionen zur Feststellung der Eigenschaften der Datenresource(maschinenlesbar, nicht maschinenlesbar? proprietär, nicht proprietär?)
- Dataset: Funktion zur Abfrage der Metadaten eines Datensatzes, Berechnung der Metriken für einen Datensatz

### Services

``app/services``

- MetricCalculatorService: Sammelt, (berechnet) und aktualisiert die Metrikwerte beim Datenportal.

### Datenbank

``db``

- Seeds.rb: Generierung von Testdaten --> Ausführung per rake db:seed

### Module

``lib``

- CategoryMatcher: Zuordnung der Datensätze in eine Kategorie
- Harmonizer: Harmonisierung der Datensätze und Datenressourcen
- Harvester: Funktionen zur Abfrage der CKAN-Datenportale
- HashSearch: Modul zur schnellen Suche in verschachtelten Hashes
- ODM_Formats: Liste der non-proprietären und maschinenlesbaren Formate
- ODM_Licenses: Liste der offenen Lizenzen
