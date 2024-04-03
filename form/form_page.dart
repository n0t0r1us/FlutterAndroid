
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'form_model.dart';

class PageFormDienThoai extends StatelessWidget {
  PageFormDienThoai({Key? key}) : super(key: key);

  GlobalKey <FormState> formState = GlobalKey<FormState>();
  MatHang m = MatHang();
  TextEditingController txtName=TextEditingController();
  TextEditingController txtSoluong=TextEditingController();
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formState,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: txtName,
                  onSaved: (newValue) => m.name = newValue,
                  validator: (value) => validatorString(value),
                  decoration: InputDecoration(
                    labelText: 'Tên Mặt hàng',
                  )
              ),
              DropdownButtonFormField<String>(
                items: loaiMHs.map((loaiMH) => DropdownMenuItem<String>(
                  child: Text("${loaiMH}"),
                  value: loaiMH,
                ))
                    .toList(),
                validator: (value) => validatorString(value),
                value: dropdownValue,
                decoration: InputDecoration(
                  labelText: "Loại mặt hàng",
                ),
                onChanged:(value) => dropdownValue = value,
                onSaved: (newValue) => m.loaiMH = newValue,
              ),
              TextFormField(
                  controller: txtSoluong,
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) => m.soluong= int.parse(newValue!),
                  validator: (value) => validatesoluong(value),
                  decoration: InputDecoration(
                    labelText: 'Số lượng',
                  )
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => _save(context),
                    child: Text("Save"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _save(BuildContext context) {
    if (formState.currentState!.validate()){
      formState.currentState!.save();
      hienthiDialog(context);
    }
  }

  validatorString(String? value) {
    return value==null || value.isEmpty ? "Bạn chưa nhập dữ liệu" : null;

  }

  validatesoluong(String? value) {
    if(value == null || value.isEmpty) return "Bạn chưa nhập số lượng";
    else return int.parse(value)<0? "Số lượng không được phép bé hơn 0" : null;
  }

  void hienthiDialog(BuildContext context) {
    var dialog= AlertDialog(
      title: Text("Thông báo "),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Bạn đã nhập mặt hàng: "),
          Text("Tên mặt hàng: ${m.name}"),
          Text("Loai mặt hàng: ${m.loaiMH}"),
          Text("Số lượng: ${m.soluong}"),
        ],
      ),
      actions: [
        ElevatedButton(
          child: Text("OK"),
          onPressed:(){
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog( context: context, builder:(context)=> dialog );
  }
}