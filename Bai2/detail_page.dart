import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled4/dialogs.dart';

import 'firebase_data.dart';

class Ex2DetailPage extends StatefulWidget {
  FruitSnapshot? fruitSnapshot;
  bool? readOnly;

  Ex2DetailPage({Key? key, this.fruitSnapshot, required this.readOnly}) : super(key: key);

  @override
  _Ex2DetailPageState createState() => _Ex2DetailPageState();
}

class _Ex2DetailPageState extends State<Ex2DetailPage> {
  FruitSnapshot? fruSnapshot;
  bool? readOnly;
  String btnLabel = "Thêm";
  String title = "Thêm sản phẩm";
  bool _imgChange = false;
  XFile? _xImage;

  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtSoLuong = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtXuatXu = TextEditingController();
  TextEditingController txtMoTa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết sản phẩm"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: _imgChange ? Image.file(File(_xImage!.path)) :
                ((fruSnapshot?.fruit!.imgPath == "") || (fruSnapshot?.fruit!.imgPath == null)) ?
                const Icon(Icons.camera_alt_outlined) :
                Image.network(
                  fruSnapshot!.fruit!.imgPath!,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: readOnly != true ? () => _selectImg(context) : null,
                    child: const Icon(Icons.image),
                  )
                ],
              ),
              TextField(
                readOnly: readOnly!,
                controller: txtId,
                decoration: const InputDecoration(
                    label: Text("ID mặt hàng: ",)
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                readOnly: readOnly!,
                controller: txtTen,
                decoration: const InputDecoration(
                    label: Text("Tên mặt hàng: ",)
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                readOnly: readOnly!,
                controller: txtSoLuong,
                decoration: InputDecoration(
                  label: const Text("Số lượng: ",),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (!readOnly!) {
                        setState(() {
                          int soLuong = int.parse(txtSoLuong.text);
                          if (soLuong > 0) {
                            soLuong--;
                          }
                          txtSoLuong.text = soLuong.toString();
                        });
                      }
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (!readOnly!) {
                        setState(() {
                          int soLuong = int.parse(txtSoLuong.text);
                          soLuong++;
                          txtSoLuong.text = soLuong.toString();
                        });
                      }
                    },
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                readOnly: readOnly!,
                controller: txtGia,
                decoration: const InputDecoration(
                    label: Text("Giá tiền: ",)
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                readOnly: readOnly!,
                controller: txtXuatXu,
                decoration: const InputDecoration(
                    label: Text("Xuất xứ: ",)
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                readOnly: readOnly!,
                controller: txtMoTa,
                decoration: const InputDecoration(
                    label: Text("Mô tả mặt hàng: ",)
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (readOnly!) {
                        Navigator.pop(context);
                      } else {
                        _update(context);
                      }
                    },
                    child: Text(btnLabel),
                  ),
                  const SizedBox(width: 10,),
                  readOnly == true ?
                  const SizedBox(width: 0,) :
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Hủy bỏ"),
                  ),
                  const SizedBox(width: 10,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fruSnapshot = widget.fruitSnapshot;
    readOnly = widget.readOnly;

    if (fruSnapshot != null) {
      txtId.text = fruSnapshot!.fruit!.id?? "";
      txtTen.text = fruSnapshot!.fruit!.ten?? "";
      txtSoLuong.text = fruSnapshot!.fruit!.soLuong.toString();
      txtGia.text = fruSnapshot!.fruit!.gia.toString();
      txtXuatXu.text = fruSnapshot!.fruit!.xuatXu?? "";
      txtMoTa.text = fruSnapshot!.fruit!.moTa?? "";

      if (readOnly!) {
        title = "Chi tiết mặt hàng";
        btnLabel = "Quay lại";
      }
      else {
        title = "Chỉnh sửa mặt hàng";
        btnLabel = "Lưu";
      }
    }
  }

  _selectImg(BuildContext context) async {
    _xImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_xImage != null) {
      setState(() {
        _imgChange = true;
      });
    }
  }

  _update(BuildContext context) async {
    showSnackBar(context, "Đang cập nhật thông tin mặt hàng...", 300);
    TraiCay fruit = TraiCay(
      id: txtId.text.toUpperCase(),
      ten: txtTen.text,
      soLuong: int.parse(txtSoLuong.text),
      gia: int.parse(txtGia.text),
      xuatXu: txtXuatXu.text,
      moTa: txtMoTa.text,
      imgPath: null,
    );
    if (_imgChange) {
      FirebaseStorage _storage = FirebaseStorage.instance;
      Reference reference = _storage.ref().child("images").child("${fruit.id}.png");

      UploadTask uploadTask = await _uploadTask(reference, _xImage!);
      uploadTask.whenComplete(() async {
        fruit.imgPath = await reference.getDownloadURL();
        if (fruSnapshot != null) {
          _updateFruit(fruSnapshot, fruit);
        } else {
          _addFruit(fruit);
        }
      }).onError((error, stackTrace) {
        return Future.error("Có lỗi xảy ra!");
      });
    }
    else if (fruSnapshot != null) {
      fruit.imgPath = fruSnapshot!.fruit!.imgPath;
      _updateFruit(fruSnapshot, fruit);
    } else {
      _addFruit(fruit);
    }
    // Navigator.pop(context);
  }

  Future<UploadTask> _uploadTask(Reference reference, XFile xImage) async {
    final metadata = SettableMetadata(
        contentType: 'image/png',
        customMetadata: {'picked-file-path': xImage.path}
    );
    UploadTask uploadTask;
    if (kIsWeb) {
      uploadTask = reference.putData(await xImage.readAsBytes(), metadata);
    } else {
      uploadTask = reference.putFile(File(xImage.path), metadata);
    }
    return Future.value(uploadTask);
  }

  _addFruit(TraiCay fruit) {
    FruitSnapshot.addFruit(fruit).whenComplete(() =>
        showSnackBar(context, "Thêm thành công!", 3))
        .onError((error, stackTrace) {
      showSnackBar(context, "Không thể thêm mới!", 3);
      return Future.error("Không thể thêm mới!");
    });
  }

  _updateFruit(FruitSnapshot? fruSnapshot, TraiCay fruit) {
    fruSnapshot!.updateFruit(fruit).whenComplete(() =>
        showSnackBar(context, "Chỉnh sửa thành công", 3))
        .onError((error, stackTrace) =>
        showSnackBar(context, "Không thể chỉnh sửa!", 3)
    );
  }
}