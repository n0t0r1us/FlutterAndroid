
import 'package:flutter/material.dart';
import 'package:laptrinhdidong/Group/Sao/Sao_detail.dart';
import 'package:laptrinhdidong/Group/Models/Sao_item.dart';
import '../Movie/Movie_detail.dart';
import '../Movie/Video_youtube.dart';

Widget getImage(String? url){
  if (url!= null)
    return Image.network("https://image.tmdb.org/t/p/original/$url",fit: BoxFit.cover,width: 200,height: 200,);
  else
    return Container(
      width: 200,
      height: 200,
      child: Icon(Icons.image),
    );
}

Widget getImageDetail(String? url){
  if (url!= null)
    return Image.network("https://image.tmdb.org/t/p/original/$url",fit: BoxFit.cover,);
  else
    return Center(
      child: Icon(Icons.image),
    );
}

Widget trailerLayout(data, context) {
  if (data.results.length > 0) {
    return Column(
      children: [
        for(int i =0; i<data.results.length;i++)
          VideoTrailer(url: data.results[i].key,title: data.results[i].name,type: data.results[i].type,),

      ],
    );
  }
  else
    return Text("Không có trailer",style: TextStyle(fontSize: 20,color: Colors.black45),);
}

Widget cardMovies(context,snapshot,i) => Row(
  children: [
    Expanded(child: cardMovie(context,snapshot,i)),
    const SizedBox(width: 5),
    Expanded(child: cardMovie(context,snapshot,i+1)),
    const SizedBox(width: 5),
    Expanded(child: cardMovie(context,snapshot,i+2)),
  ],
);

Widget movilayout(context,snapshot,i){
  return (
      Column(
        children: [
          cardMovies(context, snapshot,i),
          const SizedBox(height: 5),
        ],
      )
  );

}

Widget cardMovie(context,snapshot,i) {
  if(snapshot.data!.results.length>i){
    return
      GestureDetector(
        onTap: () {
          Route route = MaterialPageRoute(builder: (context) => Moviedetail(id: snapshot.data!.results[i].id,dataphim: snapshot.data!.results[i],));
          Navigator.push(context, route);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: getImage(snapshot.data!.results[i].poster_path)
              ),
              Text(
                snapshot.data?.results[i].title.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Text(
                    snapshot.data!.results[i].vote_average.toString(),
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }else
    return
      Text("");
}

Widget cardSao(context,i) {
    return
      GestureDetector(
        onTap: () {
          Route route = MaterialPageRoute(builder: (context) => Saodetail(name: listSao[i].ten, url: listSao[i].url));
          Navigator.push(context, route);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 80,
                    height: 80,
                    child: CircleAvatar(
                      // backgroundColor: Colors.cyan[100],
                      backgroundImage: NetworkImage(listSao[i].url),
                    )
                ),
                Text(listSao[i].ten,style: TextStyle(color: Colors.black45,fontSize: 12),)
              ],
            ),
          ),
        ),
      );
}

Widget cardCategory(context, data){
  return
    FutureBuilder(
        future: data,
        builder: (_,snapshot){
          return snapshot.hasData ?
          ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_,index){
                return Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    width: 150,
                    child: cardMovie(context,snapshot,index)
                );
              }
          ) :
          Center(child: CircularProgressIndicator(),);
        }
    );
}


