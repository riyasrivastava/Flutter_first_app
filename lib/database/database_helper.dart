import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:first_application/User.dart';

class DatabaseHelper{
  /*static late DatabaseHelper _databaseHelper;
  static late Database _database;*/

  String userTable = 'user_table';
  String colId = 'id';
  String colTitle = 'title';
  String colCompleted = 'completed';

  /*DatabaseHelper._createInstance();*/

  Future<Database> initializedDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path+'user.db';
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE $userTable ($colId INTEGER, $colTitle TEXT, $colCompleted BOOL)');
      },
    );
  }
  /*Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path+'user.db';

    var userDatabase = await openDatabase(path,version: 1,onCreate: _createDb);
    return userDatabase;
  }*/

  /*factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }*/

  /*Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return database;
  }*/

  
  /*void _createDb(Database db,int newVersion) async{
    await db.execute('CREATE TABLE $userTable ($colId INTEGER, $colTitle TEXT, $colCompleted BOOLEAN)');
  }*/

  //Fetch operation
  Future<List<Map<String,dynamic>>> getUserMapList(int idToSearch) async {
    final Database db = await await initializedDB();
    var result = await db.rawQuery('SELECT * FROM $userTable WHERE id=?', [idToSearch]);
    return result;
  }

  Future<List<User>> getUserList(int idToSearch) async{
    var userMapList = await getUserMapList(idToSearch);
    int count = userMapList.length;

    List<User> userList = <User>[];

    for(int i=0 ; i<count ;i++){
      userList.add(User.fromMapObject(userMapList[i]));
    }

    return userList;
  }

  Future<int> insertUser(List<User> users) async {
    final Database db = await initializedDB();
    int result = 0;
    for (var user in users) {
       result = await db.insert(userTable, user.toMap());
    }

    return result;
  }
}