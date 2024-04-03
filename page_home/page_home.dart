import 'package:flutter/material.dart';

import '../form/form_page.dart';
import '../grid_view/page_gridview.dart';
import '../grid_view/page_gridview2.dart';
import '../grid_view/page_slider.dart';
import '../grid_view/picker.dart';
import '../list_view/page_listview.dart';
import '../my_profile/gioi_thieuSP.dart';
import '../my_profile/page_profile.dart';
import '../provider/catalog2.dart';
import '../provider/exam_provider.dart';
import '../share_preferences/page_sharepreferences.dart';

class PageHome extends StatefulWidget {
  const PageHome ({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _State();
}

class _State extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text("Home Page"),
    ),
    body:Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  style:  ElevatedButton.styleFrom(
        minimumSize: Size(150, 40),
    ),
                  onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PageMyFile(),
                ),

                );
              },
              child: Text("My Profile",)),

              ElevatedButton(
                  style:  ElevatedButton.styleFrom(
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => GioiThieu(),
                ),
                );
              },
                  child: Text("Giới Thiệu SP",)),
              ElevatedButton(
                  style:  ElevatedButton.styleFrom(
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => PageListView(),
                ),
                );
              },
                  child: Text("ListView",)),

              ElevatedButton(
                  style:  ElevatedButton.styleFrom(
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => PageGridView(),
                ),
                );
              },
                  child: Text("GridView",)),
              ElevatedButton(
                  style:  ElevatedButton.styleFrom(
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => Grid(),
                    ),
                    );
                  },
                  child: Text("GridView2",)),
              ElevatedButton(
                  style:  ElevatedButton.styleFrom(
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => PageFormDienThoai(),
                    ),
                    );
                  },
                  child: Text("FormPage",)),
              ElevatedButton(
                  style:  ElevatedButton.styleFrom(
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => ListSP(),
                    ),
                    );
                  },
                  child: Text("SharePreferences",)),
            ],
          ),
    ),
    );
  }
}

