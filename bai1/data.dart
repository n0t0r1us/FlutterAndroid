import 'package:cloud_firestore/cloud_firestore.dart';
List<String> type = ["Tivi", "Tủ lạnh", "Điện thoại", "Laptop"];
List<String> producer = ["Samsung", "Sony", "LG", "Dell"];
class MonHoc{
  String? name, sotc, pic, type;
  MonHoc({
    required this.name,
    this.sotc,
    this.pic,
    this.type
  });

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'sotc': this.sotc,
      'pic': this.pic,
      'type': this.type
    };
  }

  factory MonHoc.fromJson(Map<String, dynamic> map) {
    return MonHoc(
      name: map['name'] as String,
      sotc: map['sotc'] as String,
      pic: map['pic'] as String,
      type: map['type'] as String,
    );
  }
}
class MonHocSnapShot{
  MonHoc? mh;
  DocumentReference? documentReference;

  MonHocSnapShot({
    required this.mh,
    required this.documentReference
  });

  factory MonHocSnapShot.fromSnapShot(DocumentSnapshot docSnap){
    return MonHocSnapShot(
      mh: MonHoc.fromJson(docSnap.data() as Map<String, dynamic>),
      documentReference: docSnap.reference,
    );
  }

  sua(MonHoc mh) async{
    await documentReference!.update(mh.toJson());
  }

  xoa() async{
    await documentReference!.delete();
  }

  static them(MonHoc mh) async{
    await FirebaseFirestore.instance.collection("MonHoc").add(mh.toJson());
  }
  static Stream<List<MonHocSnapShot>> listMHFirebase(){
    Stream<QuerySnapshot> qs = FirebaseFirestore.instance.collection("MonHoc").snapshots();
    Stream<List<DocumentSnapshot>> listDocSnap = qs.map((querySn) => querySn.docs);
    return listDocSnap.map((listDocSnaps) =>
        listDocSnaps.map((docSnap) =>
            MonHocSnapShot.fromSnapShot(docSnap)).toList());
  }
}


