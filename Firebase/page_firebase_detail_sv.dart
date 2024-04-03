import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laptrinhdidong/Firebase/diaglog.dart';
import 'firebase_data.dart';
class PageSVDetail extends StatefulWidget {
  SinhVienSnapshot? sinhVienSnapshot;
  bool? xem;

  PageSVDetail({Key? key, this.sinhVienSnapshot,required this.xem}) : super(key: key);

  @override
  _PageSVDetailState createState() => _PageSVDetailState();
}

class _PageSVDetailState extends State<PageSVDetail> {
  bool _imageChange = false;
  XFile? _xImage;

  SinhVienSnapshot? svs;
  bool? xem;
  String buttonLable = "Them";
  String title = "Them sinh vien moi";
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtLop = TextEditingController();
  TextEditingController txtNamSinh = TextEditingController();
  TextEditingController txtQueQuan = TextEditingController();


  @override
  void initState() {
    super.initState();
    svs = widget.sinhVienSnapshot;
    xem = widget.xem;
    if(svs!= null){
      txtId.text=svs!.sinhVien!.id ?? "";
      txtTen.text=svs!.sinhVien!.ten ?? "";
      txtLop.text=svs!.sinhVien!.lop ?? "";
      txtQueQuan.text=svs!.sinhVien!.que_quan ?? "";
      txtNamSinh.text=svs!.sinhVien!.nam_sinh ?? "";
      if(xem! == true){
        title="Thong tin sinh vien";
        buttonLable="Dong";
      }
      else{
        title="Cap nhat thong tin sinh vien";
        buttonLable="Cap nhat";
      }
    }
  }


  @override
  void dispose() {
    super.dispose();
    txtId.dispose();
    txtTen.dispose();
    txtLop.dispose();
    txtNamSinh.dispose();
    txtQueQuan.dispose();
  }

  _chonAnh(BuildContext context)async{
    _xImage=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(_xImage!=null){
      setState(() {
        _imageChange = true;
      },);
    }
  }

  _capNhat(BuildContext context) async{
    showSnackBar(context, "Dang cap nhat du lieu", 300);
    SinhVien sv = SinhVien(
      id: txtId.text,
      ten: txtTen.text,
      lop: txtLop.text,
      nam_sinh: txtNamSinh.text,
      que_quan: txtQueQuan.text,
      anh: null,
    );
    if(_imageChange){
      FirebaseStorage _store = FirebaseStorage.instance;
      Reference reference = _store.ref().child("images").child("anh_${sv.id}.jpg");
      UploadTask uploadTask = await _uploadTask(reference,_xImage!);
      uploadTask.whenComplete(() async{
        sv.anh = await reference.getDownloadURL();
        if(svs!=null)
          _capNhatSV(svs,sv);
        else
          _themSV(sv);
      }).onError((error, stackTrace) {
        return Future.error("Loi xay ra");
      });
    }
    else
      if(svs!=null){
        sv.anh=svs!.sinhVien!.anh;
        _capNhatSV(svs, sv);
      }else
        _themSV(sv);
  }


  _capNhatSV(SinhVienSnapshot? svs,SinhVien sv){
    svs!.capNhat(sv).whenComplete(() =>
        showSnackBar(context,"Cap nhat du lieu thanh cong",3))
        .onError((error, stackTrace) => showSnackBar(context,"Cap nhat du lieu khong thanh cong",3));
  }

  Future<UploadTask> _uploadTask(Reference reference, XFile xImage)async{
    final metadata= SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path':xImage.path}
    );
    UploadTask uploadTask;
    if(kIsWeb)
      uploadTask = reference.putData(await xImage.readAsBytes(),metadata);
    else
      uploadTask = reference.putFile(File(xImage.path),metadata);
    return Future.value(uploadTask);
  }

  _themSV(SinhVien sv){
    SinhVienSnapshot.addNew(sv).whenComplete(() =>
    showSnackBar(context,"Them du lieu thanh cong",3))
        .onError((error, stackTrace){
          showSnackBar(context, "Them du lieu khong thanh cong", 3);
          return Future.error("Loi khi them");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: _imageChange ? Image.file(File(_xImage!.path)):
                    svs?.sinhVien!.anh != null ? Image.network(svs!.sinhVien!.anh!) : null,
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 20,),
                  ElevatedButton(
                      onPressed: xem!=true ? ()=>_chonAnh(context): null,
                      child: const Icon(Icons.image),
                  )
                ],
              ),
              TextField(
                controller: txtId,
                decoration: InputDecoration(
                  label: Text("Id:"),
                ),
                keyboardType: TextInputType.text,
              ),TextField(
                controller: txtTen,
                decoration: InputDecoration(
                  label: Text("Ten:"),
                ),
                keyboardType: TextInputType.text,
              ),TextField(
                controller: txtLop,
                decoration: InputDecoration(
                  label: Text("Lop:"),
                ),
                keyboardType: TextInputType.text,
              ),TextField(
                controller: txtNamSinh,
                decoration: InputDecoration(
                  label: Text("NamSinh:"),
                ),
                keyboardType: TextInputType.number,
              ),TextField(
                controller: txtQueQuan,
                decoration: InputDecoration(
                  label: Text("QueQuan:"),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: ()async {
                        if(xem == true){
                          Navigator.pop(context);
                        }else{
                          _capNhat(context);
                        }
                      },
                      child: Text(buttonLable)
                  ),
                  SizedBox(width: 10,),
                  xem == true ? SizedBox(width: 1,):
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Huy"),
                  ),
                  SizedBox(width: 10,),
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}
