import 'package:crud_29/todo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseProvider {
  static Database? database;
  var databaseName = "todoDatabase.db";
  DatabaseProvider() {
    createDatabase();
  }

  Future<Database> createDatabase() async {
    // if (database == null) {
    if (kIsWeb) {
      var databaseFactory = databaseFactoryFfiWeb;
      database = await databaseFactory.openDatabase(databaseName,
          options: OpenDatabaseOptions(
              version: 1,
              onCreate: (db, int version) async {
                db.execute(
                    "CREATE TABLE TODO(id PRIMARY KEY AUTOINCREMENT INTEGER, title TEXT, description TEXT)");
              }));
    } else {
      var path = join(await getDatabasesPath(), databaseName);
      //database = await openDatabase(path, version:1, oncreate:(db,version)){}................can also do like this for database
      database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          db.execute(
              "CREATE TABLE TODO(id PRIMARY KEY AUTOINCREMENT INTEGER, title TEXT, description TEXT)");
        },
      );
      //}
    }
    return Future.value(database);
  }

  void insertTodo(TodoModel todoModel) async {
    var database = await createDatabase();
    database.insert("todO", todoModel.toJson());
    print("data base insert");
  }

  Future<List<TodoModel>> getList() async {
    var database = await createDatabase();
    final List<Map<String, dynamic>> maps = await database.query('TODO');
    return List.generate(maps.length, (i) {
      return TodoModel(id: maps[i]['id'], title: maps[i]['title']);
    });
  }

  void updateTodo(TodoModel todoModel, int id) async {
    var database = await createDatabase();
    database.update("todo", todoModel.toJson(), where: "id=?", whereArgs: [id]);
  }

  void removeTodo(TodoModel todoModel) async {
    var database = await createDatabase();
    database.delete("todo", where: "id=?", whereArgs: [todoModel.id]);
  }
}
