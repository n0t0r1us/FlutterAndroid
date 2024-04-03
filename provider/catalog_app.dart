import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dtin62cntt/provider/catalog.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class AppCatalog extends StatelessWidget {
  const AppCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Catalog(),
      lazy: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PageCatalog(),
      ),
    );
  }
}


class PageCatalog extends StatelessWidget {
  const PageCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog"),
        actions: [
          Consumer<Catalog>(builder: (context, catalog, child) => badges.Badge(
        showBadge: true,
        badgeContent:
          Icon(Icons.check, color: Colors.white, size: 10),
          child: IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.shopping_cart),
          ),
            position: badges.BadgePosition.topEnd(),
      ),
          )],
      ),
      body: Consumer<Catalog>(
        builder: (context, value, child) => Container(
          child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                leading: Text(value.listmh[index].tenMH),
                title: Text(value.listmh[index].gia.toString()),
              ),
              separatorBuilder: (context, index)=>Divider(thickness: 2,),
              itemCount: value.listmh.length),
        ),
      ),
    );
  }
}
//
//
// class GioHang extends StatelessWidget {
//   MatHang? matHang;
//   GioHang({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Giỏ hàng"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//         ],
//       ),
//     );
//   }
// }


