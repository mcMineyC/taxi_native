import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

class PlatformUtils {
  static bool get isMobile {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isIOS || Platform.isAndroid;
    }
  }

  static bool get isDesktop {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isLinux || Platform.isFuchsia || Platform.isWindows || Platform.isMacOS;
    }
  }
}

Future main() async{
  if(PlatformUtils.isDesktop){
    print("Using FFI");
  }
// Initialize FFI
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi Native',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue[600]!,
          brightness: Brightness.dark
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _beenSubmitted = false;
  bool _authError = false;
  bool _triedToken = false;
  bool _triedLogin = false;
  late SharedPreferences _sp;
  bool _spInit = false;

  void reset(callback) {
    _beenSubmitted = false;
    _authError = false;
    _userController.clear();
    _passController.clear();
    setState(() {
      if(callback != null){
        callback();
      }
    });
  }

  void login() async {
    _beenSubmitted = true;
    setState(() {});
    showDialog(context: context, builder: (context) {
      return const AlertDialog(
        content: Column(
          children: [
            Text("Logging in..."),
            CircularProgressIndicator()
          ],
        )
      );
    });
    var response = await http.post(
      Uri.parse("https://forkleserver.mooo.com:3030/auth"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'username': _userController.text,
        'password': _passController.text,
      })
    );
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if(data["authorized"] == false) {
        reset(() {
          _authError = true;
          Navigator.of(context).pop();
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              content: Text("Invalid username or password"),
            );
          });
        });
        return;
      }else{
        _triedLogin = true;
        await _sp.setString("token", data["authtoken"]);
        await _sp.setString("username", data["username"]);
        Navigator.of(context).pop(); // Close the dialog
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page')));
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Just Some Random Cards')));
        reset(() {});
      }
    }
  }

  void loginToken() async {
    var token = _sp.getString("token");
    debugPrint(token.toString());
    if(_triedToken == true || token == null) {
      debugPrint("No token found");
      return;
    }
    _triedToken = true;
    _beenSubmitted = true;
    setState(() {
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
          content: Column(
            children: [
              Text("Logging in with authtoken..."),
              CircularProgressIndicator()
            ]
          )
        );
      });
    });
    var response = await http.post(
      Uri.parse("https://forkleserver.mooo.com:3030/authtoken"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': token,
      })
    );
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      debugPrint(data.toString());
      if(data["authorized"] == false) {
        Navigator.of(context).pop();
        await _sp.setString("token", "");
        return;
      }else{
        _triedLogin = true;
        await _sp.setString("token", data["authtoken"]);
        await _sp.setString("username", data["username"]);
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page')));
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Just Some Random Cards')));
        reset(() {});
      }
    }
  }

  void tryLogin() async {
    await getSP();
    var token = _sp.getString("token");
    if(token != "" && _triedToken == false && _triedLogin == false) {
      loginToken();
    }else{
      debugPrint("Normal login");
    }
  }

  Future getSP() async {
    if(_spInit == false){
      _sp = await SharedPreferences.getInstance();
    }
  }

  @override
  Widget build(BuildContext context) {
    tryLogin();
    reset(() {});
    
    return Scaffold(
      body: Container(
        child: Center(
          child: Card(
            child: Container(
              constraints: BoxConstraints(
                minHeight: 250,
                minWidth: 300,
                maxHeight: 280,
                maxWidth: 300,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 20, 24, 12), 
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 6, 24, 6),
                    child: TextField(
                      key: const ValueKey("usernameInput"),
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: const OutlineInputBorder(),
                      ),
                      onSubmitted: (value) => {
                        FocusScope.of(context).nextFocus()
                      },
                      controller: _userController,
                      enabled: !_beenSubmitted,
                    )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 6, 24, 6),
                    child: TextField(
                      key: const ValueKey("passwordInput"),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: const OutlineInputBorder(),
                      ),
                      onSubmitted: (value) => {
                        login()
                      },
                      controller: _passController,
                      enabled: !_beenSubmitted,
                    )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 6, 24, 6),
                    child: FilledButton(
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: 64,
                          minHeight: 40,
                          maxWidth: 64,
                          maxHeight: 40
                        ),
                        child: Center(
                          child: Text("Login"),
                        )
                      ),
                      onPressed: () {
                        debugPrint("Pressed login button");
                        login();
                      }

                    )
                  )
                ]
              ),
            ),
          )
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    // debugPrint((MediaQuery.of(context).size.width / 220).truncate().toString());
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Just Some Random Cards", style: GoogleFonts.poppins()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              const snacky = SnackBar(
                // width: 10,
                content: Text("Settings isn't done yet"),
              );
              ScaffoldMessenger.of(context).showSnackBar(snacky);
            },
            tooltip: "Settings",
          )
        ],
      ),
      body: Container(
        child: Center(
      child: GridView.count(
        crossAxisCount: (MediaQuery.of(context).size.width / 220).truncate(),
        
        scrollDirection: Axis.vertical,
        children: [
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
          const MediaCard(text: "dnbvaejfkwveufbfbvweuv4tmwveuvwrjcygfcjhve", thingId: "1", thingType: "Test", image: "https://picsum.photos/200"),
          const MediaCard(text: "Test #2", thingId: "2", thingType: "2", image: "https://picsum.photos/200"),
          const MediaCard(text: "Lorem ipsum dolor sit amet", image: "https://picsum.photos/200", thingId: "4", thingType: "Test #4"),
        ],
      )
      )),
    );
  }
}


class MediaCard extends StatelessWidget{
  final String text;
  final String thingId;
  final String thingType;
  final String image;
  const MediaCard({
    super.key, 
    required this.text, 
    required this.thingId, 
    required this.thingType, 
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                debugPrint("Pressed card with id: $thingId and type: $thingType");
              },
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 220.0, 
                minHeight: 230.0, 
                maxWidth: 220.0, 
                // maxHeight: 350.0,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 20, 24, 0),
                    height: 175,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.contain
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: 172,
                    height: 28,
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ),
                ]
              )
            
          )
        )
      )
    );
  }
}