//@dart = 2.9
import 'package:flutter/material.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';
class Detail extends StatelessWidget {
  final note;
  Detail(this.note);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Detalles',
              style: new TextStyle(backgroundColor: Colors.black)),
          backgroundColor: Colors.black,
        ),
        body: new Center(child: new Column(children: <Widget>[
          new Text("\n\nJugada: "+note.jugada+"\n"),
          new Text("Descripcion: "+note.descripcion+"\n"),
           new Chessboard(
            fen: note.fen,
            size: MediaQuery.of(context).size.width,
            lightSquareColor: Colors.white,
            darkSquareColor: Colors.black45,
          ),
        ])),
    );
  }
}