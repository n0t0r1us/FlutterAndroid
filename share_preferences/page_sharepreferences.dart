import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageCountSharePreferences extends StatefulWidget {
  const PageCountSharePreferences({Key? key}) : super(key: key);

  @override
  State<PageCountSharePreferences> createState() => _PageCountSharePreferencesState();
}

class _PageCountSharePreferencesState extends State<PageCountSharePreferences> {
  late int count ;
  late String key_pre = "key_pre";
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Counter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.getInt(key_pre);
              count++;
              _readCount();
            },
                child: Text("Tăng")),
            SizedBox(height: 20,),
            Text("${count}"),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              count = count! + 1;
              preferences.getInt(key_pre);
              _readCount();
            },
                child: Text("Giảm")),
          ],
        ),
      ),
    );
  }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _readCount();
  }
  _readCount() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      count = preferences.getInt(key_pre) ?? 0 ;
    });
  }
}

// đọc file counter
// setState{
//   _couter = int.parse(counter)
// }
