import 'package:flutter/cupertino.dart';
import 'package:laptrinhdidong/Group/Models/History_item.dart';
import 'package:provider/provider.dart';

import 'History_page.dart';



class HistopyPageHome extends StatefulWidget {
  const HistopyPageHome({Key? key}) : super(key: key);

  @override
  State<HistopyPageHome> createState() => _HistopyPageHomeState();
}

class _HistopyPageHomeState extends State<HistopyPageHome> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        var data = QLHistory();
        data.readHistori();
        return data;
      },
      child: HistoryPage(),
    );
  }
}
