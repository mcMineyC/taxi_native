Bugs
- search doesn't work for anything but songs
  - check ts_mod.js
- cancel doesn't do anything in the loading state
- durations for songs
- Fix fake-albums
  - mislabeled singles
  - improper visibleTo application
- album song order (suspect trackNumber)
- terminate websocket connection when server url is updated or logout occurs

- Remove any // debug quick

- Visual bugs
  - make debug switch do something
    - show quick-test buttons
  - Setting the artist name by beaming results in transition that looks weird
  - make loading listview (only cards rn and it looks weird when ViewType is list)

TODO:
- edit settings to align with new M3X (ModernListItem style)
- Add time to all occurrences of an list tile song
- Add sort toggles

Longterm goals:
- migrate to using slivers for most things to implement edge-to-edge
- finish mobilizing the different views
  - Artist is not mobilized
- use colors differently