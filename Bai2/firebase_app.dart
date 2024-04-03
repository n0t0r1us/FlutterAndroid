import 'package:flutter/material.dart';
import 'package:untitled4/firebase_connector.dart';

import 'login_page.dart';

class Bai2App extends StatelessWidget {
  const Bai2App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseConnector(
      builder: (context) => const MaterialApp(
        title: "Kết nối Firebase App",
        debugShowCheckedModeBanner: false,
        home: Bai2LoginPage(),
      ),
      errMsg: "Lỗi kết nối!",
      connMsg: "Đang kết nối...",
    );
  }
}