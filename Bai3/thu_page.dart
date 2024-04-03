import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:test1/helpers/dialogs.dart';
import 'detail_page.dart';
import 'firebase_data.dart';

class Bai3ThuPage extends StatefulWidget {
  const Bai3ThuPage({Key? key}) : super(key: key);

  @override
  _Bai3ThuPageState createState() => _Bai3ThuPageState();
}

class _Bai3ThuPageState extends State<Bai3ThuPage> {
  BuildContext? dialogContext;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChiTieuSnapshot>>(
      stream: ChiTieuSnapshot.getThuList(),
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
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              dialogContext = context;
              return Slidable(
                child: ListTile(
                  tileColor: Colors.greenAccent[100],
                  leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat("dd/MM/yyyy").format(snapshot.data![index].balance!.ngay!),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                  ),
                  title: Text(
                    "${snapshot.data![index].balance!.soTien}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${snapshot.data![index].balance!.lyDo}",
                    style: const TextStyle(
                      fontSize: 16,
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
                          builder: (context) => Bai3DetailPage(
                            balanceSnapshot: snapshot.data![index],
                            readOnly: true,
                          ),
                        ),
                      ),
                      icon: Icons.notes,
                      backgroundColor: Colors.blue[100]!,
                      foregroundColor: Colors.blue,
                    ),
                    SlidableAction(
                      onPressed: (context) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Bai3DetailPage(
                            balanceSnapshot: snapshot.data![index],
                            readOnly: false,
                          ),
                        ),
                      ),
                      icon: Icons.edit,
                      backgroundColor: Colors.green[100]!,
                      foregroundColor: Colors.green,
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        _remove(dialogContext!, snapshot.data![index]);
                      },
                      icon: Icons.delete,
                      backgroundColor: Colors.red[100]!,
                      foregroundColor: Colors.red,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
            itemCount: snapshot.data!.length,
          );
        }
      },
    );
  }

  void _remove(BuildContext buildContext, ChiTieuSnapshot balanceSnapshot) async {
    String? confirmation;
    confirmation = await showConfirmDialog(
        context,
        "Bạn có chắc muốn xóa lịch sử chi tiêu này?"
    );
    if (confirmation == "ok") {
      balanceSnapshot.removeThuChi().whenComplete(() =>
          showSnackBar(context, "Xóa thành công!", 3))
          .onError((error, stackTrace) {
        showSnackBar(context, "Không thể xóa!", 3);
        return Future.error("Không thể xóa!");
      });
    }
  }
}