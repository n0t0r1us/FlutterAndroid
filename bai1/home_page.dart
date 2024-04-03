import 'package:flutter/material.dart';
import 'add_subject_page.dart';
import 'data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'edit_subject_page.dart';
import 'mark_page.dart';



class HomePage extends StatefulWidget {
  MonHocSnapShot? monHocSnapShot;
  HomePage({Key? key, this.monHocSnapShot}) : super(key: key);



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Môn học"),
            actions: [
              IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddSJ(),)
                  ),
                  icon: Icon(Icons.add_circle, color: Colors.white,)
              )
            ]
        ),
        body: StreamBuilder<List<MonHocSnapShot>>(
            stream: MonHocSnapShot.listMHFirebase(),
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
                            leading: Builder(
                              builder: (BuildContext context){
                                return IconButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MarkPage(),),);},
                                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                                    icon: Icon(Icons.view_headline)
                                );
                              },
                            ),
                            title: Text("${snapshot.data![index].mh!.name}", style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold), ),
                            subtitle: Text("Số tính chỉ:${snapshot.data![index].mh!.sotc}"),

                          ),
                          startActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) =>
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          EditSubject(
                                          )),
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
                                          EditSubject(monHocSnapShot: snapshot.data![index])),
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
                        )
                );
            }
        )
    );
  }
}
_xoa(BuildContext context, MonHocSnapShot mhs) async{
  AlertDialog dialog = AlertDialog(
    title: Text("Cảnh báo xóa"),
    content: Text("Bạn có chắc muốn xóa MH ${mhs.mh!.name} không?"),
    actions: [
      ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel")
      ),
      ElevatedButton(
        onPressed: () async{
          await mhs.xoa();
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
}

