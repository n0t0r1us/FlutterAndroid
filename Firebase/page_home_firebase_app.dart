import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:laptrinhdidong/Firebase/firebase_data.dart';
import 'package:laptrinhdidong/Firebase/page_firebase_detail_sv.dart';

import 'diaglog.dart';

class PageSinhViens extends StatefulWidget {
  const PageSinhViens({Key? key}) : super(key: key);

  @override
  State<PageSinhViens> createState() => _PageSinhViensState();
}

class _PageSinhViensState extends State<PageSinhViens> {
  BuildContext? dialogContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Firebase"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context, 
              MaterialPageRoute(builder: (context) => PageSVDetail(xem: false),)
              ), 
              icon: Icon(Icons.add_circle_outline, color: Colors.white,),
          )
        ],
      ),
      body: StreamBuilder<List<SinhVienSnapshot>>(
        stream: SinhVienSnapshot.getAllSinhVien(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print(snapshot.error);
            return Center(
              child: Text("Loi xay ra khi truy van"),
            );
          }else
            if(!snapshot.hasData)
              return Center(
                child: Text("Dang tai du lieu"),
              );
            else{
              print(snapshot.data!.length);
              return
                ListView.separated(
                  itemBuilder: (context, index){
                    dialogContext = context;
                    return Slidable(
                      child: ListTile(
                        leading: Text("${snapshot.data![index].sinhVien!.id}"),
                        title: Text("${snapshot.data![index].sinhVien!.ten}"),
                        subtitle: Text("${snapshot.data![index].sinhVien!.lop}"),
                      ),
                      startActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [],
                      ),
                      endActionPane:ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) => Navigator.push(context,
                                MaterialPageRoute(builder: (context) => PageSVDetail(sinhVienSnapshot: snapshot.data![index],xem: true),)
                            ),
                            icon: Icons.details,
                            foregroundColor: Colors.green,
                          ),
                          SlidableAction(
                            onPressed: (context) => Navigator.push(context,
                                MaterialPageRoute(builder: (context) => PageSVDetail(sinhVienSnapshot: snapshot.data![index],xem: false),)
                            ),
                            icon: Icons.edit,
                            foregroundColor: Colors.blue,
                          ),
                          SlidableAction(
                            onPressed: (context)async {
                              _xoa(dialogContext!, snapshot.data![index]);

                            },
                            icon: Icons.delete_forever,
                            foregroundColor: Colors.red,
                          )
                        ],
                      ) ,
                    );
                  },
                  separatorBuilder: (context,index)=>const Divider(thickness: 1,),
                  itemCount: snapshot.data!.length,
                );
            }
        },
      ),
    );
  }
  void _xoa(BuildContext context,SinhVienSnapshot svs)async{
    String? confirm;
    confirm=await showConfirmDialog(context, "Ban co muon xoa sv:${svs.sinhVien!.ten}?");
    if(confirm=="ok"){
      FirebaseStorage _storage = FirebaseStorage.instance;
      Reference reference = _storage.ref().child("images").child("anh${svs.sinhVien!.id}.jpg");
      reference.delete();
      svs.delete().whenComplete(() => showSnackBar(context,"Xoa du lieu thanh cong",3))
      .onError((error, stackTrace) {
        showSnackBar(context, "Xoa du lieu khong thanh cong", 3);
        return Future.error("Xoa du lieu khong thanh cong");
      });
    }
  }
}
