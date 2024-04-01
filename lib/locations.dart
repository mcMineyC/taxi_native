import 'package:beamer/beamer.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_native_test/main.dart';

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

class HomeLocation extends BeamLocation<BeamState> {
  HomeLocation();
  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('home-${DateTime.now()}'),
          title: 'Home',
          child: HomePage(),
        )
      ];
}

class ArtistsLocation extends BeamLocation<BeamState> {
  ArtistsLocation();

  @override
  List<String> get pathPatterns => ['/artists'];
  
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('Artists'),
        title: 'Artists',
        child: Text('Artists'),
      ),
    ];
  }
} 