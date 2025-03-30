import 'package:flutter/material.dart';
import "../../../../helpers/constants.dart";

import "mobile/album.dart";
import 'desktop/album.dart';
class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return isMobile(context) ? MobileAlbumPage(id: id) : DesktopAlbumPage(id: id);
  }
}