import 'package:flutter/material.dart';
import "mobile/library/library.dart";
import "desktop/library/library.dart";
class LibraryPage extends StatelessWidget {
  final String? initialPage;
  LibraryPage({Key? key, this.initialPage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(initialPage != null) print("lib/library.dart@build: Initial page: \"$initialPage\"");
    var isMobile = MediaQuery.of(context).size.width <= 840;
    return isMobile ? MobileLibraryPage(initialPage: initialPage) : DesktopLibraryPage(initialPage: initialPage);
  }
}
