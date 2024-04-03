
import 'package:flutter/material.dart';

class Fruit{
  late String ten;
  late int gia;
  late String url;

  Fruit(this.ten, this.gia, this.url);

}
Fruit f1 = Fruit("Mận", 15000, "https://upload.wikimedia.org/wikipedia/commons/6/6c/Plums.jpg");
Fruit f2 = Fruit("Xoài", 20000, "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Mango_Maya.jpg/1024px-Mango_Maya.jpg");
Fruit f3 = Fruit("Chuối", 15150, "https://photo-cms-plo.zadn.vn/w800/Uploaded/2022/cqjwqcdwp/2017_03_25/10-chuoi_bojg.jpg");
Fruit f4 = Fruit("Thơm", 2000, "https://i1-suckhoe.vnecdn.net/2021/04/07/an-thom-giam-beo-1354-1617798614.jpg?w=1020&h=0&q=100&dpr=1&fit=crop&s=7Cyd0oYbzQoAeQuKeZZK2g");
Fruit f5 = Fruit("Bơ", 50000, "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Avocado_Hass_-_single_and_halved.jpg/1024px-Avocado_Hass_-_single_and_halved.jpg");
Fruit f6 = Fruit("Vải", 50000, "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Litchi_chinensis_fruits.JPG/1024px-Litchi_chinensis_fruits.JPG");
Fruit f7 = Fruit("Me", 50000, "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Tamarind2.jpg/1024px-Tamarind2.jpg");
Fruit f8 = Fruit("Muối ớt", 2000, "https://afamilycdn.com/Images/Uploaded/Share/2011/03/31/110401afamilyAN-muoi-ot-an-dan-1.JPG");
Fruit f9 = Fruit("Nho", 50000, "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Sauvignon_blanc_vlasotince_vineyards.jpg/450px-Sauvignon_blanc_vlasotince_vineyards.jpg");

List<Fruit> listSP = [f1,f2,f3,f4,f5,f6,f7,f8,f9];

class Grid extends StatefulWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giải cú nông sản'),
      ),
      body:GridView.extent(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right:5),
          maxCrossAxisExtent: 250,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
          children: listSP.map((sp) => Card(
            elevation: 1,
            shadowColor: Colors.blue,
            child: Column(
              children: [
                Image.network(sp.url),
                Text(sp.ten),
                Text("Giá: ${sp.gia}/kg",
                  style: const TextStyle(color: Colors.red),),
              ],
            ),
          )).toList()
      ),
    );
  }
}
