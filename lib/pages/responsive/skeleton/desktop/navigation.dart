import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import "../common.dart";

class DesktopNav extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationRail(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      // indicatorColor: Theme.of(context).colorScheme.inversePrimary,
      labelType: NavigationRailLabelType.selected,
      destinations: navLocations
        .getForPlatform(1)
        .map((e) => NavigationRailDestination(
          icon: Icon(e.icon),
          label: Text(e.label),
        )).toList(),
      selectedIndex: navLocations.determineSelectedIndex(context),
      onDestinationSelected: (index) => navLocations.navigateTo(context, index),
    );
  }
}
