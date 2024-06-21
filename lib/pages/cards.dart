import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taxi_native_test/helper_widgets.dart';

class CardView extends StatelessWidget {
  final List cardList;

  const CardView({super.key, required this.cardList});
  @override
  Widget build(BuildContext context) {
    return  GridView.count(
        crossAxisCount: (MediaQuery.of(context).size.width / 220).truncate(),
        scrollDirection: Axis.vertical,
        mainAxisSpacing: 10,
        crossAxisSpacing: 0,
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
