import 'package:cloud_firestore/cloud_firestore.dart';

class SinhVien{
  String? id,ten,lop,que_quan,nam_sinh,anh;

  SinhVien({required this.id,required this.ten, this.lop, this.que_quan, this.nam_sinh,this.anh});
  
  factory SinhVien.fromJson(Map<String,dynamic> json){
    return SinhVien(
        id:json['id'] as String,
        ten: json['ten'] as String,
        lop: json['que_quan'] as String,
        nam_sinh: json['nam_sinh'] as String,
        que_quan: json['que_quan']as String,
        anh: json['anh']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "id": id,
      "ten":ten,
      "lop":lop,
      "que_quan":que_quan,
      "nam_sinh":nam_sinh,
      "anh": anh
    };
  }
}

class SinhVienSnapshot{
  SinhVien? sinhVien;
  DocumentReference? docRef;

  SinhVienSnapshot({required this.sinhVien,required this.docRef});

  factory SinhVienSnapshot.fromSnapshot(DocumentSnapshot docSnap){
    return SinhVienSnapshot(
        sinhVien: SinhVien.fromJson(docSnap.data() as Map

        <String, dynamic>),
        docRef: docSnap.reference,
    );
  }

  Future<void> capNhat(SinhVien sv)async{
    await docRef!.update(sv.toJson());
  }

  Future<void> delete()async{
    await docRef!.delete();
  }

  static Future<DocumentReference> addNew (SinhVien sv)async {
    return await FirebaseFirestore.instance.collection("SinhVien").add(sv.toJson());
  }

  static Stream<List<SinhVienSnapshot>> getAllSinhVien(){
    Stream<QuerySnapshot> qs = FirebaseFirestore.instance.collection("SinhVien").snapshots();
    Stream<List<DocumentSnapshot>> listDocSnap = qs.map((qsnap) => qsnap.docs);
    return listDocSnap.map((lds) =>
        lds.map((DocSnap) => SinhVienSnapshot.fromSnapshot(DocSnap))
            .toList());
  }
}