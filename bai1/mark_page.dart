import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:untitled4/Thi/bai%201/data1.dart';


import 'edit_mark_page.dart';

class MarkPage extends StatefulWidget {
  DanhSachSnapShot? danhSachSnapShot;
  MarkPage({Key? key, this.danhSachSnapShot}) : super(key: key);

  @override
  _MarkPageState createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  DanhSachSnapShot? dhs;
  String buttonLabel = "Thêm";
  String title = "Điểm môn học";
  TextEditingController txtDS = TextEditingController();
  TextEditingController txtDiem = TextEditingController();
  TextEditingController txtHS = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //var data = context.watch<ItemProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
        body: StreamBuilder<List<DanhSachSnapShot>>(
            stream: DanhSachSnapShot.listDSFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Text("Lỗi sảy ra khi truy vấn dữ liệu"),
                );
              else if (!snapshot.hasData)
                return Center(
                  child: Text("Đang tải dữ liệu..."),
                );
              else
                return ListView.separated(
                    separatorBuilder: (context, index) => Divider(thickness: 2,),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) =>
                        Slidable(
                          child: ListTile(
                            leading: Image.network("${snapshot.data![index].ds!.name}",),
                            title: Text("${snapshot.data![index].ds!.name}", style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold), ),
                            subtitle:
                                      Text("Điểm:${snapshot.data![index].ds!.diem}\nHệ số:${snapshot.data![index].ds!.heso}"),
                          ),
                          startActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) =>
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          EditMark()),
                                    ),
                                label: "Xem",
                                icon: Icons.remove_red_eye_outlined,
                                backgroundColor: Colors.green,
                              ),
                              SlidableAction(
                                onPressed: (context) =>
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          EditMark(danhSachSnapShot: snapshot.data![index])),
                                    ),
                                icon: Icons.edit,
                                label: "Sửa",
                                backgroundColor: Colors.grey,
                              ),
                              SlidableAction(
                                onPressed: (context) => _xoa(context, snapshot.data![index]),
                                icon: Icons.delete_forever,
                                label: "Xóa",
                                backgroundColor: Colors.red,
                              ),
                            ],
                          ),
                ));
            }
        ));
  }
  _xoa(BuildContext context, DanhSachSnapShot dhs) async{
    AlertDialog dialog = AlertDialog(
      title: Text("Cảnh báo xóa"),
      content: Text("Bạn có chắc muốn xóa MH ${dhs.ds!.name} không?"),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel")
        ),
        ElevatedButton(
          onPressed: () async{
            await dhs.xoa();
            Navigator.pop(context);
          },
          child: Text("Yes"),
        )
      ],
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
}}