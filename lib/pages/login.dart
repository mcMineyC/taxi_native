import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as prov;
import '../providers/data/user_provider.dart';
import '../providers/data/preferences_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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

  void login(username, password) async {
    _beenSubmitted = true;
    setState(() {});
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Logging in..."),
            Container(height: 10),
            const CircularProgressIndicator()
          ],
        )
      );
    });
    int success = await ref.read(loginPasswordProvider(username, password).future);
    _triedLogin = true;
    if(success == 1) {
        prov.Provider.of<PreferencesProvider>(context, listen: false).username = username;
        Navigator.of(context).pop(); // Close the dialog
        Beamer.of(context).beamToReplacementNamed("/home");
        reset(() {});
    }else if(success == 0){
      reset(() {
        _authError = true;
        Navigator.of(context).pop();
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: const Text("Invalid username or password"),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ]
          );
        });
      });
    }else if(success == -1) {
      setState(() {
        _authError = true;
        Navigator.of(context).pop();
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: const Text("Server error (it's probably down)"),
            actions: [
              TextButton(
                child: const Text("Edit URL"),
                onPressed: () async {
                  if(await showEditUrlDialog(context)){login(username, password);}
                }
              ),
              TextButton(
                child: const Text("Retry"),
                onPressed: () {
                  _triedToken = false;
                  Navigator.of(context).pop();
                  login(username, password);
                },
              ),
              TextButton(
                child: const Text("Ok"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ]
          );
        });
      });
    }  
  }

  void loginToken() async {
    var token = _sp.getString("token");
    debugPrint("Trying authtoken");
    debugPrint(token.toString());
    if(_triedToken == true || token == null) {
      debugPrint("No token found");
      return;
    }
    _triedToken = true;
    _beenSubmitted = true;
    setState(() {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Column(
          mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Logging in with authtoken..."),
              Container(height: 10),
              const CircularProgressIndicator()
            ]
          )
        );
      });
    });
    int code = await ref.read(loginTokenProvider(token).future);
    switch(code){
      case 1:
        Navigator.of(context).pop();
        Beamer.of(context).beamToReplacementNamed("/home");
        break;
      case 0:
        Navigator.of(context).pop();
        await _sp.setString("token", "");
        break;
      case -1:
        Navigator.of(context).pop();
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Text("Server error (it's probably down)"),
            actions: [
              TextButton(
                child: const Text("Edit URL"),
                onPressed: () async {
                  _triedToken = false;
                  if(await showEditUrlDialog(context)){loginToken();}
                }
              ),
              TextButton(
                child: const Text("Retry"),
                onPressed: () {
                  _triedToken = false;
                  Navigator.of(context).pop();
                  loginToken();
                }
              ),
              TextButton(
                child: const Text("Ok"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ]
          );
        });
        break;
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
                        login(_userController.text, _passController.text)
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
                        login(_userController.text, _passController.text);
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

Future<bool> showEditUrlDialog(BuildContext context) async {
  PreferencesProvider prefs = prov.Provider.of<PreferencesProvider>(context, listen: false);
  TextEditingController urlController = TextEditingController(text: prefs.backendUrl);
  bool result = await showDialog(context: context, builder: (context) => AlertDialog(
    title: const Text("Edit URL"),
    content: TextField(
      controller: urlController,
      decoration: const InputDecoration(
        hintText: "URL",
        border: OutlineInputBorder(),
      ),
    ),
    actions: [
      TextButton(
        child: const Text("Cancel"),
        onPressed: () => Navigator.of(context).pop(false),
      ),
      TextButton(
        child: const Text("Save"),
        onPressed: () => Navigator.of(context).pop(true),
      ),
    ],
  ));
  if(result) {
    prefs.backendUrl = urlController.text;
    return true;
  }
  return false;
}
