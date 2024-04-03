
class Sinhvien{
  String Id, ten;
  String? ngaySinh, queQuan;
  Sinhvien({required this.Id, required this.ten, this.ngaySinh, this.queQuan});

  @override
  String toString() {
    return 'Id: $Id\n ten: $ten\n ngaySinh: $ngaySinh\n queQuan: $queQuan';
  }
}
class QlySinhVien{
  List<Sinhvien> _list = [];
  // properties
  List<Sinhvien> get ds => _list;

  void add(Sinhvien sv){
    for(var s in _list){
      if(s.Id == sv.Id)
        return;
    }
    _list.add(sv);
  }
  void update(Sinhvien newsv) {
    for (var s in _list) {
      if (s.Id == newsv.Id) {
        s.ten = newsv.ten;
        s.queQuan = newsv.queQuan;
        s.ngaySinh = newsv.ngaySinh;
      }
    }
  }

  void delete(String Id){
    for(var s in _list) {
      if(s.Id==Id){
        _list.remove(s);
        return;
      }
    }
  }

  void Info(){
    for(var s in _list){
      print(s.toString());
    }
  }
}

void main (){
  QlySinhVien qlySinhVien = QlySinhVien();
  qlySinhVien.add(Sinhvien(Id: "01", ten: "Tin", ngaySinh: "14/12/2001", queQuan: "Khanh Hoa"));
  qlySinhVien.add(Sinhvien(Id: "02", ten: "Nhu", ngaySinh: "20/01/2004",queQuan: "Phu Yen"));
  qlySinhVien.add(Sinhvien(Id: "03", ten: "Dat", ngaySinh: "20/01/2001",queQuan: "Phu Yen"));
  qlySinhVien.Info();
  print("Danh sách mới");
  qlySinhVien.delete("03");
  qlySinhVien.Info();
}