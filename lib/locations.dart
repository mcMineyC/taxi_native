import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_native_test/main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helper_widgets.dart';
import 'login.dart';
import 'pages/home.dart';

class LoginLocation extends BeamLocation<BeamState> {
  LoginLocation();
  @override
  List<String> get pathPatterns => ['/login'];
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('Login'),
        title: 'Login',
        child: LoginPage(),
      ),
    ];
  }
}