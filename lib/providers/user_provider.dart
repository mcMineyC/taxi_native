import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_provider.g.dart';

@riverpod
Future<String> userName(UserNameRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  String? user = prefs.getString('username') ?? "user";
  return user.substring(0, 1).toUpperCase() + user.substring(1);
}
