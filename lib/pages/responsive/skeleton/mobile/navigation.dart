import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:taxi_native/helpers/constants.dart";

import "../common.dart";

class MobileNav extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int width = MediaQuery.of(context).size.width.toInt();
    int height = MediaQuery.of(context).size.height.toInt();
    ScreenBreakpoint size = ScreenBreakpoint.determine(width);
    int numThings = 1;
    // print("size: ${width}x${height}");
    // print("size: $size");
    if(size >= ScreenBreakpoint.small){
      numThings++;
    }
    if(size >= ScreenBreakpoint.medium){
      numThings++;
      numThings++;
    }
    // if(width >= ScreenBreakpoint.medium.width+32){
    //   numThings++;
    // }
    if(size >= ScreenBreakpoint.large){
      numThings++;
    };
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      height: 58,
      child: NavigationBar(
        destinations: navLocations
        .getForPlatform(2)
        .map((e) => NavigationDestination(
          icon: Icon(e.icon),
          label: e.label,
        ))
        .take(numThings)
        .toList(),
          // if(width >= 700) const NavigationDestination(
          //      icon: Icon(Icons.checklist_rounded),
          //       label: "Roadmap",
          //   ),
          // if(width >= 800) const NavigationDestination(
          //  icon: Icon(Icons.bug_report_rounded),
          //  label: "Report an issue",
          // ),
        selectedIndex: navLocations.determineSelectedIndex(
          context,
          validateFunction: (i) => i > numThings ? 0 : i
        ),
        onDestinationSelected: (index) => navLocations.navigateTo(context, index)
      ),
    );
  }
}
