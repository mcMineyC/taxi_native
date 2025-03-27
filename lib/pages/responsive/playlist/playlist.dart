import 'package:flutter/material.dart';
import "mobile/playlist.dart";
import "desktop/playlist.dart";
import "package:taxi_native/helpers/constants.dart";
class PlaylistPage extends StatelessWidget {
  final String id;
  PlaylistPage({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isMobile(context) ? MobilePlaylistPage(id: id) : DesktopPlaylistPage(id: id);
  }
}
