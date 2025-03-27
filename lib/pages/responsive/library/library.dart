import 'package:flutter/material.dart';
import "mobile/library.dart";
import "desktop/library.dart";
import "package:taxi_native/helpers/constants.dart";
class LibraryPage extends StatelessWidget {
  final String? initialPage;
  LibraryPage({Key? key, this.initialPage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(initialPage != null) print("lib/library.dart@build: Initial page: \"$initialPage\"");
    return isMobile(context) ? MobileLibraryPage(initialPage: initialPage) : DesktopLibraryPage(initialPage: initialPage);
  }
}
