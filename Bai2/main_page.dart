import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:untitled4/dialogs.dart';

import 'detail_page.dart';
import 'firebase_data.dart';

class Bai2MainPage extends StatefulWidget {
  const Bai2MainPage({Key? key}) : super(key: key);

  @override
  _Ex2MainPageState createState() => _Ex2MainPageState();
}

class _Ex2MainPageState extends State<Bai2MainPage> {
  BuildContext? dialogContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bài 2"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Ex2DetailPage(
                  readOnly: false,
                ),
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<List<FruitSnapshot>>(
        stream: FruitSnapshot.getFruitList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Lỗi truy vấn!"),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("Đang tải dữ liệu..."),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                dialogContext = context;
                return Slidable(
                  child: ListTile(
                    leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 55,
                            width: 55,
                            child: ((snapshot.data![index].fruit!.imgPath == "") || (snapshot.data![index].fruit!.imgPath == null)) ?
                            const Icon(Icons.camera_alt_outlined) :
                            Image.network(
                              snapshot.data![index].fruit!.imgPath!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ]
                    ),
                    title: Text(
                      "${snapshot.data![index].fruit!.ten}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${snapshot.data![index].fruit!.moTa}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: Text(
                      "${snapshot.data![index].fruit!.gia}/kg",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  startActionPane: null,
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ex2DetailPage(
                              fruitSnapshot: snapshot.data![index],
                              readOnly: true,
                            ),
                          ),
                        ),
                        icon: Icons.notes,
                        foregroundColor: Colors.blue,
                      ),
                      SlidableAction(
                        onPressed: (context) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ex2DetailPage(
                              fruitSnapshot: snapshot.data![index],
                              readOnly: false,
                            ),
                          ),
                        ),
                        icon: Icons.edit,
                        foregroundColor: Colors.green,
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          _remove(dialogContext!, snapshot.data![index]);
                        },
                        icon: Icons.delete,
                        foregroundColor: Colors.red,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                thickness: 2,
              ),
              itemCount: snapshot.data!.length,
            );
          }
        },
      ),
    );
  }

  void _remove(BuildContext buildContext, FruitSnapshot fruitSnapshot) async {
    String? confirmation;
    confirmation = await showConfirmDialog(
        context,
        "Bạn có chắc muốn xóa mặt hàng: ${fruitSnapshot.fruit!.ten}?"
    );
    if (confirmation == "ok") {
      FirebaseStorage _storage = FirebaseStorage.instance;
      Reference reference = _storage.ref().child("images").child(
          "${fruitSnapshot.fruit!.id}.png");
      reference.delete();
      fruitSnapshot.removeFruit().whenComplete(() =>
          showSnackBar(context, "Xóa thành công!", 3))
          .onError((error, stackTrace) {
        showSnackBar(context, "Không thể xóa!", 3);
        return Future.error("Không thể xóa!");
      });
    }
  }
}

