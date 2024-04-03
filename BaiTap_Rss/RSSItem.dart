

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class RSSItem{
  String? title;
  String? pudDate;
  String? description;
  String? link;
  String? imageUrl;

  Map<String, dynamic> toJson(){
    return{
      "title": this.title,
      "date" : this.pudDate,
      "description" : this.description,
      "url" : this.link,
      "imageUrl" : this.imageUrl
    };
  }
  
   RSSItem getRSSFromJson(Map<String, dynamic> json){
    title = json['title'];
    pudDate = json['pubDate'];
    description=_getDescription(json['description']);
    link=json['link'];
    imageUrl=_getImageUrl(json['description']);
    return this;
  }

  String _getDescription(String rawDescription);
  String? _getImageUrl(String rawDescription);
}

class VNExpressRSSItem extends RSSItem{
  
  @override
  String _getDescription(String rawDescription){
    int start = rawDescription.indexOf('</a></br>') + 9;
    if(start>9){
      return rawDescription.substring(start);
    }
    return "";
  }
  
  @override
  String? _getImageUrl(String rawDescription){
    int start = rawDescription.indexOf('img src="') + 9;
    if(start>9){
      int end = rawDescription.indexOf('"',start);
      return rawDescription.substring(start,end);
    }
    return null;
  }
  
}