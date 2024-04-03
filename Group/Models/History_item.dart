import 'package:flutter/foundation.dart';

import '../Data/History_data.dart';


class History{
  late String key;
  late int id;
  late String title;
  late String vote_average;
  late String release_date;
  late String overview;

  History.fromJson(Map<String, dynamic> json){
    key = json['key'];
    id = json['id'];
    title = json['title'];
    vote_average = json['vote_average'];
    release_date = json['release_date'];
    overview = json['overview'];
  }

  Map<String, dynamic> toJson() =>{
    'key': key,
    'id': id,
    'title': title,
    'vote_average': vote_average,
    'release_date': release_date,
    'overview': overview,
  };

  History({required this.key,required this.id,required this.title,required this.vote_average, required this.release_date,required this.overview});
}

class QLHistory extends ChangeNotifier{
  List<History> _list= [];

  List<History> get list => _list;

  void readHistori() async{
    _list = await readJsonFile().whenComplete(() {
      notifyListeners();
    });
  }

  Future<List<History>> writeHistory(History history)async{
    await writeJsonFile(history).whenComplete(()async{
      _list = await readJsonFile().whenComplete(() {
        notifyListeners();
      });
    });
    return [];
  }

  Future<List<History>> deleteHistory(int index)async{
    await deleteJsonFile(index).whenComplete(()async{
      _list = await readJsonFile().whenComplete(() {
        notifyListeners();
      });
    });
    return [];
  }
}