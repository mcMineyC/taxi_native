import 'package:flutter/material.dart';
import "package:taxi_native/helpers/constants.dart";
import 'desktop/settings.dart';
import 'mobile/settings.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    print("USING MOBILE SETTINGS PAGE");
    return isMobile(context) ? MobileSettingsPage() : DesktopSettingsPage();
  }
}