import "package:flutter/material.dart";
import "package:beamer/beamer.dart";
// name, accetable paths, icon, show on (1: desktop, 2: mobile, 0: both)
_NavInfo navLocations = _NavInfo(navLocations: [
  _NavDestination(
    label: "Home",
    paths: ["home"],
    icon: Icons.home_rounded,
    showOn: 0, // both
  ),
  _NavDestination(
    label: "Library",
    paths: ["library"],
    icon: Icons.library_music_rounded,
    showOn: 0, // both
  ),
  _NavDestination(
    label: "Queue",
    paths: ["queue"],
    icon: Icons.queue_music_rounded,
    showOn: 0, // both
  ),
  _NavDestination(
    label: "Adder",
    paths: ["adder"],
    icon: Icons.download_rounded,
    showOn: 0, // both
  ),

]);

class _NavInfo {
  final List<_NavDestination> navLocations;
  _NavInfo({required this.navLocations});

  List<_NavDestination> getForPlatform(int p) => this.navLocations.where(
      (e) => e.showOn == 0 || e.showOn == p
    ).toList();

  int determineSelectedIndex(BuildContext context, {Function(int)? validateFunction}){
    LocalKey? currentKey = Beamer.of(context).currentPages.last.key;
    if(currentKey == null) return 0;
    print("CurrentPath: ${Beamer.of(context).currentPages.last.key}");
    int index = this.navLocations
      .map(
        (e) => e.paths.map(
          (e) => ValueKey(e)
        )
        .contains(currentKey)
      )
      .toList()
      .asMap()
      .entries
      .firstWhere(
        (e) => e.value == true
      )
      .key;
    return validateFunction != null ? validateFunction(index) : index;
  }
  void navigateTo(context, index){
    if(index >= this.navLocations.length)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("This feature isn't done yet :("),
      ));
    else
      Beamer.of(context).beamToNamed("/${this.navLocations[index].paths[0]}");
  }
}
class _NavDestination {
  final String label;
  final List<String> paths;
  final IconData icon;
  final int showOn;
  const _NavDestination({required this.label, required this.paths, required this.icon, required this.showOn});
}