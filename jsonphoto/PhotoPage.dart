import 'package:flutter/material.dart';
import 'package:laptrinhdidong/jsonphoto/Photo.dart';
import 'package:laptrinhdidong/jsonphoto/PhotoList.dart';

import 'Listdata.dart';

class PhotosPageState extends StatefulWidget {
  const PhotosPageState({Key? key}) : super(key: key);

  @override
  State<PhotosPageState> createState() => _PhotosPageStateState();
}

class _PhotosPageStateState extends State<PhotosPageState> {
  late Future<List<Photo>> photos;

  @override
  void initState(){
    super.initState();
    photos = Photo_hepper.readPhoto();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("demo"),
      ),
      body: FutureBuilder<List<Photo>>(
        future: photos,
        builder: (context, snapshot){
          if(snapshot.hasError) {
            print("Lỗi xảy ra");
            return Text("Lỗi xảy ra");
          }
          return snapshot.hasData
              ? PhotoList(photos: snapshot.data,)
              : Center(child: CircularProgressIndicator(),);
        },
      )
      ,
    );
  }
}

class Photo_hepper{
  static String datafetch = 'photos';
   static Future<List<Photo>> readPhoto() async{
    List data =await fetchData(datafetch);
    return data.map((item) => Photo.fromJson(item)).toList();
  }
}

