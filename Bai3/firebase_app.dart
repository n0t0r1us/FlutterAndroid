import 'package:flutter/material.dart';
import 'package:test1/helpers/firebase_connector.dart';


import 'main_page.dart';

class Bai3App extends StatelessWidget {
  const Bai3App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseConnector(
      builder: (context) => const MaterialApp(
        title: "Kết nối đến Firebase App",
        debugShowCheckedModeBanner: false,
        home: Bai3MainPage(),
      ),
      errMsg: "Lỗi kết nối!",
      connMsg: "Đang kết nối...",
    );
  }
}