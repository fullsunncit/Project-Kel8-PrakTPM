import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/view/auth/login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFFF2CC),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffDFA67B),
          title: Text(
            'Sign Up',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 110),
              width: 300,
              child: Column(
                children: [
                  Image.asset("assets/bg.png", width: 500, height: 200),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: TextFormField(
                      enabled: true,
                      controller: _usernameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Color(0xffDFA67B)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        hintText: '   Username',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      enabled: true,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Color(0xffDFA67B)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        hintText: '   Password',
                      ),
                    ),
                  ),
                  Card(
                    //color: Color(0xff19376D),
                    child: Container(
                      height: 40,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffDFA67B), // background
                        ),
                        onPressed: () {
                          if (_usernameController.text != '' &&
                              _passwordController.text != '') {
                            _register(false);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const LoginPage();
                                }));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Sign Up Failed"),
                                    content: const Text(
                                        "Username atau password kosong"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Close"))
                                    ],
                                  );
                                }
                            );
                          }
                        },
                        child: Text("Sign Up"),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Sudah punya akun?",
                        style: TextStyle(
                          color: Colors.blue[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _register(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = value;
    prefs.setBool('status', status);
    prefs.setString('username', _usernameController.text);
    prefs.setString('password', _passwordController.text);
    prefs.commit();

    print(prefs.getString('username'));
    print(prefs.getString('password'));
    print(prefs.getBool('status'));
  }
}
