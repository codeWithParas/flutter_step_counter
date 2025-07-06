

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'NoteAppScreen.dart';

class SqfliteDatabaseHelper {

  // Singleton type object
  static SqfliteDatabaseHelper? _databaseHelper = null;
  static Database? _database;

  // Column Names
  String tableName = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDesc = 'description';
  String colDate = 'date';

  SqfliteDatabaseHelper._createInstance();

  factory SqfliteDatabaseHelper() {
    if(_databaseHelper == null) {
      _databaseHelper = SqfliteDatabaseHelper._createInstance();
    }
    return _databaseHelper ?? SqfliteDatabaseHelper._createInstance();
  }

  Future<Database?> get database async {
    if(_database == null) {
      _database = await initializeDatabase();
    }
    print("@@@ Database Initialization Done");
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'note.db';

    Database noteDatabase = await openDatabase(path, version:1, onCreate: _createDb);
    _database = noteDatabase;
    return noteDatabase;
  }

  void _createDb(Database db, int version) async{
    print("@@@ Database Creation Done");
    await db.execute(
      'CREATE TABLE $tableName('
          '$colId INTEGER PRIMARY KEY AUTOINCREMENT,'
          '$colTitle TEXT,'
          '$colDesc TEXT,'
          '$colDate TEXT'
          ')'
    );
  }

  Future<int?> insertNote(Note note) async{
    print("@@@ Database Insertion Done");
    var db = await this.database;
    var map = note.objectToMapConversion();
    int? result = await db?.insert(tableName, map);
    return result ?? 0;
  }

  deleteNote(int? id) async {
    var db = await this.database;
    int? result = await db?.rawDelete('DELETE FROM $tableName WHERE $colId = $id');
    return result;
  }

  Future<List<Map<String, dynamic>>?> getNoteMapList() async {
    var db = await this.database;
    print("@@@ Database Fetching Done");
    return await db?.query(tableName);
  }

  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    var count = noteMapList?.length ?? 0;

    List<Note> noteList = [];

    for(int i = 0; i<count; i++) {
      var mappedObj = noteMapList![i];
      var noteObject = Note.mapToObjectConversion(mappedObj);
      noteList.add(noteObject);
    }
    return noteList;
  }

  void updateNote(int id, title, desc){
    // HomeWork
  }










}