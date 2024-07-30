import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../types/checklist_item.dart';
import 'preferences_provider.dart';

part 'status_provider.g.dart';

@Riverpod(keepAlive: false)
Future<List<ChecklistItem>> getChecklistItems(GetChecklistItemsRef ref) async {
SharedPreferences _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("${await ref.read(backendUrlProvider.future)}/checklist"),
    headers: Map<String, String>.from({
      'Content-Type': 'application/json',
    }),
    body: jsonEncode(<String, String>{
      "authtoken": _sp.getString("token") ?? "",
    }),
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "message": "Not authenticated"});
  }
  desponse = desponse["todos"];
  var listThings = <ChecklistItem>[];
  desponse.forEach((e) {
    listThings.add(ChecklistItem.fromJson(e));
  });
  return listThings;
}

@Riverpod(keepAlive: false)
Future<bool> addChecklistItem(AddChecklistItemRef ref, List<String> data) async {
  SharedPreferences _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("${await ref.read(backendUrlProvider.future)}/checklist/add"),
    headers: Map<String, String>.from({
      'Content-Type': 'application/json',
    }),
    body: jsonEncode(<String, String>{
      "authtoken": _sp.getString("token") ?? "",
      "name": data[0],
      "description": data[1],
      "requestedBy": _sp.getString("username") ?? "someone",
    }),
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "message": "Not authenticated"});
  }
  return desponse["success"];
}
