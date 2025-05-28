import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_native/helpers/extensions/uppercase_extension.dart';
import 'package:taxi_native/helpers/widgets/helper_widgets.dart';
import 'package:taxi_native/helpers/constants.dart';

import '../../../../providers/error_watcher.dart';
import '../../../../providers/data/playlist_provider.dart';
import '../../../../providers/services/player.dart';
import '../../../../types/playlist.dart';
import '../../../../types/song.dart';

class MobilePlaylistPage extends ConsumerStatefulWidget {
  @override
  MobilePlaylistPageState createState() => MobilePlaylistPageState();

  String id;
  MobilePlaylistPage({required this.id, super.key});
}

class MobilePlaylistPageState extends ConsumerState<MobilePlaylistPage> {
  String id = "";
  bool loading = true;
  FilledPlaylist data = FilledPlaylist.empty();
  List<Song> songs = [];
  bool init = false;
  bool owner = false;

  Future<bool> getOwner() async {
    if(init) return owner;
    var sp = await SharedPreferences.getInstance();
    var username = sp.getString("username") ?? "null";
    owner = data.owner == username;
    return owner;
  }

  @override
  initState() {
    super.initState();
    id = widget.id;
  }
  @override
  Widget build(BuildContext context) {
    var p = findPlaylistProvider(id);
    AsyncValue<FilledPlaylist> playlist = ref.watch(p);
    handleError(ref, p, Beamer.of(context));
    playlist.when(
      data: (data) { 
        if(init) return;
        this.data = data;
        getOwner().then((value) {
          setState(() {
            loading = false;
            songs = data.songs.toList();
            init = true;
          });
        });
      },
      loading: () => setState(() => loading = true),
      error: (_, __) => setState(() => loading = true),
    );
    //print("Playlist page rebuild");
    //print("MobilePlaylistPage: current width: ${ScreenBreakpoint.determine(MediaQuery.of(context).size.width.toInt())}");
    //print("MobilePlaylistPage: width: ${MediaQuery.of(context).size.width.toInt()}");
    return CustomScrollView(
      slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxHeight: 256, maxWidth: 256),
                  // color: Colors.blue,
                  margin: const EdgeInsets.all(12).copyWith(bottom: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: PlaylistImage(playlistId: id),
                  ),
                ),
              )
            ),
        //     child: 
        //         // if(!loading && init) Container(width: 200, height: 200, child: Center(child: Text("¯\\_(ツ)_/¯", style: Theme.of(context).textTheme.headlineMedium))),
        //         if(!loading && init) Container(width: 200, height: 200, child: PlaylistImage(playlistId: id)),
        //         if(loading) Skeletonizer(enabled: true, child: Container(width: 200, height: 200)),
        //         Expanded(
        //           child: Container(
        //             height: 200,
        //             margin: EdgeInsets.only(left: 12),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 if(!loading && init) ...[
        //                   Text(data.displayName, style: Theme.of(context).textTheme.headlineLarge, overflow: TextOverflow.ellipsis),
        //                   Row(
        //                     mainAxisSize: MainAxisSize.min,
        //                     children: [
        //                       Text(data.owner.capitalize(), style: Theme.of(context).textTheme.titleLarge),
        //                       SpacerWidget(width:6),
        //                       Icon(Icons.circle, size: 12),
        //                       SpacerWidget(width:6),
        //                       Text("${songs.length} song${songs.length == 1 ? "" : "s"}", style: Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.fade),
        //                     ]
        //                   )
        //                 ],
        //                 if(loading) ...[
        //                   const Skeletonizer(enabled: true, child: Text("Loading")),
        //                   const Skeletonizer(enabled: true, child: Text("Loading")),
        //                   const Skeletonizer(enabled: true, child: Text("Loading")),
        //                 ],
        //               ]
        //             ),
        //           ),
        //         ),
        //   ),
        // ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // if(!album.isInLibrary) IconButton.outlined(
                    //   icon: Icon(Icons.bookmark_remove_rounded),
                    //   onPressed: () async => ref.read(removeFromLibraryProvider(album.id, "album").future).then((v) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Added to library")))),
                    // ),
                    // if(album.isInLibrary) IconButton.outlined(
                    //   icon: Icon(Icons.bookmark_remove_rounded),
                    //   onPressed: () async => ref.read(removeFromLibraryProvider(album.id, "album").future).then((v) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Removed from library")))),
                    // ),
                    IconButton.outlined(
                      icon: Icon(Icons.library_add_rounded),
                      tooltip: "Add to queue",
                      onPressed: () => ref.read(playerProvider.notifier).addPlaylistToQueue(id),
                    ),
                    IconButton.outlined(
                      tooltip: "Add to playlist",
                      icon: Icon(Icons.playlist_add_rounded),
                      onPressed: () async => await playlistLogic(ref, context, id, "playlist"),
                    ),
                    FilledButton(
                      child: Row(children: [Icon(Icons.play_arrow_rounded),SizedBox(width:4),Text("Play")],),
                      onPressed: () => ref.read(playerProvider.notifier).setPlaylist(id),
                    )
                  ]
                )
              )
            ),
    if(!loading && init) SliverList.separated(
      itemCount: data.songs.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          // leading: FancyImage(url: data[index].imageUrl, width: 128, height: 128, radius: 8),
          title: Text(data.songs[index].displayName),
          subtitle: Text("${data.songs[index].albumDisplayName} - ${data.songs[index].artistDisplayName}", overflow: TextOverflow.ellipsis),
          trailing: PopupMenuButton<SongMenuItem>(
            onSelected: (SongMenuItem item) async {
              switch (item) {
                case SongMenuItem.play:
                  ref.read(playerProvider.notifier).setSong(data.songs[index].id);
                  break;
                case SongMenuItem.addToQueue:
                  ref.read(playerProvider.notifier).addIdToQueue(data.songs[index].id);
                  break;
                case SongMenuItem.delete:
                  if((await ref.read(deleteIndexFromPlaylistProvider(id, index).future)) == true) setState(() {songs.removeAt(index);data = data.copyWith(songs: songs);});
                  // ref.refresh(p);
                  break;
                default:
                  return;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SongMenuItem>>[
              const PopupMenuItem<SongMenuItem>(
                value: SongMenuItem.play,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.play_arrow_rounded), Text("Play")]),
              ),
              const PopupMenuItem<SongMenuItem>(
                value: SongMenuItem.addToQueue,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_rounded), Text("Add to queue")])
              ),
              if(owner) const PopupMenuItem<SongMenuItem>(
                value: SongMenuItem.delete,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.remove_rounded, color: Colors.red), Text("Remove", style: TextStyle(color: Colors.red))])
              ),
            ],
          ),
        );
      },
    ),
      if(loading) SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
    ]);
  }
}

enum SongMenuItem {
  play,
  addToQueue,
  divider,
  delete,
}
