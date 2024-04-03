

import 'dart:math';

import 'package:flutter/material.dart';

List<String> fruit = [
  "Táo", "Bưởi", "Xoài", "Cam", "Ổi", "Me", "Sầu riêng", "Chôm Chôm", "Cóc", "Dừa", "Măng cục", "Thanh long", "Dưa hấu"
];
class PageListView extends StatelessWidget {
  const PageListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
        child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
              leading: Text("${index+1}"),
              title: Text(fruit[index]),
              trailing: Text("${Random().nextInt(100)}kg"),
              subtitle: Text("Đồng bằng sông Cửa Long"),
            ),
            separatorBuilder: (context, index) => Divider(thickness: 2,),
            itemCount: fruit.length
        ),
      ),
    );
  }
}

