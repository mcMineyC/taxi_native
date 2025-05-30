Bugs
- search doesn't work for anything but songs
  - check ts_mod.js
- cancel doesn't do anything in the loading state
- clicking on song in list view redirects you to /songs/:id
- adding playlist but deleting song messes up the artist assignment
- durations for songs
- Fix fake-albums
  - mislabeled singles
  - improper visibleTo application
- Show all (not just inLibrary) for artist details page
- album song order (suspect trackNumber)
- artists randomly don't show up?
- make debug switch do something
  - show quick-test buttons

TODO:
- edit settings to align with new M3X (ModernListItem style)
- Add time to all occurrences of an list tile song
- Add sort toggles

Longterm goals:
- migrate to using slivers for most things to implement edge-to-edge
- finish mobilizing the different views
- use colors differently