
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ws_tb/note_app/SqfliteDatabaseHelper.dart';

class NoteAppScreen extends StatefulWidget {
  const NoteAppScreen({super.key});

  @override
  State<NoteAppScreen> createState() => _NoteAppScreenState();
}

class _NoteAppScreenState extends State<NoteAppScreen> {

  // Custom List
  List<Note> noteList = [];
  var dbHelper = SqfliteDatabaseHelper();

  void updateNoteListData() {
    Future<List<Note>> noteListFuture = dbHelper.getNoteList();
    noteListFuture.then((noteListData) {
      if(noteListData.isNotEmpty) {
        // Update UI
        setState(() {
          noteList = noteListData;
        });
      }
    });
  }

  void insertOperation(Note note){
    Future<int?> result = dbHelper.insertNote(note);
    result.then((value) {
      if(value != 0){
        print("@@@ DATA INSERTED SUCCESSFULLY");
        updateNoteListData();
      }
    });
  }

  void deleteOperation(int position){
    Future<int?> result = dbHelper.deleteNote(position);
    result.then((value) {
      if(value != 0){
        print("@@@ DATA DELETED SUCCESSFULLY");
        updateNoteListData();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateNoteListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note App"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            // Add Elements in note list
            var itemPos = noteList.length+1;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Item Added ${itemPos}"))
            );

            var newNote = Note("$itemPos", "_description", "_date");
            insertOperation(newNote);
          }),
      body: ListView.builder(
          itemCount: noteList.length,
          itemBuilder: (BuildContext context, int position){
            return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple,
                    ),
                    title: Text(noteList[position]._title),
                    subtitle: Text(noteList[position]._description),
                    trailing: GestureDetector(
                      child: Icon(Icons.delete),
                      onTap: (){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Item Deleted ${noteList[position]._title}"))
                        );
                        deleteOperation(position);
                      },
                    ),
                    onTap: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Item Selected ${noteList[position]._title}"))
                      );
                    },
                  ),
                )
            );
          }
      ),
    );
  }
}

class Note {

  String _title = "";
  String _description = "";
  String _date = "";

  // Constructor
  Note(this._title, this._description, this._date);

  Map<String, dynamic> objectToMapConversion() {
    var map  = Map<String, dynamic>();
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;

    return map;
  }

  Note.mapToObjectConversion(Map<String, dynamic> map) {
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
  }

}