import 'dart:convert';

import 'package:http/http.dart' show Client, Response;

import '../models/item_model.dart';
import '../models/movie_detail_model.dart';

class MovieApiProvider {
  Client client = Client ();
  final _apiKey = 'e9f6f99d3bc6855bd887c4af111538b6';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<dynamic> fetchMovieList() async {
    Response response ;
    var uri = Uri.parse("$_baseUrl/popular?api_key=$_apiKey");
    response = await client.get (uri);

    if(response.statusCode == 200){
      return ItemModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception(" Lỗi khi load Json");
    }
  }
  Future fetchTrailer(int movieId) async {
    var uri = Uri.parse("$_baseUrl/popular?api_key=$_apiKey");
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(json.decode(response.body));
    } else {
    throw Exception('Lỗi khi load');
    }
  }
  Future<MovieDetailModel> fetchMovieDetail(int movieId) async {
    var uri = Uri.parse("$_baseUrl/popular?api_key=$_apiKey");
    final response =
    await client.get(uri);

    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Lỗi khi load');
    }
  }
}