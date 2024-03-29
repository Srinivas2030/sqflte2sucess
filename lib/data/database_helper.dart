import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:core';

import '../models/user.dart';


class Databasehelper{
  static final Databasehelper _instance =  Databasehelper.internal();
  factory  Databasehelper()=> _instance;
  static Database ?_db;
  Future<Database?>get db async{

    if(_db !=null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  Databasehelper.internal();

  initDb()async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    

    String path = join(documentDirectory.path, "main.db");
    var ourDb =await openDatabase(path,version:1,
    onCreate:_onCreate);
    return ourDb;
  }
  void _onCreate(Database db, int version) async {

    await db.execute("create Tabe User(id integer primary key, username txt ,password,text)");
    print("table is created");
  }
//insertion
  Future <int> saveUser(User user)async{
    var dbClient = await db;
    int res  = await  dbClient!.insert( "User",user.toMap());
    return res;

  }
//deletion
  Future <int> deleteUser(User user)async{
    var dbClient = await db;
    int res  = await  dbClient!.delete( "User");
    return res;

  }

}