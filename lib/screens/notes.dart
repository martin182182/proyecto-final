//@dart = 2.9
import 'package:flutter/material.dart';
import 'package:chesslib_final/models/game.model.dart';
import 'package:chesslib_final/models/note.model.dart';
import 'package:chesslib_final/screens/addnotes.dart';
import 'package:chesslib_final/screens/detail.dart';
import 'package:chesslib_final/services/note.service.dart';

class Note extends StatefulWidget {
  final game,i,j,fen;
  Note(this.game,this.i,this.j,this.fen);
  @override
  NoteState createState() => NoteState(game,i,j,fen);
}

class NoteState extends State<Note> {
  GameM game;
  int i,j;
  String fen;
  NoteState(this.game,this.i,this.j,this.fen);
  Future<List<NoteM>> _listNotes;
  NoteS service = NoteS();
  @override
  void initState() {
    super.initState();
    _listNotes = service.getNotes(int.parse(game.gameID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Notas',
              style: new TextStyle(backgroundColor: Colors.black)),
          backgroundColor: Colors.black,
        ),
        body: new ListView(children: <Widget>[new FutureBuilder(
          future: _listNotes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                  mainAxisSize:
                      MainAxisSize.max, //Arreglar el scroll y evitar overflow
                  children: _btnNotes(snapshot.data));
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error');
            }
            return Center(
                child: CircularProgressIndicator(color: Colors.black));
          },
        )]),
        floatingActionButton: new FloatingActionButton(child: new Icon(Icons.add_circle),
          backgroundColor: Colors.black,
          onPressed: () {
          Navigator.push(
            context,
          new MaterialPageRoute(
              builder: (context) => new AddNote(game,i,j,fen)));
      }),
      );
  }
  List<Widget> _btnNotes(data) {
      List<Widget> notesList = [];
      for(NoteM note in data){
        notesList.add(new Card(
          child: InkWell(
              onTap: () {
                Navigator.push(
                context,
                new MaterialPageRoute(
                builder: (context) => new Detail(note)));
              },
              splashColor: Colors.blue.withAlpha(30),
              child: new SizedBox(
                  width: MediaQuery.of(context).size.width*1,
                  height: 100,
                  child: Center(child: Text("Jugada: "+note.jugada)),
                ),
              ),
            )
          );
      }
    return notesList;
  }
}
