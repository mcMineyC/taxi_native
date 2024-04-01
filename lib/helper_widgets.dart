import 'package:flutter/material.dart';

class MediaCard extends StatelessWidget{
  final String text;
  final String thingId;
  final String thingType;
  final String image;
  const MediaCard({
    super.key, 
    required this.text, 
    required this.thingId, 
    required this.thingType, 
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                debugPrint("Pressed card with id: $thingId and type: $thingType");
              },
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 220.0, 
                minHeight: 230.0, 
                maxWidth: 220.0, 
                // maxHeight: 350.0,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 20, 24, 0),
                    height: 175,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.contain
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: 172,
                    height: 28,
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ),
                ]
              )
            
          )
        )
      )
    );
  }
}