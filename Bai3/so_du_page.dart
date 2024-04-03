import 'package:flutter/material.dart';

import 'firebase_data.dart';

class Bai3SoDuPage extends StatefulWidget {
  const Bai3SoDuPage({Key? key}) : super(key: key);

  @override
  _Bai3SoDuPageState createState() => _Bai3SoDuPageState();
}

class _Bai3SoDuPageState extends State<Bai3SoDuPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChiTieuSnapshot>>(
      stream: ChiTieuSnapshot.getThuChiList(),
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
          List<ChiTieuSnapshot> chiTieuSnaps = snapshot.data!;
          int tongThu = 0;
          int tongChi = 0;

          for (int i = 0; i < chiTieuSnaps.length; i++) {
            if (chiTieuSnaps[i].balance!.thuChi!) {
              tongThu += chiTieuSnaps[i].balance!.soTien!;
            }
            else {
              tongChi += chiTieuSnaps[i].balance!.soTien!;
            }
          }
          int tongSoDu = tongThu - tongChi;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.attach_money,
                  color: Colors.green,
                  size: 100,
                ),
                const SizedBox(height: 20,),
                Text(
                  "Tổng thu: $tongThu",
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  "Tổng chi: $tongChi",
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  "Số dư: $tongSoDu",
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.green ,
                  ),
                ),
                // SizedBox(height: 10,),
                const SizedBox(height: 20,),
                const Icon(
                  Icons.attach_money,
                  color: Colors.green,
                  size: 100,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
