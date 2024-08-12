import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:rxdart/rxdart.dart";
import "dart:async";
import 'dart:convert';

import '../providers/services/player.dart';

import 'desktop/home/navigation.dart';
import 'desktop/home/mediacontrols.dart';
import 'desktop/home/appbar.dart';
import 'mobile/home/navigation.dart';
import 'mobile/home/media_controls.dart';
import 'mobile/home/appbar.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key, required this.homeJunk});
  final Widget homeJunk;
  final subject = BehaviorSubject<PlayerInfo>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(playerProvider.notifier).init();
    subject.throttleTime(const Duration(seconds: 1)).listen((value) {
      _persistPlayerInfo(value).then((_) => print("Persisted player info"));
    });
    
    bool useMobile = MediaQuery.of(context).size.width <= 840;
    return useMobile ? MobileHomePage(homeJunk: homeJunk, persistenceFunction: persistPlayerInfo) : DesktopHomePage(homeJunk: homeJunk, persistenceFunction: persistPlayerInfo);
  }
  void persistPlayerInfo(PlayerInfo info) {
    subject.add(info.copyWith(queue: info.queue.map((e) => e.copyWith(audioUrl: "not_fetched")).toList()));
  }

  Future<void> _persistPlayerInfo(PlayerInfo info) async {
    (await SharedPreferences.getInstance()).setString("playerinfo", jsonEncode(info.toJson()));
  }
}

class DesktopHomePage extends ConsumerWidget {
  const DesktopHomePage({super.key, required this.homeJunk, required this.persistenceFunction});
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
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                DesktopNav(),
                Expanded(
                  child: GenericViewport(homeJunk: homeJunk)
                ),
              ],
            ),
          ),
          DesktopBottomBar(persistenceFunction: persistenceFunction),
        ]
      ),
    );
  }
}

class MobileHomePage extends ConsumerWidget {
  const MobileHomePage({super.key, required this.homeJunk, required this.persistenceFunction});
  final Widget homeJunk;
  final Function(PlayerInfo info) persistenceFunction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int height = MediaQuery.of(context).size.height.toInt();
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: (height >= 560) ? 16 : 0),
        child: FloatingActionButton(
          onPressed: () => Beamer.of(context).beamToNamed('/search'),
          tooltip: "Search",
          child: const Icon(Icons.search_rounded),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(58),
        child: MobileAppBar(),
      ),
      bottomNavigationBar: MobileNav(),
        body: Container(
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GenericViewport(homeJunk: homeJunk),
              ),
              MobilePlayerControls(persistenceFunction: persistenceFunction),
            ]
          )
        )
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
                margin: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                child: homeJunk,
              )
            )
          ),
        ],
      )
    ); 
  }
}
