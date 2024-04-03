import 'package:flutter/foundation.dart';
import 'package:laptrinhdidong/sqlite/SQLite/SQLite/sqlite_data.dart';

class DatabaseProvider extends ChangeNotifier{
  DatabaseHelper? databaseHelper;
  List<User>? _users;

  DatabaseProvider(){
    databaseHelper=DatabaseHelper();
  }

  List<User>? get users => _users;

  void readUsers() async{
    if(users == null){
      databaseHelper!.open().whenComplete(()  async{
        _users = await databaseHelper!.getUsers()
            .whenComplete(() => notifyListeners());
      });
    }
  }
  Future<int> updateUser(User user, int id) async{
    int count = await databaseHelper!.update(user, id)
        .whenComplete(()  async{
      _users=await databaseHelper!.getUsers()
          .whenComplete(() => notifyListeners());
    });
    return count;
  }
  Future<int> insertUser(User user) async{
    int id=await databaseHelper!.insert(user)
        .whenComplete(() async{
      _users=await databaseHelper!.getUsers()
          .whenComplete(() => notifyListeners());
    });
    return id;
  }
  Future<int>deleteUser(int id) async{
    int count =await databaseHelper!.delete(id)
        .whenComplete(() async{
      _users=await databaseHelper!.getUsers()
          .whenComplete(() => notifyListeners());
    });
    return count;
  }
  void closeDatabase(){
    databaseHelper!.closeDatabase();
  }
}