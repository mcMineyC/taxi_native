import 'package:flutter/material.dart';
import "lib/hierarchicalListView.dart";
import 'dart:io';
import "dart:async";
import "dart:convert";
import "lib/types/searchresult.dart";

void main() async {
  String json = await File('test.json').readAsString();
  List<dynamic> jsonList = jsonDecode(json);
  List<FindResult> results =
      jsonList.map((e) => FindResult.fromJson(e)).toList();
  List<HLVArtist> artists = findResultsToHLVContent(results);
  await File("out.json").writeAsString(jsonEncode(artists));
  printHLVContent(artists);
  runApp(MyApp(artists: artists));
}

class MyApp extends StatelessWidget {
  final List<HLVArtist> artists;
  MyApp({required this.artists});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Music List')),
        body: HierarchicalListView(data: artists),
      ),
    );
  }
}
