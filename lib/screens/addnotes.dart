import 'package:flutter/material.dart';
import 'package:chesslib_final/models/game.model.dart';
import 'package:chesslib_final/models/note.model.dart';
import 'package:chesslib_final/services/note.service.dart';
class AddNote extends StatefulWidget {
  final game,i,j,fen;
  AddNote(this.game,this.i,this.j,this.fen);
  @override
  _AddNoteState createState() => _AddNoteState(game,i,j,fen);
}

class _AddNoteState extends State<AddNote> {
  int i,j;
  GameM game;
  String fen;
  late NoteM _note;
  NoteS service = new NoteS();
  Future<dynamic>? note;
  TextEditingController _controller = new TextEditingController();
  _AddNoteState(this.game,this.i,this.j,this.fen);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: new Text('Agregar Nota',
              style: new TextStyle(backgroundColor: Colors.black)),
          backgroundColor: Colors.black,
        ),
      body: new Center(
        child: new Column(mainAxisSize:MainAxisSize.max,
        children: <Widget>[
          new Text("\nNotas para jugada: "+ (i+1).toString()+" "+game.name+"\n"),
          new TextField(
            controller: _controller,
            decoration: new InputDecoration(hintText: "Detalles",border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black))),
          )
        ],),
      ),
      floatingActionButton: new FloatingActionButton(onPressed: (){
        _note = new NoteM(jugada: (i+1).toString(), descripcion: _controller.text, fen: fen, gameID: int.parse(game.gameID));
        try{
          note = service.createNotes(_note);
          Navigator.pop(context);
          setState(() {});
        } on Exception catch(_){
          print('Error al guardar');
          }  
      },
      child: new Icon(Icons.add_circle),
      backgroundColor: Colors.black),
    );
  }
}