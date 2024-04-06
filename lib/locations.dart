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
class InnerHomeLocation extends BeamLocation<BeamState> {
  InnerHomeLocation();
  @override
  List<String> get pathPatterns => ['/'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('home-${DateTime.now()}'),
          title: 'Home',
          child: TextButton(
            child: Text("Artists", style: GoogleFonts.poppins()),
            onPressed: () {
              context.beamToNamed("/artists");
            }
          ),
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
        key: ValueKey('artists'),
        title: 'Artists',
        child: Text('Artists'),
      ),
    ];
  }
}
class ArtistsPage extends StatelessWidget {
  const ArtistsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Text("artists");
  }
}