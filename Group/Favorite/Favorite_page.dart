import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Models/Favorite_item.dart';
import '../Models/Item_movie.dart';
import '../Movie/Movie_detail.dart';
import '../Widget/Widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  void initState() {
    super.initState();
    _khoiTaoFirebase();
  }


  _khoiTaoFirebase()async{
    try{
      // await Firebase.initializeApp();
      await Firebase.initializeApp();
    }catch(e){
      print("ket noi that bai");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(233, 233 , 233, 1),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Phim yêu thích".toUpperCase(),
            style: Theme.of(context).textTheme.caption?.copyWith(
              color: Colors.black45,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),),
      body:  StreamBuilder<List<FavoriteSnapshot>>(
        stream: FavoriteSnapshot.getAllFavorite(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print(snapshot.error);
            return Center(
              child: Text("Loi xay ra khi truy van"),
            );
          }else
          if(!snapshot.hasData)
            return Center(
              child: Text("Dang tai du lieu",style: TextStyle(color: Colors.black45),),
            );
          else if(snapshot.data!.isNotEmpty){
            print(snapshot.data!.length);
            return
              ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index)=>Slidable(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    shadowColor: Colors.blueGrey,
                    elevation: 5,
                    child: GestureDetector(
                      onTap: () {
                        Result result = new Result(backdrop_path: snapshot.data![index].favorite!.url, id: snapshot.data![index].favorite!.id, overview: snapshot.data![index].favorite!.overview, title: snapshot.data![index].favorite!.title, vote_average: snapshot.data![index].favorite!.vote_average, release_date:snapshot.data![index].favorite!.release_date);
                        Route route = MaterialPageRoute(builder: (context) => Moviedetail(id: snapshot.data![index].favorite!.id,dataphim: result,));
                        Navigator.push(context, route);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                                width: 100,
                                height: 100,
                                child: getImageDetail(snapshot.data![index].favorite!.url)
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Text(snapshot.data![index].favorite!.title.toString(),style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                              overflow: TextOverflow.ellipsis,
                            ),),
                          ),
                          IconButton(
                            onPressed:() {
                              snapshot.data![index].delete();
                            },
                            color:Colors.red.shade300 ,
                            icon: Icon(Icons.delete),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );;
          }else{
            return Center(child: Text("Không có dữ liệu"));
          }
        },
      ),
    );
  }
}
