import 'package:flutter/material.dart';

class PageFile extends StatefulWidget {
  const PageFile({Key? key}) : super(key: key);

  @override
  State<PageFile> createState() => _PageFileState();
}

class _PageFileState extends State<PageFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(accountName:Text("Trần Đức Tín"), accountEmail:Text("tin.td.cntt@ntu.edu.vn"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("asset/image/bu_bu.jpg"),
            ),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Inbox"),
              trailing: Text("5"),
            ),
            ListTile(
              leading: Icon(Icons.face),
              title: Text("Face"),
              trailing: Text("10"),
            ),
            ListTile(
              leading: Icon(Icons.add_call),
              title: Text("Call"),
              trailing: Text("14"),
            ),
          ],
        ),
      ),
    ) ;
  }
}
