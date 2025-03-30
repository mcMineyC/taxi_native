import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taxi_native/helpers/widgets/marque.dart';
import 'package:taxi_native/helpers/widgets/modern_list_item.dart';
// import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../providers/error_watcher.dart';
import '../../../../../providers/data/fetched_data_provider.dart';
import '../../../../../helpers/widgets/helper_widgets.dart';
import '../../../../../providers/services/player.dart';
import "package:context_menus/context_menus.dart";
import "../common.dart";

class MobileAlbumPage extends ConsumerWidget {
  const MobileAlbumPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var p = findAlbumProvider(id);
    var abum = ref.watch(p);
    var sp = findSongsByAlbumProvider(id);
    var sngs = ref.watch(sp);
    handleError(ref, sp, Beamer.of(context));
    handleError(ref, p, Beamer.of(context));
    return abum.when(
      data: (album) => sngs.when(
        data: (songs) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxHeight: 256, maxWidth: 256),
                  // color: Colors.blue,
                  margin: const EdgeInsets.all(12).copyWith(bottom: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: CachedNetworkImage(
                      imageUrl: album.imageUrl,
                    ),
                  ),
                ),
              )
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MarqueeTextWidget(text: album.displayName, fontColor: Theme.of(context).colorScheme.onSurface, fontSize: 26, fontWeight: FontWeight.w900),
                    MarqueeTextWidget(text: album.artistDisplayName, fontColor: Theme.of(context).colorScheme.onSurface, fontSize: 22, fontWeight: FontWeight.bold),
                    Text("${songs.length} songs", style: Theme.of(context).textTheme.headlineSmall, overflow: TextOverflow.fade),
                  ]
                ),
              )
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if(!album.isInLibrary) IconButton.outlined(
                      icon: Icon(Icons.bookmark_remove_rounded),
                      onPressed: () async => await ref.read(removeFromLibraryProvider(album.id, "album").future),
                    ),
                    if(album.isInLibrary) IconButton.outlined(
                      icon: Icon(Icons.bookmark_remove_rounded),
                      onPressed: () async => await ref.read(removeFromLibraryProvider(album.id, "album").future),
                    ),
                    IconButton.outlined(
                      icon: Icon(Icons.playlist_add_rounded),
                      onPressed: () async => await playlistLogic(ref, context, album.id, "album"),
                    ),
                    FilledButton(
                      child: Row(children: [Icon(Icons.play_arrow_rounded),SizedBox(width:4),Text("Play")],),
                      onPressed: () => ref.read(playerProvider.notifier).setAlbum(id),
                    )
                  ]
                )
              )
            ),
            SliverList.list(
              children: songs.asMap().entries.map((entry) => ModernListItem(
                isEnd: entry.key == songs.length-1,
                isStart: entry.key == 0,
                titleText: entry.value.displayName,
                subtitleText: "${entry.value.artistDisplayName} - ${entry.value.albumDisplayName}",
                trailing: IconButton(
                icon: Icon(Icons.more_horiz_rounded),
                onPressed: (){
                  context.contextMenuOverlay.show(GenericContextMenu(
                    buttonConfigs: buildContextMenuConfig(ref, context, entry.value),
                  ));
                },
              )
              )).toList(),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
        loading: () => Expanded(child: Center(child:CircularProgressIndicator())),
        error: (___, ____) => Expanded(child: Center(child: Icon(Icons.error_outline_rounded))),
      ),
      loading: () => Expanded(child: Center(child:CircularProgressIndicator())),
      error: (_, __) => Expanded(child: Center(child: Icon(Icons.error_outline_rounded))),
    );
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: [
    //     Row(
    //       children: [
    //         album.when(
    //           data: (data) => FancyImage(url: data.imageUrl, width: 200, height: 200, radius: 12),
    //           loading: () => Skeletonizer(enabled: true, child: Container(width: 200, height: 200)),
    //           error: (_, __) => Skeletonizer(enabled: true, child: Container(width: 200, height: 200)),
    //         ),
    //         Expanded(child: 
    //           Container(
    //           height: 200,
    //           margin: EdgeInsets.only(left: 12),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: album.when(
    //               data: (data) => [
    //                 Text(data.displayName, style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface), overflow: TextOverflow.ellipsis),
    //                 Text(data.artistDisplayName, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onSurface), overflow: TextOverflow.ellipsis),
    //                 Text(
    //                   //"${data.songCount} song${(data.songCount > 1) ? "s" : ""}",
    //                   "Added by ${data.addedBy}",
    //                   style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface), overflow: TextOverflow.ellipsis
    //                 ),
    //                 Text(
    //                     "Added on ${(){DateTime time = DateTime.fromMillisecondsSinceEpoch(data.added).toLocal(); return time.month.toString().padLeft(2, "0") + "/" + time.day.toString().padLeft(2, "0") + "/" + time.year.toString() + " " + time.hour.toString().padLeft(2, "0") + ":" + time.minute.toString().padLeft(2, "0");}()}",
    //                     //"${data.songCount} song${(data.songCount > 1) ? "s" : ""}",
    //                     style: Theme.of(context)
    //                         .textTheme
    //                         .titleMedium!
    //                         .copyWith(
    //                             color: Theme.of(context).colorScheme.onSurface),
    //                     overflow: TextOverflow.ellipsis),
    //               ],
    //               loading: () => [
    //                 const Skeletonizer(enabled: true, child: Text("Loading")),
    //                 const Skeletonizer(enabled: true, child: Text("Loading")),
    //                 const Skeletonizer(enabled: true, child: Text("Loading")),
    //               ],
    //               error: (_, __) => [
    //                 const Skeletonizer(enabled: true, child: Text("Error")),
    //                 const Skeletonizer(enabled: true, child: Text("Error")),
    //                 const Skeletonizer(enabled: true, child: Text("Error")),
    //               ],
    //             ),
    //           ),
    //         )
    //       ),
    //       Container(
    //         width: 200,
    //         height: 148,
    //         margin: EdgeInsets.only(right: 24),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             FilledButton.tonal(
    //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Container(margin: EdgeInsets.only(right: 8), child: Icon(Icons.play_arrow_rounded)), Text("Play")]),
    //               onPressed: () => ref.read(playerProvider.notifier).setAlbum(id),
    //             ),
    //             OutlinedButton(
    //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Container(margin: EdgeInsets.only(right: 8), child: Icon(Icons.add_rounded)), Text("Add to queue")]),
    //               onPressed: () => ref.read(playerProvider.notifier).addAlbumToQueue(id),
    //             ),
    //             OutlinedButton(
    //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Container(margin: EdgeInsets.only(right: 8), child: Icon(Icons.playlist_add_rounded)), Text("Add to playlist")]),
    //               // onPressed: () => ref.read(playerProvider.notifier).addAlbumToQueue(id),
    //               onPressed: () async => await playlistLogic(ref, context, id, "album"),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    //   songs.when(
    //     data: (data) => Expanded(
    //       child: ListView.separated(
    //         itemCount: data.length,
    //         separatorBuilder: (BuildContext context, int index) => const Divider(),
    //         itemBuilder: (BuildContext context, int index) {
    //           return ListTile(
    //             // leading: FancyImage(url: data[index].imageUrl, width: 128, height: 128, radius: 8),
    //             title: Text(data[index].displayName),
    //             subtitle: Text("${data[index].albumDisplayName} - ${data[index].artistDisplayName}", overflow: TextOverflow.ellipsis),
    //             trailing: PopupMenuButton<SongMenuItem>(
    //               onSelected: (SongMenuItem item) async {
    //                 switch (item) {
    //                   case SongMenuItem.play:
    //                     ref.read(playerProvider.notifier).setSong(data[index].id);
    //                     break;
    //                   case SongMenuItem.addToQueue:
    //                     ref.read(playerProvider.notifier).addIdToQueue(data[index].id);
    //                     break;
    //                   case SongMenuItem.addToPlaylist:
    //                     await playlistLogic(ref, context, data[index].id, "song");
    //                     break;
    //                   case SongMenuItem.delete:
    //                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Not implemented yet!')));
    //                     break;
    //                   default:
    //                     return;
    //                 }
    //               },
    //               itemBuilder: (BuildContext context) => <PopupMenuEntry<SongMenuItem>>[
    //                 const PopupMenuItem<SongMenuItem>(
    //                   value: SongMenuItem.play,
    //                   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.play_arrow_rounded), Text("Play")]),
    //                 ),
    //                 const PopupMenuItem<SongMenuItem>(
    //                   value: SongMenuItem.addToQueue,
    //                   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_rounded), Text("Add to queue")])
    //                 ),
    //                 const PopupMenuItem<SongMenuItem>(
    //                   value: SongMenuItem.addToPlaylist,
    //                   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.playlist_add_rounded), Text("Add to playlist")])
    //                 ),
    //                 const PopupMenuItem<SongMenuItem>(
    //                   value: SongMenuItem.delete,
    //                   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.delete_rounded, color: Colors.red), Text("Delete", style: TextStyle(color: Colors.red))])
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //     loading: () => Center(child: CircularProgressIndicator()),
    //     error: (_, __) => Center(child: CircularProgressIndicator()),
    //   ),
    // ]);
  }
}
