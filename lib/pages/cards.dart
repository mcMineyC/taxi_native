import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../helper_widgets.dart';

class CardView extends StatelessWidget {
  final List cardList;

  const CardView({super.key, required this.cardList});
  @override
  Widget build(BuildContext context) {
    double count = (MediaQuery.of(context).size.width / (MediaCard.width+32));
    return GridView.count(
        crossAxisCount: count.ceil(),
        scrollDirection: Axis.vertical,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: MediaCard.width / (MediaCard.height+6),
        children: cardList.map(
          (card) => MediaCard(text: card["text"], image: card["image"], thingId: card["id"], thingType: card["type"], addedBy: card["addedby"])
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
