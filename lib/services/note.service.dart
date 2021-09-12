import 'package:chesslib_final/models/note.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteS {

  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(),'notes2.db'),
      onCreate: (db, version){
        return db.execute("CREATE TABLE note (idNote INTEGER PRIMARY KEY AutoIncrement, jugada TEXT, descripcion TEXT, fen TEXT, gameID INTEGER)");
      },
      version: 1
    );
  }

  Future<int> createNotes(NoteM note) async{
    Database db = await _openDB();
    return db.insert("note", note.toJson());
  }

  Future<List<NoteM>> getNotes(int id) async{
    Database db = await _openDB();
    final List<Map<String, dynamic>> noteList = await db.query("note",where: "gameID = ?", whereArgs: [id]);
    return List.generate(noteList.length, (i) => NoteM(jugada: noteList[i]["jugada"], descripcion: noteList[i]["descripcion"], fen: noteList[i]["fen"], gameID: id));
  }
}
