import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/firebase_connector.dart';

import 'main_page.dart';

class Bai2LoginPage extends StatefulWidget {
  const Bai2LoginPage({Key? key}) : super(key: key);

  @override
  _Ex2LoginPageState createState() => _Ex2LoginPageState();
}

class _Ex2LoginPageState extends State<Bai2LoginPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool _passwordHidden = true;
  String _loginMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng nhập"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: txtEmail,
                decoration: const InputDecoration(
                  label: Text("Email"),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: 300,
              child: TextField(
                obscureText: _passwordHidden,
                controller: txtPassword,
                decoration: InputDecoration(
                  label: const Text("Password"),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _passwordHidden ? Icons.visibility : Icons.visibility_off
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordHidden = !_passwordHidden;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              _loginMessage,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: txtEmail.text,
                        password: txtPassword.text,
                      );
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => Bai2MainPage()
                          ),
                              (Route<dynamic> route) => false
                      );
                    } on FirebaseAuthException catch(e) {
                      if(e.code == 'user-not-found') {
                        setState(() {
                          _displayLoginMessage("Email chưa được đăng ký");
                        });
                      } else if (e.code == 'wrong-password') {
                        setState(() {
                          _displayLoginMessage("Sai mật khẩu!");
                        });
                      }
                    }
                  },
                  child: const Text("Đăng nhập"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: txtEmail.text,
                        password: txtPassword.text,
                      );
                      setState(() {
                        _displayLoginMessage("Đăng ký thành công!");
                      });
                    } on FirebaseAuthException catch(e) {
                      if(e.code=='weak-password') {
                        setState(() {
                          _displayLoginMessage("Mật khẩu bảo mật kém, mời chọn mật khẩu mạnh hơn!");
                        });
                      } else if(e.code=='email-already-in-use') {
                        setState(() {
                          _displayLoginMessage("Email này đã tồn tại");
                        });
                      }
                    }
                  },
                  child: const Text("Đăng ký"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _displayLoginMessage(String msg) {
    _loginMessage = msg;
    Timer(
        const Duration(seconds: 3),
            () {
          setState(() {
            _loginMessage = "";
          });
        }
    );
  }
}