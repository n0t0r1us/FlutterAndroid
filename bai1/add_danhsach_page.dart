import 'package:flutter/material.dart';
import 'data.dart';

class AddDS extends StatefulWidget {
  MonHocSnapShot? monHocSnapShot;
  AddDS({Key? key, this.monHocSnapShot}) : super(key: key);

  @override
  _AddDSState createState() => _AddDSState();
}

class _AddDSState extends State<AddDS> {
  static final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String?  tp, pd;
  int nb = 0;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtHS = TextEditingController();
  TextEditingController txtDiem = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm"),
      ),
      body: Form(
        key: _formState,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: txtName,
                decoration: InputDecoration(
                  labelText: ("Tên bài kiểm tra:"),
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtHS,
                decoration: InputDecoration(
                  labelText: ("Số hệ số:"),
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                //controller: txtSL,
                controller: txtDiem,
                decoration: InputDecoration(
                  labelText: ("Điểm:"),
                ),
                keyboardType: TextInputType.number,
              ),


              //StreamBuilder<List<MatHangSnapShot>>(
              // stream:MatHangSnapShot.listMHFirebase(),
              //builder: (context, snapshot) {
              // if (!snapshot.hasData)
              //  return Center(
              //   child: Text("Đang tải dữ liệu..."),
              //);
              //},
              //),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async{
                      MonHoc mh = MonHoc(
                        name: txtName.text,
                        sotc: txtHS.text,
                        type: txtDiem.text,
                      );
                      await MonHocSnapShot.them(mh);
                      Navigator.pop(context);
                    },
                    child: Text("add"),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: () =>  Navigator.pop(context),
                    child: Text("cancel"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  valideString(String? value) {
    return value == null || value.isEmpty ? "Ban chua nhap du lieu" : null;
  }

  validateSoluong(String? value) {
    if(value == null || value.isEmpty)
      return "Ban chua nhap so luong";
    else
      return int.parse(value)<0 ? "So luong khong duoc < 0" : null;
  }

}