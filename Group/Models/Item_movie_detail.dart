

class Item_detail{

  late int id;
  late List<Results_detail> results = [];

  Item_detail.fromJson(Map<String,dynamic> json){
    id = json['id'] as int;
    for (int i= 0; i< json['results'].length; i++)
    {
      Results_detail resultsDetail =Results_detail(json['results'][i]);
      results.add(resultsDetail);
    }
  }
}

class Results_detail{
  late String name;
  late String key;
  late String site;
  late int size;
  late String type;
  late bool official;
  late String published_at;

  Results_detail(results_detail){
    name = results_detail['name'];
    key = results_detail['key'];
    site = results_detail['site'];
    size = results_detail['size'];
    type = results_detail['type'];
    official = results_detail['official'];
    published_at = results_detail['published_at'];
  }
}