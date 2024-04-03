import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'Dialog.dart';



class SanPham{
  late String ten;
  late int gia;
  late String url;
  SanPham({required this.ten,required this.gia,required this.url});
}


//ChangeNotifier: Nó có nhiệm vụ thông báo cho người nghe.
//ChangeNotifierProvider: Nó sẽ lắng nghe khi
//ChangeNotifier.notifyListeners được gọi và thông báo tới các hàm build liên quan .
//Consumer: đơn giản nó chỉ là một Widget do thư viện cung cấp . Chúng ta dùng widget này để lấy ra object thay vì phải gọi Provider.of.
class QLSanPham extends ChangeNotifier{
  late List<SanPham> _list =[
    SanPham(ten: "ten1", gia: 12346, url: "url1"),
    SanPham(ten: "ten2", gia: 12346, url: "url2"),
    SanPham(ten: "ten3", gia: 12346, url: "url3"),
  ];

  List<SanPham> get list => _list;

  void xoaSP(int index){
    list.removeAt(index);
    notifyListeners();
  }
  void capnhat(SanPham moi, SanPham cu){
    // cap nhat
    cu.ten=moi.ten;
    cu.gia=moi.gia;
    cu.url=moi.url;
    notifyListeners(); //notifyListeners sẽ thực hiện các công việc cần thiết để cập nhật giao diện
  }
  void themmoi(SanPham sanpham){
    list.add(sanpham);
    notifyListeners();
  }
}
QLSanPham sp = QLSanPham();

class ListSP extends StatelessWidget {
  late BuildContext listViewContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách sản phẩm"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push(
                  context,
                  // MaterialPageRoute(builder: (context)=>AddScreen())
                  MaterialPageRoute(builder: (context)=>Themmoi())
              );
            },
          )
        ],

      ),
      body: Consumer<QLSanPham>(
        builder: (context, sp, child){
          listViewContext = context;
          return ListView.separated(
            itemCount: sp.list.length,
            separatorBuilder: (context, index)=>Divider(thickness: 2,),
            itemBuilder: (context, index)=>Slidable(
              child: ListTile(
                leading: Icon(Icons.add_shopping_cart, color: Colors.blue,),
                title: Text(sp.list[index].ten),
                subtitle: Text(sp.list[index].url),
                trailing: Text(sp.list[index].gia.toString()),
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      String? confirm = await showConfirmDialog(listViewContext, "ban co muon xoa san pham");
                      if(confirm=="ok"){
                        var provider= listViewContext.read<QLSanPham>();
                        provider.xoaSP(index);
                      }
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Xóa',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      Route route = MaterialPageRoute(builder: (context) => Capnhat(sp: sp.list[index],));
                      Navigator.push(context, route);
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.addchart_outlined,
                    label: 'Cập nhật',
                  ),
                  SlidableAction(
                    onPressed:(context) {
                      Route route = MaterialPageRoute(builder: (context) => Xem(sp: sp.list[index],));
                      Navigator.push(context, route);
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.visibility,
                    label: 'Xem',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Themmoi extends StatelessWidget {
  Themmoi({Key? key}) : super(key: key);
  GlobalKey <FormState> formState = GlobalKey<FormState>();
  SanPham m = SanPham(url: '',ten: "", gia: 0);
  TextEditingController txtName=TextEditingController();
  TextEditingController txtSoluong=TextEditingController();
  TextEditingController txtUrl=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formState,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
                  controller: txtName,
                  onSaved: (newValue) => m.ten = newValue!,
                  decoration: InputDecoration(
                    labelText: 'Tên Mặt hàng',
                  )
              ),
              TextFormField(
                  controller: txtSoluong,
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) => m.gia= int.parse(newValue!),
                  decoration: InputDecoration(
                    labelText: 'Giá',
                  )
              ),
              TextFormField(
                  controller: txtUrl,
                  onSaved: (newValue) => m.url = newValue!,
                  decoration: InputDecoration(
                    labelText: 'Url',
                  )
              ),
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
    SanPham m = SanPham(url: txtUrl.text,ten: txtName.text, gia: int.parse(txtSoluong.text));
    context.read<QLSanPham>().themmoi(m);
    Navigator.pop(context);
  }
}

class Xem extends StatelessWidget {
  SanPham? sp;
  Xem({Key? key, this.sp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xem"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Ten:" + sp!.ten),
            Text("Gia:" + sp!.gia.toString()),
            Text("Url:" + sp!.url),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Quay lai"),
            )
          ],
        ),
      ),
    );
  }
}

class Capnhat extends StatelessWidget {
  SanPham? sp;
  Capnhat({Key? key, this.sp}) : super(key: key);
  GlobalKey <FormState> formState = GlobalKey<FormState>();
  // SanPham m = SanPham(url: '',ten: "", gia: 0);
  TextEditingController txtName = TextEditingController();
  TextEditingController txtSoluong=TextEditingController();
  TextEditingController txtUrl=TextEditingController();

  @override
  Widget build(BuildContext context) {
    txtName=TextEditingController(text: sp!.ten);
    txtSoluong=TextEditingController(text: sp!.gia.toString());
    txtUrl=TextEditingController(text: sp!.url);
    return Scaffold(
      appBar: AppBar(
        title: Text("Text"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formState,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
                  controller: txtName,
                  // onSaved: (newValue) => m.ten = newValue!,
                  decoration: InputDecoration(
                    labelText: 'Tên Mặt hàng',
                  )
              ),
              TextFormField(
                  controller: txtSoluong,
                  keyboardType: TextInputType.number,
                  // onSaved: (newValue) => m.gia= int.parse(newValue!),
                  decoration: InputDecoration(
                    labelText: 'Giá',
                  )
              ),
              TextFormField(
                  controller: txtUrl,
                  // onSaved: (newValue) => m.url = newValue!,
                  decoration: InputDecoration(
                    labelText: 'Url',
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      SanPham m = SanPham(url: txtUrl.text,ten: txtName.text, gia: int.parse(txtSoluong.text));
                      context.read<QLSanPham>().capnhat(m,sp!);
                      Navigator.pop(context);
                    },
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
}

