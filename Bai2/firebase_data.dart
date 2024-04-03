import 'package:cloud_firestore/cloud_firestore.dart';

class TraiCay {
  String? id, ten;
  int? soLuong, gia;
  String? xuatXu, moTa, imgPath;

  TraiCay({
    required this.id,
    this.ten,
    this.soLuong,
    this.gia,
    this.xuatXu,
    this.moTa,
    this.imgPath,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ten': this.ten,
      'soLuong': this.soLuong,
      'gia': this.gia,
      'xuatXu': this.xuatXu,
      'moTa': this.moTa,
      'imgPath': this.imgPath,
    };
  }

  factory TraiCay.fromJson(Map<String, dynamic> map) {
    return TraiCay(
      id: map['id'] as String,
      ten: map['ten'] as String,
      soLuong: map['soLuong'] as int,
      gia: map['gia'] as int,
      xuatXu: map['xuatXu'] as String,
      moTa: map['moTa'] as String,
      imgPath: map['imgPath'] as String,
    );
  }
}

class FruitSnapshot {
  TraiCay? fruit;
  DocumentReference? documentReference;

  FruitSnapshot({
    required this.fruit,
    required this.documentReference,
  });

  factory FruitSnapshot.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return FruitSnapshot(
      fruit: TraiCay.fromJson(documentSnapshot.data() as Map<String, dynamic>),
      documentReference: documentSnapshot.reference,
    );
  }

  static Future<DocumentReference> addFruit(TraiCay fruit) async {
    return FirebaseFirestore.instance.collection("TraiCay").add(fruit.toJson());
  }

  Future<void> updateFruit(TraiCay fruit) async {
    return documentReference!.update(fruit.toJson());
  }

  Future<void> removeFruit() async {
    return documentReference!.delete();
  }

  static Stream<List<FruitSnapshot>> getFruitList() {
    Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance.collection("TraiCay").snapshots();
    Stream<List<DocumentSnapshot>> docSnapList = querySnapshot.map((querySnap) => querySnap.docs);

    return docSnapList.map((docSnList) => docSnList.map((docSnap) => FruitSnapshot.fromSnapshot(docSnap)).toList());
  }
}