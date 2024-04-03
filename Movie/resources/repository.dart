

import '../models/item_model.dart';
import 'movie_api_provider.dart';

class Repository {

  final movieApiProvider = MovieApiProvider();
  Future fetchAllMovies() => movieApiProvider.fetchMovieList();
  Future fetchMovieDetail(int movieId) => movieApiProvider.fetchMovieDetail(movieId);
}