import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../providers/error_watcher.dart';
import '../providers/data/fetched_data_provider.dart';
import '../providers/services/player.dart';
import '../helpers/platform_utils.dart';
import '../helpers/widgets/helper_widgets.dart';

class ArtistPage extends ConsumerWidget {
  const ArtistPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var p = findArtistProvider(id);
    var artist = ref.watch(p);
    var sp = findNoSinglesByArtistProvider(id);
    var albums = ref.watch(sp);
    var s = findSinglesByArtistProvider(id);
    var singles = ref.watch(s);
    handleError(ref, sp, Beamer.of(context));
    handleError(ref, p, Beamer.of(context));
    handleError(ref, s, Beamer.of(context));

    bool mobile = MediaQuery.of(context).size.width <= 840;
    int count =
        ((MediaQuery.of(context).size.width / MediaCard.width).floor()) +
            (mobile ? 1 : 0);

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(
          children: [
            artist.when(
              data: (data) => FancyImage(
                  url: data.imageUrl, width: 200, height: 200, radius: 12),
              loading: () => Skeletonizer(
                  enabled: true, child: Container(width: 200, height: 200)),
              error: (_, __) => Skeletonizer(
                  enabled: true, child: Container(width: 200, height: 200)),
            ),
            Expanded(
                child: Container(
              height: 200,
              margin: EdgeInsets.only(left: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: artist.when(
                  data: (data) => [
                    Text(data.displayName,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                        overflow: TextOverflow.ellipsis),
                    Text(
                        "Added by ${data.addedBy}",
                        //"${data.songCount} song${(data.songCount > 1) ? "s" : ""}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                        overflow: TextOverflow.ellipsis),
                    Text(
                        "Added on ${(){DateTime time = DateTime.fromMillisecondsSinceEpoch(data.added).toLocal(); return time.month.toString().padLeft(2, "0") + "/" + time.day.toString().padLeft(2, "0") + "/" + time.year.toString() + " " + time.hour.toString().padLeft(2, "0") + ":" + time.minute.toString().padLeft(2, "0");}()}",
                        //"${data.albumCount} album${(data.albumCount > 1) ? "s" : ""}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                        overflow: TextOverflow.ellipsis),
                  ],
                  loading: () => [
                    const Skeletonizer(enabled: true, child: Text("Loading")),
                    const Skeletonizer(enabled: true, child: Text("Loading")),
                    const Skeletonizer(enabled: true, child: Text("Loading")),
                  ],
                  error: (_, __) => [
                    const Skeletonizer(enabled: true, child: Text("Error")),
                    const Skeletonizer(enabled: true, child: Text("Error")),
                    const Skeletonizer(enabled: true, child: Text("Error")),
                  ],
                ),
              ),
            )),
            Container(
              width: 200,
              height: 148,
              margin: EdgeInsets.only(right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton.tonal(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 8),
                              child: Icon(Icons.play_arrow_rounded)),
                          Text("Play")
                        ]),
                    onPressed: () {
                      if (PlatformUtils.isWeb) {
                        showWebError(context);
                        return;
                      }
                      ref.read(playerProvider.notifier).setArtist(id);
                    },
                  ),
                  OutlinedButton(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 8),
                              child: Icon(Icons.add_rounded)),
                          Text("Add to queue")
                        ]),
                    onPressed: () {
                      if (PlatformUtils.isWeb) {
                        showWebError(context);
                        return;
                      }
                      ref.read(playerProvider.notifier).addArtistToQueue(id);
                    },
                  ),
                  OutlinedButton(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 8),
                              child: Icon(Icons.playlist_add_rounded)),
                          Text("Add to playlist")
                        ]),
                    onPressed: () async {
                      await playlistLogic(ref, context, id, "artist");
                    },
                  )
                ],
              ),
            ),
          ],
        ),
        albums.when(
          data: (data) => data.length == 0
              ? Container()
              : Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 24).copyWith(top: 12),
                  child: Row(
                    children: [
                      Text("Albums",
                          style: Theme.of(context).textTheme.headlineSmall),
                      Expanded(child: Container()),
                      TextButton(
                          onPressed: () => Beamer.of(context)
                              .beamToNamed("/artist/${id}/albums"),
                          child: Text("See all")),
                    ],
                  )),
          loading: () => Container(),
          error: (_, __) => Container(),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: albums.when(
            data: (data) => GridView.count(
              crossAxisCount: count,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 0,
              // scrollDirection: Axis.vertical,
              childAspectRatio: MediaCard.width / (MediaCard.height + 10),
              children: data
                  .take(count * 2)
                  .map((a) => MediaCard(
                      text: a.displayName,
                      image: a.imageUrl,
                      thingId: a.id,
                      thingType: "album",
                      addedBy: a.addedBy,
                      inLibrary: a.isInLibrary,
                  ))
                  .toList(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Center(child: CircularProgressIndicator()),
          ),
        ),
        singles.when(
          data: (data) => data.length == 0
              ? Container()
              : Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 24).copyWith(top: 12),
                  child: Row(
                    children: [
                      Text("Singles",
                          style: Theme.of(context).textTheme.headlineSmall),
                      Expanded(child: Container()),
                      TextButton(
                          onPressed: () => Beamer.of(context)
                              .beamToNamed("/artist/${id}/singles"),
                          child: Text("See all")),
                    ],
                  )),
          loading: () => Container(),
          error: (_, __) => Container(),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: singles.when(
            data: (data) => GridView.count(
              crossAxisCount: count,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 0,
              // scrollDirection: Axis.vertical,
              childAspectRatio: MediaCard.width / (MediaCard.height + 10),
              children: data
                  .take(count * 2)
                  .map((a) => MediaCard(
                      text: a.displayName,
                      image: a.imageUrl,
                      thingId: a.id,
                      thingType: "song",
                      addedBy: a.addedBy,
                      inLibrary: a.isInLibrary,
                      ))
                  .toList(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ]),
    );
  }
}
