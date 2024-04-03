import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laptrinhdidong/jsonphoto/Photo.dart';

class PhotoList extends StatelessWidget {
  List<Photo>? photos;
  PhotoList({Key? key, this.photos}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 400, padding: EdgeInsets.all((5)),mainAxisSpacing: 5, crossAxisSpacing: 5,
      children: List.generate(photos!.length, (index) => Container(decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
      ),
        child: Text("que huong toi ap u truong son laf day nuoc chay xuoi nguon dem trang xao tieng ho af oi loi me tru tre tho giac ngu hien ngoan vaf trai gia qua gui li chan tinh que huong toi ta toi hkoi lua dieu tang thon xom lang ho oi huong giang oi gia tu kinh thanh mong mo long tuio xxnh chia tay nhau biets trto ve mo day phuong nam lua canh ta suc tra dem cahs tay vay vungf ngay mai nguoi di dem tranf cao tieng ho tienh hof ien trung cho nhau nghe nhuwng loi thowr thang giong ngoif tiengs vui tieng sbuon gnuowc tuoi hon tuoi don"),
        //Image.network(photos![index].thumbnailUrl),
      )
      ),
    );
  }
}