import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:beamer/beamer.dart';

import '../providers/error_watcher.dart';
import '../helper_widgets.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artist '+id),
      ),
      body: Center(
        child: Text(id),
      ),
    );
  }
}
