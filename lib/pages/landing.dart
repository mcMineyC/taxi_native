import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper_widgets.dart';
import 'cards.dart';
import '../providers/fetched_data_provider.dart'; 
import '../types/artists.dart';

class LandingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.all(24),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Favorites"),
              Container(
                // constraints: BoxConstraints(
                //   minHeight: 400,
                //   minWidth: 400,
                //   maxHeight: 400,
                // ),
                color: Colors.pink[700],
                child: Row(
                  children: [
                    MediaCard(
                      text: "A great song",
                      thingId: "thisisgreat",
                      thingType: "song",
                      image: "https://via.placeholder.com/512"
                    )
                  ],
                )
              )
            ]
          )
        ]
      )
    );
  }
}
