import 'package:flutter/material.dart';

class Photoalbum extends StatefulWidget {
  const Photoalbum({Key? key}) : super(key: key);

  @override
  State<Photoalbum> createState() => _PhotoalbumState();
}

class _PhotoalbumState extends State<Photoalbum> {
  List <String> picture = ['https://images.unsplash.com/photo-1647550809177-e1b7c5a6b49f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80','https://images.unsplash.com/photo-1647773326472-254366a06408?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=370&q=80','https://images.unsplash.com/photo-1647753308233-5b17884d52d3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80','https://images.unsplash.com/photo-1647735282838-a74ab6bc6d40?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80','https://images.unsplash.com/photo-1647737492369-fb6e7607cb4a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=423&q=80'];
  int counter=0;
  void next(){
    setState(() {
      counter--;
      if(counter<0) counter=picture.length-1;
    });
  }
  void previous() {
    setState(() {
      counter++;
      if (counter>=picture.length) counter=0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // return Scaffold(
      appBar: AppBar(
        title: const Text("Photo album"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(picture[counter]),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(onPressed: next,child: const Icon(Icons.arrow_left)),
                    FloatingActionButton(onPressed: previous,child: const Icon(Icons.arrow_right),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
