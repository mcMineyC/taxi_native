import 'package:flutter/material.dart';
import "mobile/library/library.dart";
import "desktop/library/library.dart";
class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width <= 840;
    return isMobile ? MobileLibraryPage() : DesktopLibraryPage();
  }
}
