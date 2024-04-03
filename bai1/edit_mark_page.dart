import 'package:flutter/material.dart';
import 'package:untitled4/Thi/bai%201/data1.dart';

class EditMark extends StatefulWidget {
  DanhSachSnapShot? danhSachSnapShot;
  EditMark({Key? key, this.danhSachSnapShot}) : super(key: key);

  @override
  _EditMarkState createState() => _EditMarkState();
}

class _EditMarkState extends State<EditMark> {
  DanhSachSnapShot? dhs;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtHS = TextEditingController();
  TextEditingController txtDiem = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật điểm"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
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
                      DanhSach ds = DanhSach(
                        name: txtName.text,
                        diem:  txtDiem.text,
                        heso: txtHS.text,
                      );
                      if(dhs!= null)
                      await dhs!.sua(ds);
                      Navigator.pop(context);
                    },
                    child: Text("cập nhật"),
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
  @override
  void initState(){
    super.initState();
    dhs = widget.danhSachSnapShot;
    if(dhs != null){
      txtName.text = dhs!.ds!.name?? "";
      txtDiem.text = dhs!.ds!.diem?? "";
      txtHS.text = dhs!.ds!.heso?? "";
    }
  }
}