
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:laptrinhdidong/listview/ListSP.dart';
import 'package:provider/provider.dart';
class ListSanPham extends StatelessWidget {
  const ListSanPham({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QLSanPham(),
      child: MaterialApp(
        home: ListSP(),
      ),
    );
  }
}
