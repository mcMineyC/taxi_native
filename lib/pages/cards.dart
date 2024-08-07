import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:context_menus/context_menus.dart';
import '../helper_widgets.dart';

class CardView extends StatelessWidget {
  final List cardList;

  const CardView({super.key, required this.cardList});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: (MediaQuery.of(context).size.width / 224).ceil(),
        scrollDirection: Axis.vertical,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: 200 / 238,
        children: cardList.map(
          (card) => MediaCard(text: card["text"], image: card["image"], thingId: card["id"], thingType: card["type"])
        ).toList(),
    );
  }
}

Skeletonizer LoadingCardView(){
  return Skeletonizer(
          enabled: true,
          child: CardView(cardList: [for (int i = 0; i < 32; i++) {"text": "meh who cares", "id": "idklol", "type": "placeholder", "image": "https://placehold.co/512x512.png"}]),
        );
}
