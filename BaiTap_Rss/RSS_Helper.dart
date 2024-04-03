
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:laptrinhdidong/BaiTap_Rss/RSSItem.dart';
import 'package:xml2json/xml2json.dart';

class RSS_Helper{
  static String _rssURL = "https://vnexpress.net/rss/tin-moi-nhat.rss";
  // static String _rssURL="https://api.themoviedb.org/3/search/movie?api_key=e9f6f99d3bc6855bd887c4af111538b6&query=superman";
  static Future<List<RSSItem>?> readVNExpressRSS() async{
    var rssJsons = await fetchRSS();
    if(rssJsons != null){
      var listRSSItem = rssJsons.map((e) => VNExpressRSSItem().getRSSFromJson(e)).toList();
      return listRSSItem;
    }else
    return null;
  }

  static Future<List<dynamic>?> fetchRSS() async{
    final response = await http.get(Uri.parse(_rssURL));
    if(response.statusCode==200){
      final xml2Json = Xml2Json();
      xml2Json.parse(utf8.decode(response.bodyBytes));
      String rssJson = xml2Json.toParker();
      Map<String, dynamic> jonData = jsonDecode(rssJson);
      return (jonData["rss"]["channel"]["item"]);
    }
    return null;
  }
}