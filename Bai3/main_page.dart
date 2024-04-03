import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'chi_page.dart';
import 'thu_page.dart';
import 'so_du_page.dart';

class Bai3MainPage extends StatefulWidget {
  const Bai3MainPage({Key? key}) : super(key: key);

  @override
  _Bai3MainPageState createState() => _Bai3MainPageState();
}

class _Bai3MainPageState extends State<Bai3MainPage> {
  int _index = 0;

  final _pages = [
    const Bai3SoDuPage(),
    const Bai3ThuPage(),
    const Bai3ChiPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý chi tiêu"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Bai3DetailPage(
              readOnly: false,
            ),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            label: "Trang chính",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.attach_money,
              color: Colors.green,
            ),
            label: "Chi tiết thu",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.money_off,
              color: Colors.red,
            ),
            label: "Chi tiết chi",
          ),
        ],
      ),
      body: _pages[_index],
    );
  }
}
