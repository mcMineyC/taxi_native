import 'package:beamer/beamer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taxi_native_test/locations.dart';

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
                    child: CachedNetworkImage(
                      imageUrl: image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(color:Colors.grey),
                      errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded,color:Colors.pink[700]),
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

class SpacerWidget extends StatelessWidget{
  final double height;
  final double width;
  const SpacerWidget({this.height = 0, this.width = 0});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}