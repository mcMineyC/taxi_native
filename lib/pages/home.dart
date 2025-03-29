import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:rxdart/rxdart.dart";
import "dart:async";
import 'dart:convert';
import 'package:flutter/services.dart';

import '../providers/services/player.dart';

import 'responsive/skeleton/desktop/navigation.dart';
import 'responsive/skeleton/desktop/mediacontrols.dart';
import 'responsive/skeleton/desktop/appbar.dart';
import 'responsive/skeleton/mobile/navigation.dart';
import 'responsive/skeleton/mobile/media_controls.dart';
import 'responsive/skeleton/mobile/appbar.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key, required this.homeJunk});
  final Widget homeJunk;
  final subject = BehaviorSubject<PlayerInfo>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(playerProvider.notifier).init();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // subject.throttleTime(const Duration(seconds: 1)).listen((value) {
    //   _persistPlayerInfo(value).then((_) {});
    // });

    bool useMobile = MediaQuery.of(context).size.width <= 840;
    return useMobile
        ? MobileHomePage(
            homeJunk: homeJunk, persistenceFunction: persistPlayerInfo)
        : DesktopHomePage(
            homeJunk: homeJunk, persistenceFunction: persistPlayerInfo);
  }

  void persistPlayerInfo(PlayerInfo info) {
    // subject.add(info.copyWith(
    //     queue: info.queue
    //         .map((e) => e.copyWith(audioUrl: "not_fetched"))
    //         .toList()));
  }

  // Future<void> _persistPlayerInfo(PlayerInfo info) async {
  //   if (info.position == 0) return;
  //   (await SharedPreferences.getInstance())
  //       .setString("playerinfo", jsonEncode(info.toJson()));
  // }
}

class DesktopHomePage extends ConsumerWidget {
  const DesktopHomePage(
      {super.key, required this.homeJunk, required this.persistenceFunction});
  final Widget homeJunk;
  final Function(PlayerInfo info) persistenceFunction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
          onPressed: () => Beamer.of(context).beamToNamed('/search'),
          tooltip: "Search",
          child: const Icon(Icons.search_rounded),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(58),
        child: DesktopAppBar(),
      ),
      body: SafeArea(
          child: Column(children: [
        Expanded(
          child: Row(
            children: [
              DesktopNav(),
              Expanded(child: GenericViewport(homeJunk: homeJunk)),
            ],
          ),
        ),
        DesktopBottomBar(persistenceFunction: persistenceFunction),
      ])),
    );
  }
}

class MobileHomePage extends ConsumerWidget {
  const MobileHomePage(
      {super.key, required this.homeJunk, required this.persistenceFunction});
  final Widget homeJunk;
  final Function(PlayerInfo info) persistenceFunction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int height = MediaQuery.of(context).size.height.toInt();
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 0),
        child: FloatingActionButton(
          onPressed: () => Beamer.of(context).beamToNamed('/search'),
          tooltip: "Search",
          child: const Icon(Icons.search_rounded),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(58+36),
        child: Container(
          margin: const EdgeInsets.only(top: 36),
          child: MobileAppBar(),
        ),
      ),
      bottomNavigationBar: MobileNav(),
      body: SafeArea(
          child: Container(
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GenericViewport(homeJunk: homeJunk),
                    ),
                    MobilePlayerControls(
                        persistenceFunction: persistenceFunction),
                  ]))),
    );
  }
}

class GenericViewport extends ConsumerWidget {
  const GenericViewport({super.key, required this.homeJunk});
  final Widget homeJunk;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      // color: Colors.teal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      // color: Colors.green,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: homeJunk,
                    ))),
          ],
        ));
  }
}
