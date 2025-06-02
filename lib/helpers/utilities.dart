import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_native/helpers/constants.dart';
import '../providers/data/fetched_data_provider.dart';
import '../providers/data/playlist_provider.dart';
import '../providers/data/new_provider.dart';
import '../providers/services/player.dart';
import '../providers/data/info_provider.dart';

void refreshLibrary(dynamic ref) {
  ref.refresh(fetchSongsProvider(personal: true));
  ref.refresh(fetchAlbumsProvider(personal: true));
  ref.refresh(fetchArtistsProvider(personal: true));
  ref.refresh(fetchSongsProvider(personal: false));
  ref.refresh(fetchAlbumsProvider(personal: false));
  ref.refresh(fetchArtistsProvider(personal: false));
  ref.refresh(fetchPlaylistsProvider(editable: false));
  ref.refresh(fetchPlaylistsProvider(editable: true));
  ref.refresh(fetchPlaylistsProvider(ignore: true));
  ref.refresh(fetchPlaylistsProvider(ignore: false));
  ref.refresh(fetchNewPlaylistsProvider);
  ref.refresh(fetchNewSongsProvider);
  ref.refresh(fetchRecentlyPlayedProvider);
  ref.refresh(fetchLandingRecentlyPlayedProvider);
}

void invalidateProviders(WidgetRef ref) {
  ref.invalidate(fetchSongsProvider(personal: true));
  ref.invalidate(fetchAlbumsProvider(personal: true));
  ref.invalidate(fetchArtistsProvider(personal: true));
  ref.invalidate(fetchSongsProvider(personal: false));
  ref.invalidate(fetchAlbumsProvider(personal: false));
  ref.invalidate(fetchArtistsProvider(personal: false));
  ref.invalidate(fetchPlaylistsProvider(editable: false));
  ref.invalidate(fetchPlaylistsProvider(editable: true));
  ref.invalidate(fetchPlaylistsProvider(ignore: true));
  ref.invalidate(fetchPlaylistsProvider(ignore: false));
  ref.invalidate(fetchNewPlaylistsProvider);
  ref.invalidate(fetchNewSongsProvider);
  ref.invalidate(fetchRecentlyPlayedProvider);
  ref.invalidate(fetchLandingRecentlyPlayedProvider);
}

extension IterableExtensions<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) comparator) {
    try {
      return firstWhere(comparator);
    } on StateError catch (_) {
      return null;
    }
  }
}

String millisecondsToDurationString(int milliseconds) {
  final duration = Duration(milliseconds: milliseconds);
  return "${duration.inHours > 0 ? duration.inHours.toString() + ":" : ""}${duration.inHours > 0 ? (duration.inMinutes % 60).toString().padLeft(2, '0') : duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
}


void showErrorSnackBar({required BuildContext context, required String action, required String error, required String stackTrace}){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Wuh oh!  I errored out ${action} :("),
      action: SnackBarAction(
        label: "See info", 
        onPressed: () => showDialog(context: context, builder: (_) => 
          AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(error, style: Theme.of(context).textTheme.bodyLarge),
                Text(stackTrace)
              ],
            )
          )
        )
      )
    )
  );
}

int compareSemver(String va, String vb) { // if va bigger than vb returns true
  int returnVal = 0;
  Iterable<int> vaPieces = va[0] == "v" ? va.substring(1).split(".").map((e) => int.parse(e)) : va.split(".").map((e) => int.parse(e));
  Iterable<int> vbPieces = vb[0] == "v" ? vb.substring(1).split(".").map((e) => int.parse(e)) : vb.split(".").map((e) => int.parse(e));
  for(int i = 0; i < vaPieces.length; i++) {
    int val = vaPieces.elementAt(i);
    if(vbPieces.length > i){
      int valB = vbPieces.elementAt(i);
      if(valB > val){
        return 1;
      } else if (valB < val){
        return -1;
      }
    }
  }
  return 0;
}

bool hasNewVersion(String latestVersion) {
  return compareSemver(kVersionString, latestVersion) == 1;
}