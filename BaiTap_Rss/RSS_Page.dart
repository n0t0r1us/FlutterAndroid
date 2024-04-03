import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laptrinhdidong/BaiTap_Rss/RSSItem.dart';
import 'package:laptrinhdidong/BaiTap_Rss/RSS_Helper.dart';

import 'RSS_Page2.dart';

class RSS_Page extends StatefulWidget {
  const RSS_Page({Key? key}) : super(key: key);

  @override
  State<RSS_Page> createState() => _RSS_PageState();
}

class _RSS_PageState extends State<RSS_Page> {
  late Future<List<RSSItem>?> rssItem;
  @override
  void initState(){
    super.initState();
    rssItem = RSS_Helper.readVNExpressRSS();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Doc bao"),
      ),
      body: RefreshIndicator(
        onRefresh: ()  async {
          rssItem = RSS_Helper.readVNExpressRSS().whenComplete(() => setState(() {
          },));
        },
        child: FutureBuilder<List<RSSItem>?>(
          future: rssItem,
          builder: (context, snapshot){
            if(snapshot.hasError) {
              print("Error" + rssItem.toString());
              return Text("Error");
            }
            return snapshot.hasData
                ?
            Container(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Route route = MaterialPageRoute(builder: (context) => RSS_Page2(snapshot.data![index].link));
                              Navigator.push(context, route);
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 120,
                                  child: _getImage(snapshot.data![index].imageUrl),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text(snapshot.data![index].title!, style: TextStyle(fontSize: 15, color: Colors.blue),),
                                )
                              ],
                            ),
                          ),
                          Text(snapshot.data![index].description!),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index)=>Divider(thickness: 2,),
                  itemCount: snapshot.data?.length??0,
              ),
            )
                : Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
  Widget _getImage(String? url){
    if (url!= null)
      return Image.network(url,fit: BoxFit.fitWidth,);
    else
      return Center(
        child: Icon(Icons.image),
      );
  }
}
