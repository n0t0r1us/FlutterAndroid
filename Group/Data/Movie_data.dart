import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'as http;
import '../Models/Item_movie.dart';
import '../Models/Item_movie_detail.dart';

Future<Item_movie> fetchMovieList() async {
  var response ;
  const _apiKey = 'e9f6f99d3bc6855bd887c4af111538b6';
  const _baseUrl = "http://api.themoviedb.org/3/movie";
  var uri = Uri.parse("$_baseUrl/popular?api_key=$_apiKey");
  response = await http.get (uri);

  if(response.statusCode == 200){
    return Item_movie.fromJson(json.decode(response.body));
  }
  else {
    throw Exception(" Lỗi khi load Json");
  }
}

Future<Item_detail> fetchMovieDetail(int id) async {
  var response ;
  var uri = Uri.parse("https://api.themoviedb.org/3/movie/${id}/videos?api_key=e9f6f99d3bc6855bd887c4af111538b6");
  response = await http.get (uri);

  if(response.statusCode == 200){
    return Item_detail.fromJson(json.decode(response.body));
  }
  else {
    throw Exception(" Lỗi khi load Json");
  }
}

Future<Item_movie> fetchSearchMovie(String query) async {
  var response ;

  var uri = Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=e9f6f99d3bc6855bd887c4af111538b6&query='${query}");
  response = await http.get (uri);

  if(response.statusCode == 200){
    return Item_movie.fromJson(json.decode(response.body));
  }
  else {
    throw Exception(" Lỗi khi load Json");
  }
}
