import 'package:flutter/material.dart';
import 'package:flutter_dtin62cntt/provider/changnotifer_counter.dart';
import 'package:provider/provider.dart';

class PageExam extends StatelessWidget {
  const PageExam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create:(context) => Counter(),
        child: PageCouter2(),
    );
  }
}
class PageCouter extends StatelessWidget {
  const PageCouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
      ),
      body: Consumer<Counter>(
        builder: (context, sodem, child) => Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: () {
                sodem.tang();
              },
                  child: Text("Tăng")),
              Text("${sodem.cout}"),
              ElevatedButton(onPressed: () {
                sodem.giam();
              },
                  child: Text("Giảm")),
            ],
          ),
        ),
      )
    );
  }
}


class PageCouter2 extends StatelessWidget {
  const PageCouter2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter My App"),
      ),
  body:  SingleChildScrollView(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed:() {
            var c = context.read<Counter>();
            c.tang();
          }, 
              child: Text("Tăng")),
          Consumer<Counter>(builder: (context, value, child) => Column(
            children: [
              Text("${value.cout}"),
              child!
            ],
          ),
            child: Text("Khong the build: ${context.read<Counter>().cout}"),
          ),
          ElevatedButton(onPressed:() {
            var c = context.read<Counter>();
            c.giam();
          },
              child: Text("Giảm")),
        ],
      ),
    ),
  ),
    );
  }
}


class Counter3 extends StatelessWidget {
  const Counter3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counter = context.watch<Counter>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Count 3"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              var c = Provider.of<Counter>(context, listen: false);
              c.tang();
            },
                child: Text("Tăng")),
            Text("${counter.cout}", style: TextStyle(fontWeight:FontWeight.bold, fontSize: 20),),
            ElevatedButton(onPressed: () {
              var c = context.read<Counter>();
              c.giam();
            },
                child: Text("Giảm")),
          ],
        ),
      ),
    );
  }
}


