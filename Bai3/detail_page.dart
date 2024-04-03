import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test1/helpers/dialogs.dart';

import 'firebase_data.dart';

class Bai3DetailPage extends StatefulWidget {
  ChiTieuSnapshot? balanceSnapshot;
  bool? readOnly;

  Bai3DetailPage({Key? key, this.balanceSnapshot, required this.readOnly}) : super(key: key);

  @override
  _Bai3DetailPageState createState() => _Bai3DetailPageState();
}

class _Bai3DetailPageState extends State<Bai3DetailPage> {
  ChiTieuSnapshot? balSnapshot;
  bool? readOnly;
  String btnLabel = "Thêm mới";
  String title = "Thêm mới chi tiêu";
  bool incomeCheck = false;
  DateTime datePicked = DateTime.now();

  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtTime = TextEditingController();
  TextEditingController txtReason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                readOnly: readOnly!,
                controller: txtAmount,
                decoration: const InputDecoration(
                    label: Text("Số tiền: ",)
                ),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  const Text("Thu nhập (tick vào ô): "),
                  Checkbox(
                    value: incomeCheck,
                    onChanged: readOnly! ? null : (value) {
                      setState(() {
                        incomeCheck = value!;
                      });
                    },
                  ),
                ],
              ),
              TextField(
                readOnly: true,
                controller: txtTime,
                decoration: InputDecoration(
                  label: const Text("Ngày: ",),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.date_range),
                    onPressed: readOnly! ? null : () {
                      showDatePicker(
                        context: context,
                        //initialDate: balSnapshot!.balance!.ngay != null ? balSnapshot!.balance!.ngay! : DateTime.now(),
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1800),
                        lastDate: DateTime(2300),
                      ).then((value) => {
                        setState(() {
                          txtTime.text = DateFormat("dd/MM/yyyy").format(value!);
                          datePicked = value;
                        })
                      });
                    },
                  ),
                ),
              ),
              TextField(
                readOnly: readOnly!,
                controller: txtReason,
                decoration: const InputDecoration(
                    label: Text("Lý do: ",)
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
    balSnapshot = widget.balanceSnapshot;
    readOnly = widget.readOnly;

    if (balSnapshot != null) {
      txtAmount.text = (balSnapshot!.balance!.soTien?? 0).toString();
      incomeCheck = balSnapshot!.balance!.thuChi?? false;
      txtTime.text = DateFormat("dd/MM/yyyy").format(balSnapshot!.balance!.ngay?? DateTime.now());
      txtReason.text = balSnapshot!.balance!.lyDo?? "";

      if (readOnly!) {
        title = "Chi tiết";
        btnLabel = "Quay về";
      }
      else {
        title = "Chỉnh sửa";
        btnLabel = "Lưu";
      }
    }
  }

  _update(BuildContext context) async {
    showSnackBar(context, "Đang lưu thông tin...", 3);
    ChiTieu balance = ChiTieu(
      soTien: int.parse(txtAmount.text),
      thuChi: incomeCheck,
      ngay: datePicked,
      lyDo: txtReason.text,
    );

    if (balSnapshot != null) {
      _updateBalance(balSnapshot, balance);
    } else {
      _addBalance(balance);
    }
    // Navigator.pop(context);
  }

  _addBalance(ChiTieu balance) {
    ChiTieuSnapshot.addThuChi(balance).whenComplete(() =>
        showSnackBar(context, "Thêm mới thành công!", 3))
        .onError((error, stackTrace) {
      showSnackBar(context, "Không thể thêm mới!", 3);
      return Future.error("Lỗi xảy ra trong quá trình thêm mới!");
    });
  }

  _updateBalance(ChiTieuSnapshot? balSnapshot, ChiTieu balance) {
    balSnapshot!.updateThuChi(balance).whenComplete(() =>
        showSnackBar(context, "Chỉnh sửa thành công", 3))
        .onError((error, stackTrace) =>
        showSnackBar(context, "Không thể chỉnh sửa!", 3)
    );
  }
}
