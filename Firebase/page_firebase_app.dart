
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laptrinhdidong/Firebase/page_home_firebase_app.dart';
class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  State<MyFirebaseApp> createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  bool ketNoi = false;
  bool loi = false;
  @override
  Widget build(BuildContext context) {
    if(loi)
      return
          Container(
            color: Colors.white,
            child: Text("Co loi xay ra" + loi.toString(),
              style: TextStyle(fontSize: 18),
              textDirection: TextDirection.ltr,
            ),
          );
    else
      if(!ketNoi)
        return
          Container(
            color: Colors.white,
            child: Center(
              child: Text("Dang ket noi" + ketNoi.toString(),
                style: TextStyle(fontSize: 18),
                textDirection: TextDirection.ltr,
              ),
            ),
          );
      else
        return
            MaterialApp(
              title: "Ket noi Firebase",
              home: PageSinhViens(),
            );
  }

  @override
  void initState(){
    super.initState();
    _khoiTaoFirebase();
  }

  _khoiTaoFirebase()async{
    try{
      // await Firebase.initializeApp();
      await Firebase.initializeApp();
      setState(() {
        ketNoi = true;
        print(ketNoi);
      });
    }catch(e){
      setState(() {
        loi = true;
        print(ketNoi);
      });
    }
  }
}
