import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laptrinhdidong/Group/History/History_page.dart';
import '../Favorite/Favorite_page.dart';
import '../History/History_page_home.dart';
import 'Movie_page.dart';
import 'Movie_search_app.dart';




class Movie extends StatefulWidget {

  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  int _currentIndex = 0;
  final _widgetOptions = [
    MoviePageTrailer(),
    SearchMovie(),
    FavoritePage(),
    HistopyPageHome()
  ];


  @override
  void initState() {
    super.initState();
   _khoiTaoFirebase();
  }

  _khoiTaoFirebase()async{
    try{
      // await Firebase.initializeApp();
      await Firebase.initializeApp();
    }catch(e){
      print("ket noi that bai");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_currentIndex)),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color.fromRGBO(233, 233, 233, 1),
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Trang chủ'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text('Tìm kiếm'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.star),
            title: Text('Yêu thích'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.history),
            title: Text('Lịch sử'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
