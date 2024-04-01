import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beamer/beamer.dart';
import 'locations.dart';
import 'helper_widgets.dart';

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
        Beamer.of(context).beamTo(HomeLocation());
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
        Beamer.of(context).beamTo(HomeLocation());
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
