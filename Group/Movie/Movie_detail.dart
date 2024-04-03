



import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:laptrinhdidong/Group/Data/History_data.dart';
import 'package:laptrinhdidong/Group/Models/Item_movie_detail.dart';
import '../Models/Favorite_item.dart';
import '../Models/History_item.dart';
import '../Models/Item_movie.dart';
import '../Data/Movie_data.dart';
import '../Widget/Widget.dart';
import 'Video_youtube.dart';

class Moviedetail extends StatefulWidget {
  final dataphim;
  final id;
  const Moviedetail({this.id, this.dataphim});

  @override
  createState() => _MoviedetailState(this.id,this.dataphim);
}

class _MoviedetailState extends State<Moviedetail> {
  Result datamovie;
  int id;
  var data;
  var favorite;
  var index;
  _MoviedetailState(this.id, this.datamovie);

  @override
  void initState() {
    super.initState();
    favorite = false;
    data = fetchMovieDetail(id);
    FavoriteSnapshot.getAllFavorite().forEach((element) {
      for(int i = 0 ;i<element.length;i++){
        if(element[i].favorite!.id == id){
            favorite = true;
        }
      }
    });
    write();
  }

void write()async{
    bool kt = false;
    var list = await readJsonFile();
    for(int i = 0; i<list.length;i++){
      if(list[i].id == id){
        kt = true;
        break;
      }
    }
    if(kt == false){
      History history = History(key: datamovie.backdrop_path.toString(), id: id, title: datamovie.title.toString(), vote_average: datamovie.vote_average.toString(), release_date: datamovie.release_date.toString(), overview: datamovie.overview.toString());
      await writeJsonFile(history);
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(222, 222 , 222, 1),
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: 500,
                  floating: false,
                  elevation: 0.0,
                  flexibleSpace: FlexibleSpaceBar(
                      background: getImageDetail(datamovie.backdrop_path != null ? datamovie.backdrop_path : datamovie.poster_path),
                  ),
                ),
              ];
            },
            body:Container(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    datamovie.title!.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          Text(
                                            'Release date'.toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            datamovie.release_date!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                              color: Colors.yellow[800],
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:[
                                          Text(
                                            'vote average'.toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
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
                                                datamovie.vote_average!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2!
                                                    .copyWith(
                                                  color: Colors.yellow[800],
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Flexible(
                                        child: (
                                          StreamBuilder<List<FavoriteSnapshot>>(
                                            stream: FavoriteSnapshot.getAllFavorite(),
                                            builder: (context,snapshot){
                                              if(snapshot.hasData){
                                                for (int i = 0; i < snapshot.data!.length; i++) {
                                                  if (snapshot.data![i].favorite!.id == id) {
                                                    index = i;
                                                  }
                                                }
                                                return IconButton(
                                                  icon: Icon(favorite
                                                      ? Icons.star
                                                      : Icons.star_border),
                                                  color: Colors.brown,
                                                  onPressed: () {
                                                    if (favorite == true) {
                                                      snapshot.data![index]
                                                          .delete();
                                                      favorite = false;
                                                    }
                                                    else {
                                                      Favorite fv = new Favorite(id: id, title: datamovie.title, url: datamovie.backdrop_path,overview: datamovie.overview,release_date: datamovie.release_date,vote_average: datamovie.vote_average);
                                                      FavoriteSnapshot.addNew(fv);
                                                      favorite = true;
                                                    }
                                                  },
                                                );
                                              }
                                              else return Icon(Icons.star_border);
                                            },
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Text(
                                datamovie.overview!,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Trailer'.toUpperCase(),
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: FutureBuilder<Item_detail>(
                                future: data,
                                builder: (context,snapshot){
                                  return
                                  snapshot.hasData ?
                                  trailerLayout(snapshot.data,context)
                                  //VideoTrailer(url: snapshot.data!.results[0].key,title: snapshot.data!.results[0].name,type: snapshot.data!.results[0].type,)
                                  : Center(child: CircularProgressIndicator(),);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}



