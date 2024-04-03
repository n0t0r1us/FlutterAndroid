
import 'package:flutter/material.dart';

import '../Models/Item_movie.dart';
import '../Data/Movie_data.dart';
import '../Widget/Widget.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key,}) : super(key: key);
  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  TextEditingController txtName = TextEditingController();
  var data;

  @override
  void initState() {
    super.initState();
    data = fetchSearchMovie("trailer");
  }

  void _search(){
    if(txtName.text.isNotEmpty){
      setState((){
        data = fetchSearchMovie(txtName.text);
      });
    }
  }


  @override
  void dispose() {
    txtName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color.fromRGBO(233, 233 , 233, 1),
        body: SafeArea(
          top: true,
          child: Column(
              children: [
                TextField(
                  onSubmitted: (value) {
                    _search();
                  },
                  controller: txtName,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)
                    ),
                    suffixIcon: txtName.text.isNotEmpty
                      ? GestureDetector(
                          child: Icon(Icons.close),
                            onTap: () {
                              txtName.clear();
                               FocusScope.of(context).requestFocus(FocusNode());
                            },
                      )
                  : null,
                    hintText: "Nhập tên phim",
                    enabledBorder: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    icon: Icon(Icons.search,),
                      ),
                  style: TextStyle(
                    color: Colors.red
                  ),
                ),
                Expanded(
                  child: Container(
                      child: FutureBuilder<Item_movie>(
                        future: data,
                        builder: (context, snapshot){
                          if(snapshot.hasError) {
                            print("Error" + data.toString());
                            return Text("Error");
                          }else
                            if(snapshot.connectionState==ConnectionState.done){
                              return snapshot.data!.results.length != 0
                                ? Container(
                              padding: EdgeInsets.all(5),
                              child: ListView(
                                children: [
                                  Column(
                                    children: [
                                      for(int i =0; i<snapshot.data!.results.length;i=i+3)
                                        movilayout(context,snapshot,i)
                                    ],
                                  )
                                ],
                              ),
                            )
                                : Center(child: Text("Không có dữ liệu",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),));
                            }
                            else
                              return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)),);
                        },
                      ),
                    ),
                ),
              ],
            ),
        ),
      );
  }
}
