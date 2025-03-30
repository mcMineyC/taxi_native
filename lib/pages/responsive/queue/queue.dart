import 'package:flutter/material.dart';
import "../../../helpers/constants.dart";
import "mobile/queue.dart";
import "desktop/queue.dart";

class QueuePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return isMobile(context) ? MobileQueuePage() : DesktopQueuePage();
  }
}