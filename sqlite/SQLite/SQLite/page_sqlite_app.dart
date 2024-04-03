import 'package:flutter/material.dart';
import 'package:laptrinhdidong/sqlite/SQLite/SQLite/provider_data.dart';
import 'package:provider/provider.dart';
import 'page_home_sqlite.dart';

class SQLiteApp extends StatefulWidget {
  const SQLiteApp({ Key? key }) : super(key: key);

  @override
  _SQLiteAppState createState() => _SQLiteAppState();
}

class _SQLiteAppState extends State<SQLiteApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context){
        var databaseProvider = DatabaseProvider();
        databaseProvider.readUsers();
        return databaseProvider;
      },
      child: MaterialApp(
        title: "SQLite Demo App",
        home: PageListUserSQLite(),
      ),
    );
  }
}