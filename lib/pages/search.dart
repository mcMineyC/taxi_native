import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/data/preferences_provider.dart';
import '../providers/services/search.dart'; 
import '../helper_widgets.dart';

class SearchPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchInfo info = ref.watch(searchProvider);
    List<Widget> wid = [Container()];
    List<bool> dividerIndices = [false];
    if(info.isLoading){
      wid = [Center(child: CircularProgressIndicator())];
      dividerIndices = [false];
    }else if(info.hasResults){
      wid = [
        Container(
          margin: EdgeInsets.symmetric(vertical: 14),
          child: Text(
            "Results",
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.left,
          ),
        )
      ];
      print(info.order);
      print(info.songs.length);
      Map<String, List<Widget>> groups = {
        "song": [
          if(info.songs.isNotEmpty) Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "Songs",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          if(info.songs.isNotEmpty) Container(
            constraints: BoxConstraints(maxHeight: info.songs.length > (MediaQuery.of(context).size.width ~/ MediaCard.width)*2 ? (MediaCard.height*2) : MediaCard.height),
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              childAspectRatio: (MediaCard.height+6) / MediaCard.width,
              crossAxisCount: info.songs.length > (MediaQuery.of(context).size.width ~/ MediaCard.width)*2 ? 2 : 1,
              children: info.songs.map((e) => MediaCard(
                image: e.imageUrl,
                text: e.displayName,
                thingType: "song",
                thingId: e.id,
              )).toList(),
            ),
          ),
        ],
        "album": [
          if(info.albums.isNotEmpty) Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "Albums",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          if(info.albums.isNotEmpty) Container(
            constraints: BoxConstraints(maxHeight: info.albums.length > (MediaQuery.of(context).size.width ~/ MediaCard.width)*2 ? (MediaCard.height*2) : MediaCard.height),
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisSpacing: 8.0,
              childAspectRatio: (MediaCard.height+6) / MediaCard.width,
              crossAxisCount: info.albums.length > (MediaQuery.of(context).size.width ~/ MediaCard.width)*2 ? 2 : 1,
              children: info.albums.map((e) => MediaCard(
                image: e.imageUrl,
                text: e.displayName,
                thingType: "album",
                thingId: e.id,
              )).toList(),
            ),
          ),
        ],
        "artist": [
          if(info.artists.isNotEmpty) Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "Artists",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          if(info.artists.isNotEmpty) Container(
            constraints: BoxConstraints(maxHeight: info.artists.length > (MediaQuery.of(context).size.width ~/ MediaCard.width)*2 ? (MediaCard.height*2) : MediaCard.height),
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisSpacing: 8.0,
              childAspectRatio: (MediaCard.height+6) / MediaCard.width,
              crossAxisCount: info.artists.length > (MediaQuery.of(context).size.width ~/ MediaCard.width)*2 ? 2 : 1,
              children: info.artists.map((e) => MediaCard(
                image: e.imageUrl,
                text: e.displayName,
                thingType: "artist",
                thingId: e.id,
              )).toList(),
            ),
          ),
        ]
      };
      for(var k in info.order){
        wid.addAll((groups[k] ?? []).toList());
      }
      dividerIndices = [true, false, true, false, true, false, true];
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        itemCount: wid.length,
        itemBuilder: (context, index) => wid[index],
        separatorBuilder: (context, index) => (dividerIndices[index]) ? const Divider() : Container(),
      ),
    );
  }
}
