import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/preferences_provider.dart';
import '../providers/search_provider.dart'; 

class SearchPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchInfo info = ref.watch(searchProvider);
    Widget wid = Container();
    if(info.isLoading){
      wid = Center(child: CircularProgressIndicator());
    }else if(info.hasResults){
      wid = Container(color: Colors.blue);
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            wid
          ],
        ),
      )
    );
  }
}
