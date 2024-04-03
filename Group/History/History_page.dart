import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:laptrinhdidong/Group/Models/Item_movie.dart';

import 'package:provider/provider.dart';
import '../Models/History_item.dart';
import '../Movie/Movie_detail.dart';
import '../Widget/Widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromRGBO(233, 233 , 233, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Lịch sử xem".toUpperCase(),
          style: Theme.of(context).textTheme.caption?.copyWith(
            color: Colors.black45,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),),
      body: Consumer<QLHistory>(
        builder: (context, data,child){
          if(data.list.isEmpty){
            return Center(child: Text("Không có dữ liệu"));
          }else {
            return
              ListView.builder(
                itemCount: data.list.length,
                itemBuilder: (context, indexs){
                  final index = data.list.length - 1 - indexs;
                  // print(data.list.length);
                  // print(indexs);
                  return
                    Slidable(
                      child: Card(
                        margin: EdgeInsets.all(10),
                        color: Colors.white,
                        shadowColor: Colors.blueGrey,
                        elevation: 5,
                        child: GestureDetector(
                          onTap: () {
                            Result result = new Result(backdrop_path: data.list[index].key, id: data.list[index].id, overview: data.list[index].overview, title: data.list[index].title, vote_average: data.list[index].vote_average, release_date:data.list[index].release_date);
                            Route route = MaterialPageRoute(builder: (context) => Moviedetail(id: data.list[index].id,dataphim: result,));
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
                                    child: getImageDetail(data.list[index].key)
                                ),
                              ),
                              SizedBox(width: 5,),
                              Expanded(
                                child: Text(data.list[index].title,style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                  overflow: TextOverflow.ellipsis,
                                ),),
                              ),
                              IconButton(
                                onPressed:() {
                                  context.read<QLHistory>().deleteHistory(index);
                                },
                                color:Colors.red.shade300 ,
                                icon: Icon(Icons.delete),
                              )
                            ],
                          ),
                        ),
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              context.read<QLHistory>().deleteHistory(index);
                            },
                            backgroundColor: Colors.red.shade300,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Xóa',
                          ),
                        ],
                      ),
                    );
                },
              );
          }
        },
      )
    );
  }
}
