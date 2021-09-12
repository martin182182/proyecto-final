//@dart = 2.9
import 'package:flutter/material.dart';
import 'package:chesslib_final/screens/notes.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';
import 'package:chesslib_final/utils.dart';

//Correr con --no-sound-null-safety
class Game extends StatefulWidget {
  final game, i, j;
  Game(this.game, this.i, this.j);
  @override
  _GameState createState() => _GameState(game, i, j);
}

class _GameState extends State<Game> {
  dynamic game;
  int i = 0, j = 0;
  String fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';
  _GameState(this.game,this.i, this.j);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: new Center(
                child: new Text('Partida '+game.gameID,
                    style: TextStyle(fontSize: 30.0))),
            backgroundColor: Colors.black),
        body: new Center(
            child: new Column(children: <Widget>[
          new Text('\n\n' + game.name, style: TextStyle(fontSize: 24.0)),
          new Text(game.date, style: TextStyle(fontSize: 24.0)),
          new Chessboard(
          fen: fen,
          size: MediaQuery.of(context).size.width,
          lightSquareColor: Colors.white,
          darkSquareColor: Colors.black45,
          ),
          new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Align(
                    alignment: Alignment.bottomRight,
                    child: new Column(children: <Widget>[
                      new IconButton(
                          iconSize: 48.0,
                          onPressed: () {},
                          icon: Icon(Icons.arrow_back)),
                      new Text('Retroceder')
                    ])),
                new Align(
                    alignment: Alignment.bottomCenter,
                    child: new Column(children: <Widget>[
                      new IconButton(
                          iconSize: 48.0,
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new Note(game,i,j,fen)));
                          },
                          icon: Icon(Icons.add_circle_outline)),
                      new Text('Notas')
                    ])),
                new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Column(children: <Widget>[
                      new IconButton(
                          iconSize: 48.0,
                          onPressed: () {
                            Future.delayed(Duration(milliseconds: 300)).then((_) {
                            setState(() {
                                if(j<2){
                                  final nextFen = makeMove(fen, game.game[i][j]);
                                  fen = nextFen;
                                  j+=1;
                                } else{
                                  i+=1;
                                  j=0;
                                  final nextFen = makeMove(fen, game.game[i][j]);
                                  fen = nextFen;
                                  j+=1;
                                }
                            });
                          });
                          },
                          icon: Icon(Icons.arrow_forward)),
                      new Text('Avanzar')
                    ])),
              ])
        ])));
  }
}
