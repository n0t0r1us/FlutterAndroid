import 'package:flutter/material.dart';

class PageMyFile extends StatefulWidget {
  const PageMyFile({Key? key}) : super(key: key);

  @override
  State<PageMyFile> createState() => _PageMyFileState();
}

class _PageMyFileState extends State<PageMyFile> {

  int indexBar=0;
  @override
  Widget build(BuildContext context) {
    String gioiTinh = "nam";
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed:()=>{} , icon: Icon(Icons.share)),
          IconButton(onPressed:()=>{} , icon: Icon(Icons.refresh)),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(accountName:Text("Trần Đức Tín"), accountEmail:Text("tin.td.cntt@ntu.edu.vn"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("asset/image/bu_bu.jpg"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Inbox"),
              trailing: Text("5"),
            ),
            ListTile(
              leading: Icon(Icons.face),
              title: Text("Face"),
              trailing: Text("10"),
            ),
            ListTile(
              leading: Icon(Icons.add_call),
              title: Text("Call"),
              trailing: Text("14"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBar,
        onTap: (value) {
          indexBar = value;
          setState(() {

          });
          switch(value){
            case 0: _showSnackbar(context, "Đã mở Inbox"); break;
            case 1: _showSnackbar(context, "Đã mở Contact"); break;
            case 2: _showSnackbar(context, " Đã mở Calender"); break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Inbox"),
          BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: "Contact"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Calendar"),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text("THÔNG TIN CÁC NHÂN", style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.black87),)),
              Container(
                child: Image.asset("asset/image/bu_bu.jpg"),
              ),
              SizedBox(height: 20,),
              Text("Họ và tên:"),
              Text("Trần Đức Tín", style: TextStyle(fontSize: 20, color: Colors.blue[900], fontWeight: FontWeight.bold)),
              SizedBox(height: 15,),
              Text("Ngày sinh:"),
              Text("14/12/2001",style: TextStyle(fontSize: 20),),
              SizedBox(height: 15,),
              Text("Giới tính:"),
              Row(
                children: [
                  Expanded( flex: 1,
                    child: ListTile(
                      leading: Radio(
                        value: "Nam",
                        groupValue: "Nam",
                        onChanged: (value) {
                          setState(() {
                            gioiTinh = value as String;
                          });
                        },
                      ),
                      title: Text("Nam"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:ListTile(
                      leading: Radio(
                        value: "Nữ",
                        groupValue: "Nam",
                        onChanged: (value) {
                          setState(() {
                            gioiTinh = value as String;
                          });
                        },
                      ),
                      title: Text("Nữ"),
                    ),
                  ),
                ],
              ),
              Text("Quê quán:"),
              Text("Diên khánh, Khánh Hoà", style: TextStyle(fontSize: 20),),
              SizedBox(height: 15,),
              Text("Sở thích:"),
              Text("Xem phim, nghe nhạc, chơi thể thao", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic )),
            ],
          ),
        ),
      ),
    );
  }
  void _showSnackbar(BuildContext context, String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),
        duration: Duration(seconds: 10),
    backgroundColor: Colors.blue[800]
      ),
    );
  }
}
