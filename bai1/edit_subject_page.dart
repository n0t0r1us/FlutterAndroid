import 'package:flutter/material.dart';
import 'package:untitled4/Thi/bai%201/data.dart';

class EditSubject extends StatefulWidget {
  MonHocSnapShot? monHocSnapShot;
  EditSubject({Key? key, this.monHocSnapShot}) : super(key: key);

  @override
  _EditSubjectState createState() => _EditSubjectState();
}

class _EditSubjectState extends State<EditSubject> {
  MonHocSnapShot? mhs;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtTC = TextEditingController();
  TextEditingController txtType = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin môn học"),
      ),
      body: Form(
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
                controller: txtTC,
                decoration: InputDecoration(
                  labelText: ("Số tính chỉ:"),
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: txtType,
                decoration: InputDecoration(
                  labelText: ("Loại môn học:"),
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
                        sotc: txtTC.text,
                        type: txtType.text,
                      );
                      if(mhs!= null)
                        await mhs!.sua(mh);
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
    mhs = widget.monHocSnapShot;
    if(mhs != null){
      txtName.text = mhs!.mh!.name?? "";
      txtTC.text = mhs!.mh!.sotc?? "";
      txtType.text = mhs!.mh!.type?? "";
    }
  }
}