class ItemModel {
  late int page;
  late int total_results;
  late int total_pages;
  late List<_Result> results =[] ;

  // Get data from Json
  ItemModel.fromJson(Map<String, dynamic> parsedJson){

    page = parsedJson['page'];
    total_results = parsedJson['total_results'];
    total_pages = parsedJson['total_pages'];

    for (int i= 0; i< parsedJson['results'].length; i++)
    {
      _Result result = _Result(parsedJson['results'][i]);
      results.add(result);
    }

  }

}

class _Result {
  late double popularity;
  late int vote_count;
  late bool video;
  late String poster_path ;
  late int id;
  late bool adult;
  late String backdrop_path;
  late String original_language;
  late String original_title;
  late List<int> genre_ids=[];
  late String title;
  late String vote_average;
  late String overview;
  late String release_date;

  _Result(result) {
    popularity = result['popularity'];
    vote_count = result['vote_count'];
    video = result['video'];
    poster_path = result['poster_path'];
    id = result['id'];
    adult = result['adult'];
    backdrop_path = result['backdrop_path'];
    original_language = result['original_language'];
    original_title = result['original_title'];

    for (int i = 0; i < result['genre_ids'].length; i++) {
      genre_ids.add(result['genre_ids'][i]);
    }
    title = result['title'];
    vote_average = result['vote_average'].toString();
    overview = result['overview'];
    release_date = result['release_date'];
  }

  }
