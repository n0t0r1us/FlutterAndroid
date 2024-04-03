import 'package:http/http.dart'as http;
import 'dart:convert';

import 'Photo.dart';
Future<List<dynamic>> fetchData(String data) async{
  var url = Uri.parse('https://jsonplaceholder.typicode.com/$data');
  var response = await http.get(url);
  if(response.statusCode==200)
     return jsonDecode(response.body);
  else
    return[];
}

Future<List<Photo>> fetchPhotos() async{
  var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
  var response = await http.get(url);
  if(response.statusCode==200){
    List<Photo> photos;
    var list = jsonDecode(response.body) as List;
    photos = list.map((item) => Photo.fromJson(item)).toList();
    return photos;
  }
  else{
    print("Không tải được Album");
    throw Exception("Khong tai duoc Album");
  }
}