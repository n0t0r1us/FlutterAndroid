import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dtin62cntt/grid_view/page_gridview2.dart';

class ShowSlider extends StatefulWidget {
  const ShowSlider({Key? key}) : super(key: key);

  @override
  State<ShowSlider> createState() => _ShowSliderState();
}

class _ShowSliderState extends State<ShowSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Người Mẫu"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: CarouselSlider.builder(
                    itemCount: listNM.length,
                    itemBuilder: (context, index, realIndex) => Container(
                      child: Image.asset(listNM.toString()),
                    ),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 1,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
 
}

