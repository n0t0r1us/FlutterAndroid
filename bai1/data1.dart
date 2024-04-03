import 'package:cloud_firestore/cloud_firestore.dart';

class DanhSach{
  String? name, diem, heso;
  DanhSach({
    required this.name,
    this.diem,
    this.heso,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'diem': this.diem,
      'heso': this.heso,
    };
  }

  factory DanhSach.fromJson(Map<String, dynamic> map) {
    return DanhSach(
      name: map['name'] as String,
      diem: map['diem'] as String,
      heso: map['heso'] as String,
    );
  }
}
class DanhSachSnapShot{
  DanhSach? ds;
  DocumentReference? documentReference;

  DanhSachSnapShot({
    required this.ds,
    required this.documentReference
  });

  factory DanhSachSnapShot.fromSnapShot(DocumentSnapshot docSnap){
    return DanhSachSnapShot(
      ds: DanhSach.fromJson(docSnap.data() as Map<String, dynamic>),
      documentReference: docSnap.reference,
    );
  }

  sua(DanhSach ds) async{
    await documentReference!.update(ds.toJson());
  }

  xoa() async{
    await documentReference!.delete();
  }

  static them(DanhSach ds) async{
    await FirebaseFirestore.instance.collection("DanhSach").add(ds.toJson());
  }
  static Stream<List<DanhSachSnapShot>> listDSFirebase(){
    Stream<QuerySnapshot> qs = FirebaseFirestore.instance.collection("DanhSach").snapshots();
    Stream<List<DocumentSnapshot>> listDocSnap = qs.map((querySn) => querySn.docs);
    return listDocSnap.map((listDocSnaps) =>
        listDocSnaps.map((docSnap) =>
            DanhSachSnapShot.fromSnapShot(docSnap)).toList());
  }
}


