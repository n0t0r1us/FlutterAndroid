

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatHang{
  late String tenMH;
  late int gia;
  MatHang({
    required this.tenMH,
    required this.gia
});
}
class Catalog extends ChangeNotifier{
  late List<MatHang> _listmh = [
  MatHang(tenMH: "Xoài", gia: 45000),
  MatHang(tenMH: "Táo", gia: 15000),
  MatHang(tenMH: "Bưởi", gia: 50000),
  MatHang(tenMH: "Cam", gia: 20000),
  MatHang(tenMH: "Sầu riêng", gia: 30000),
  MatHang(tenMH: "Ổi", gia: 15000),
    MatHang(tenMH: "Khế", gia: 15000),
  MatHang(tenMH: "Chôm chôm", gia: 25000),
  MatHang(tenMH: "Cóc", gia: 10000),
  MatHang(tenMH: "Lưu", gia: 35000),
  MatHang(tenMH: "Măng cục", gia: 60000),
  MatHang(tenMH: "Dâu", gia: 50000),
  MatHang(tenMH: "Thanh Long", gia: 51000),
  MatHang(tenMH: "Khổ qua", gia: 60000),
  MatHang(tenMH: "Cà chua", gia: 50000),
  MatHang(tenMH: "Nhãn", gia: 15000),
  MatHang(tenMH: "Mít", gia: 15000),
  MatHang(tenMH: "Đào", gia: 15000),
  ];
  late List<int> _gioHang = [];

  List<MatHang> get listmh => _listmh;
  List<int> get gioHang => gioHang;
  int get sl => _gioHang.length;

  // int get tienThanhToan{
  //   int tong = 0;
  //   for(int i =0; i<listmh.length;i++)
  //   return tong;
  // }
  void themGioHang(int index){
    _gioHang.add(index);
    notifyListeners();
  }
  void xoaGioHang(int index){
    _gioHang.removeAt(index);
    notifyListeners();
  }
  bool kiemTraMH(int index){
    for(int i in _gioHang)
      if(i==index)
        return true;
    return false;
  }
}
