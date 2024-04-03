

import 'package:flutter/material.dart';

List<String> img = [
  'asset/image/ram.jpg',
  'asset/image/ram1.jpg',
  'asset/image/ram2.jpg',
  'asset/image/ram3.jpg',
  'asset/image/ram.jpg',
  'asset/image/ram1.jpg',
  'asset/image/ram2.jpg',
  'asset/image/ram3.jpg',
  'asset/image/ram.jpg',
  'asset/image/ram1.jpg',
  'asset/image/ram2.jpg',
  'asset/image/ram3.jpg',
  'asset/image/ram.jpg',
  'asset/image/ram1.jpg',
  'asset/image/ram2.jpg',
  'asset/image/ram3.jpg',
  'asset/image/ram.jpg',
  'asset/image/ram1.jpg',
  'asset/image/ram2.jpg',
  'asset/image/ram3.jpg',
];

class PageGridView extends StatelessWidget {
  const PageGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Grid View"),
      ),
      body: GridView.extent(maxCrossAxisExtent: 150,
      mainAxisSpacing:5,
      crossAxisSpacing:5,
        children: List.generate(img.length, 
                (index) => GestureDetector(
                    child: Container(
                      child: Image.asset(img[index]),
                )))
      ),
    );
  }
}
