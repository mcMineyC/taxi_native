import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              // if(!loading && init) Container(width: 200, height: 200, child: Center(child: Text("¯\\_(ツ)_/¯", style: Theme.of(context).textTheme.headlineMedium))),
              if(!loading && init) Container(width: 200, height: 200, child: PlaylistImage(playlistId: id)),
              if(loading) Skeletonizer(enabled: true, child: Container(width: 200, height: 200)),
              Expanded(
                child: Container(
                  height: 200,
                  margin: EdgeInsets.only(left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(!loading && init) ...[
                        Text(data.displayName, style: Theme.of(context).textTheme.headlineLarge, overflow: TextOverflow.ellipsis),
                        Text(data.owner.substring(0, 1).toUpperCase() + data.owner.substring(1), style: Theme.of(context).textTheme.headlineSmall, overflow: TextOverflow.ellipsis),
                        Text("${data.songs.length} song${(data.songs.length > 1) ? "s" : ""}", style: Theme.of(context).textTheme.bodyLarge),
                      ],
                      if(loading) ...[
                        const Skeletonizer(enabled: true, child: Text("Loading")),
                        const Skeletonizer(enabled: true, child: Text("Loading")),
                        const Skeletonizer(enabled: true, child: Text("Loading")),
                      ],
                    ]
                  ),
                ),
              ),
          Container(
            width: 200,
            height: 148,
            margin: EdgeInsets.only(right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton.tonal(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Container(margin: EdgeInsets.only(right: 8), child: Icon(Icons.play_arrow_rounded)), Text("Play")]),
                  onPressed: () => ref.read(playerProvider.notifier).setPlaylist(id),
                ),
                OutlinedButton(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Container(margin: EdgeInsets.only(right: 8), child: Icon(Icons.add_rounded)), Text("Add to queue")]),
                  onPressed: () => ref.read(playerProvider.notifier).addPlaylistToQueue(id),
                ),
                OutlinedButton(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Container(margin: EdgeInsets.only(right: 8), child: Icon(Icons.playlist_add_rounded)), Text("Add to playlist")]),
                  // onPressed: () => ref.read(playerProvider.notifier).addAlbumToQueue(id),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Not implemented yet!')))
                ),
              ],
            ),
          ),
        ],
      ),
      if(!loading && init) Expanded(
          child: ListView.separated(
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
        ),
        if(loading) Center(child: CircularProgressIndicator()),
      ]),
    );
  }
}

enum SongMenuItem {
  play,
  addToQueue,
  divider,
  delete,
}
