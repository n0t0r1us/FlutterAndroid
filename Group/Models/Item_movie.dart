
class Result {
  String? backdrop_path;
  int? id;
  String? original_language;
  String? original_title;
  String? overview;
  String? poster_path;
  String? release_date;
  String? title;
  bool? video;
  String? vote_average;

  Result(
      {required this.backdrop_path,
      required this.id,
      this.original_language,
      this.original_title,
      required this.overview,
      this.poster_path,
      required this.release_date,
      required this.title,
      this.video,
      required this.vote_average}); // Result(result) {
  //   video = result['video'];
  //   poster_path = result['poster_path'];
  //   id = result['id'];
  //   backdrop_path = result['backdrop_path'];
  //   original_language = result['original_language'];
  //   original_title = result['original_title'];
  //   title = result['title'];
  //   vote_average = result['vote_average'].toString();
  //   overview = result['overview'];
  //   release_date = result['release_date'];
  // }


  Result.fromJson(Map<String, dynamic> result){
    video = result['video'];
    poster_path = result['poster_path'];
    id = result['id'];
    backdrop_path = result['backdrop_path'];
    original_language = result['original_language'];
    original_title = result['original_title'];
    title = result['title'];
    vote_average = result['vote_average'].toString();
    overview = result['overview'];
    release_date = result['release_date'];
  }

}

class Item_movie {
  late int page;
  late int total_results;
  late int total_pages;
  late List<Result> results = [];


  Item_movie(this.page, this.total_results, this.total_pages, this.results);

  Item_movie.fromJson(Map<String, dynamic> json){
    page = json['page'];
    total_results = json['total_results'];
    total_pages = json['total_pages'];

    for (int i= 0; i< json['results'].length; i++)
    {
      Result result = Result.fromJson(json['results'][i]);
      // Result result =Result(json['results'][i]);
      results.add(result);
    }
  }
}


