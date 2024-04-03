import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home_page.dart';

class MyFirebaseAPP extends StatefulWidget {
  const MyFirebaseAPP({Key? key}) : super(key: key);

  @override
  _MyFirebaseAPPState createState() => _MyFirebaseAPPState();
}

class _MyFirebaseAPPState extends State<MyFirebaseAPP> {
  bool ketNoi = false;
  bool loi = false;

  @override
  Widget build(BuildContext context) {
    if(loi)
      return Container(
        color: Colors.white,
        child: Center(
          child: Text("Lỗi kết nối",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 20),),
        ),
      );
    else
    if(!ketNoi)
      return Container(
        color: Colors.white,
        child: Center(
          child: Text("Đang kết nối...",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 20),),
        ),
      );
    else
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      );
  }
  @override
  void initState(){
    super.initState();
    _khoiTaoFirebase();
  }
  _khoiTaoFirebase() async{
    try{
      await Firebase.initializeApp();
      setState(() {
        ketNoi = true;
      });
    }catch(e){
      setState(() {
        loi = true;
      });
    }
  }
}
