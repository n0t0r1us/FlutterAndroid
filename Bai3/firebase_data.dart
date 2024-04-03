import 'package:cloud_firestore/cloud_firestore.dart';

class ChiTieu {
  int? soTien;
  bool? thuChi;
  String? lyDo;
  DateTime? ngay;

  ChiTieu({
    this.soTien,
    this.thuChi,
    this.lyDo,
    this.ngay,
  });

  Map<String, dynamic> toJson() {
    return {
      'soTien': this.soTien,
      'thuChi': this.thuChi,
      'lyDo': this.lyDo,
      'ngay': this.ngay,
    };
  }

  factory ChiTieu.fromJson(Map<String, dynamic> map) {
    return ChiTieu(
      soTien: map['soTien'] as int,
      thuChi: map['thuChi'] as bool,
      lyDo: map['lyDo'] as String,
      ngay: (map['ngay'] as Timestamp).toDate(),
    );
  }
}

class ChiTieuSnapshot {
  ChiTieu? balance;
  DocumentReference? documentReference;

  ChiTieuSnapshot({
    required this.balance,
    required this.documentReference,
  });

  factory ChiTieuSnapshot.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ChiTieuSnapshot(
      balance: ChiTieu.fromJson(documentSnapshot.data() as Map<String, dynamic>),
      documentReference: documentSnapshot.reference,
    );
  }

  static Future<DocumentReference> addThuChi(ChiTieu soDu) async {
    return FirebaseFirestore.instance.collection("ChiTieu").add(soDu.toJson());
  }

  Future<void> updateThuChi(ChiTieu soDu) async {
    return documentReference!.update(soDu.toJson());
  }

  Future<void> removeThuChi() async {
    return documentReference!.delete();
  }

  static Stream<List<ChiTieuSnapshot>> getThuChiList() {
    Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance.collection("ChiTieu").orderBy("ngay", descending: true).snapshots();
    Stream<List<DocumentSnapshot>> docSnapList = querySnapshot.map((querySnap) => querySnap.docs);

    return docSnapList.map((docSnList) => docSnList.map((docSnap) => ChiTieuSnapshot.fromSnapshot(docSnap)).toList());
  }

  static Stream<List<ChiTieuSnapshot>> getThuList() {
    Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance.collection("ChiTieu").where("thuChi", isEqualTo: true).snapshots();
    Stream<List<DocumentSnapshot>> docSnapList = querySnapshot.map((querySnap) => querySnap.docs);

    return docSnapList.map((docSnList) => docSnList.map((docSnap) => ChiTieuSnapshot.fromSnapshot(docSnap)).toList());
  }

  static Stream<List<ChiTieuSnapshot>> getChiList() {
    Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance.collection("ChiTieu").where("thuChi", isEqualTo: false).snapshots();
    Stream<List<DocumentSnapshot>> docSnapList = querySnapshot.map((querySnap) => querySnap.docs);

    return docSnapList.map((docSnList) => docSnList.map((docSnap) => ChiTieuSnapshot.fromSnapshot(docSnap)).toList());
  }
}