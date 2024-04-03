import 'package:sqflite/sqflite.dart';

const String tableName = "Users";
class User{
  int? id;
  String? name, phone, email;

  User({ this.id, required this.name, this.phone,this.email});

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson()=>{
    'id':id,
    'name':name,
    'phone': phone,
    'email': email,
  };
}
class DatabaseHelper{
  Database? database;
  String? _path;
  Future<String?> _getDatabasePath(String databaseName) async{
    String p=await getDatabasesPath();
    String _path="$p/$databaseName";
    this._path=_path;
    return _path;
  }

  Future<Database?> open() async{
    String? _path=await _getDatabasePath('demo.db');
    database = await openDatabase(
      _path!,
      version: 1,
      onCreate: (db,version) async{
        db.execute(
            'CREATE TABLE $tableName (id INTERGER PRIMARY KEY, name TEXT, phone TEXT, email TEXT)');
      },
    );
    return database;
  }

  Future<int> insert(User user) async{
    int id=await database!.transaction(
            (Transaction txn) async {
          int id=await txn.rawInsert(
            'INSERT INTO $tableName(name,phone,email) VALUES( ?, ?, ?)' ,
            [user.name,user.phone,user.email],
          );
          return id;
        }
    );
    return id;
  }

  Future<int>update(User newUser, int id) async{
    int count= await database!.transaction((Transaction txn) async{
      int count = await txn.rawUpdate(
          'UPDATE $tableName SET name= ?, phone= ?, email= ?, WHERE id = ?',
          [newUser.name,newUser.phone,newUser.email,id]
      );
      return count;
    });
    return count;
  }

  Future <int> delete(int id) async{
    int count =await database!.rawDelete(
      "DELETE FROM $tableName WHERE id = ?",
      [id],
    );
    return count;
  }

  Future<List<User>> getUsers() async{
    List<Map> list =await database!.rawQuery("SELECT * FROM $tableName");
    return list.map((userJson) => User.fromJson(userJson as Map<String,dynamic>)).toList();
  }
  
  void closeDatabase() async{
    await database!.close();
  }

  void deleteDB(){
    deleteDatabase(_path!);
  }
}