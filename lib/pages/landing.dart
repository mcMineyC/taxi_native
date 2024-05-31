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
      child: ListView(
        children: [
          Text(
            "Hello, User!",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Favorites", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              Container(
                color: Colors.pink[700],
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MediaCard(
                        text: "A great song",
                        thingId: "thisisgreat",
                        thingType: "song",
                        image: "https://placehold.co/512x512.png",
                      ),
                      MediaCard(
                        text: "A great song",
                        thingId: "thisisgreat",
                        thingType: "song",
                        image: "https://placehold.co/512x512.png",
                      ),
                      MediaCard(
                        text: "A great song",
                        thingId: "thisisgreat",
                        thingType: "song",
                        image: "https://placehold.co/512x512.png",
                      ),
                      MediaCard(
                        text: "A great song",
                        thingId: "thisisgreat",
                        thingType: "song",
                        image: "https://placehold.co/512x512.png",
                      ),
                      MediaCard(
                        text: "A great song",
                        thingId: "thisisgreat",
                        thingType: "song",
                        image: "https://placehold.co/512x512.png",
                      ),
                      MediaCard(
                        text: "A great song",
                        thingId: "thisisgreat",
                        thingType: "song",
                        image: "https://placehold.co/512x512.png",
                      ),
                      MediaCard(
                        text: "A great song",
                        thingId: "thisisgreat",
                        thingType: "song",
                        image: "https://placehold.co/512x512.png",
                      ),
                      MediaCard(
                        text: "A great song",
                        thingId: "thisisgreat",
                        thingType: "song",
                        image: "https://placehold.co/512x512.png",
                      ),
                    ],
                  ),
                )
              )
            ]
          )
        ]
      )
    );
  }
}
