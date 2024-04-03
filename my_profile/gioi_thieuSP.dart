import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GioiThieu extends StatefulWidget {
  const GioiThieu({Key? key}) : super(key: key);

  @override
  State<GioiThieu> createState() => _GioiThieuState();

}

class _GioiThieuState extends State<GioiThieu> {
  List<String> img = [
    'asset/image/ram.jpg',
    'asset/image/ram1.jpg',
    'asset/image/ram2.jpg',
    'asset/image/ram3.jpg',
  ];
  int imgPos =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giới Thiệu Sản Phảm"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child:  CarouselSlider.builder(
                    itemCount: img.length,
                    itemBuilder: (context, index, realIndex) => Container(
                      child: Image.asset(img[index]),
                    ),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          imgPos = index;
                        });
                      },
                    ))
              ),
              SizedBox( height: 20,),
              Row(
                children: [
                  SizedBox(width: 350,),
                  Text("${imgPos+1}/${img.length}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox( height: 20,),
              Text("[Chính hãng] Ram laptop ASus 8G DDR4 32000GHz",style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
              SizedBox( height: 20,),
              Row(
                children: [
                  Text("850.000đ ", style: TextStyle(fontSize: 18),),
                  SizedBox(width: 10),
                  Text("125.000đ", style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: 18),),
                ],
              ),
              SizedBox( height: 30,),
              Row(
                children: [
                  Text("4.0", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                  Icon(Icons.star, color: Colors.red[200],),
                  Icon(Icons.star, color: Colors.red[200],),
                  Icon(Icons.star, color: Colors.red[200],),
                  Icon(Icons.star, color: Colors.red[200],),
                  Icon(Icons.star, color: Colors.black,),
                  SizedBox(width: 20,),
                  Text("Xem 100 đánh giá"),
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
}
