//@dart = 2.9
import 'dart:io';
import 'package:chesslib_final/models/game.model.dart';
import 'package:chesslib_final/models/theme.model.dart';
import 'package:chesslib_final/models/tournament.model.dart';
import 'package:chesslib_final/models/user.model.dart';
import 'package:chesslib_final/providers/theme.provider.dart';
import 'package:chesslib_final/screens/game.dart';
import 'package:chesslib_final/screens/localization.dart';
import 'package:chesslib_final/services/game.service.dart';
import 'package:chesslib_final/services/tournament.service.dart';
import 'package:chesslib_final/services/user.service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String imagePath = '';
  Future<List<GameM>> _listGames;
  Future<List<TournamentM>> _listTournaments;
  GameS service = GameS();
  TournamentS tournamentS = TournamentS();
  @override
  void initState() {
    super.initState();
    _listGames = service.getGames();
    _listTournaments = tournamentS.getTournaments();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    UserS userService = UserS();
    User _user;
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _emailController = new TextEditingController();
    TextEditingController _passwordController = new TextEditingController();
    TextEditingController _confirmController = new TextEditingController();
    List<Widget> _options = [
      //Listado de partidas
      new Center(
          child: new ListView(children: <Widget>[
        new Text('\n\nComienza a explorar\n',
            style: new TextStyle(fontSize: 30.0,color: currentTheme.isDarkTheme()?Colors.white:Colors.black), textAlign: TextAlign.center),
        new FutureBuilder(
          future: _listGames,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                  mainAxisSize:
                      MainAxisSize.max, //Arreglar el scroll y evitar overflow
                  children: _btnGames(snapshot.data));
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error');
            }
            return Center(
                child: CircularProgressIndicator(color: Colors.black));
          },
        )
      ])),
      new Form(child: Column(children: <Widget>[
          new Text("\nRegistrate\n", style: TextStyle(fontSize: 32)),
          new TextField(
            controller: _nameController,
            decoration: new InputDecoration(fillColor: Colors.black,hintText: "Nombre",border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black)
                  ),focusColor: Colors.black),
          ),
          new TextField(
            controller: _emailController,
            decoration: new InputDecoration(fillColor: Colors.black,hintText: "Email",border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black)
                  ),focusColor: Colors.black),
          ),

          new TextField(
            controller: _passwordController,
            decoration: new InputDecoration(fillColor: Colors.black,hintText: "Clave",border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black)
                  ),focusColor: Colors.black),
          ),
     
          new TextField(
            controller: _confirmController,
            decoration: new InputDecoration(fillColor: Colors.black,hintText: "Confirmar",border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black)
                  ),focusColor: Colors.black),
          ),
          new Text("\n"),          
          new FloatingActionButton(
            onPressed: (){
              _user = new User(name: _nameController.text, email: _emailController.text, password: _passwordController.text, confirm: _confirmController.text);
              if(_passwordController.text!=_confirmController.text){
                final snackbar = SnackBar(content: const Text("Usuario no registrado."));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }else{
                try{
                  userService.createUser(_user);
                    final snackbar = SnackBar(content: const Text("Usuario registrado."));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);  
                } on Exception catch(_){
                print('Error al guardar');
                } 
              }
            },
            child: new Column(children: <Widget>[
              Icon(Icons.add_circle,size:55,color: currentTheme.isDarkTheme() ? Colors.black:Colors.white),
            ],
          ),
          backgroundColor: currentTheme.isDarkTheme() ? Colors.white:Colors.black),
       ])),
      new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            (imagePath=='')?
            new Center(
              child: new Container(
                margin: const EdgeInsets.only(top: 25),
                child: new Image(
                  width: 70,
                  height: 70,
                  image: NetworkImage(
                    'https://i.pinimg.com/originals/73/de/d1/73ded1b4fd57df52b00739b97bfc5945.png'),
                  ))):
              Center(child: ClipRRect(child: Container(margin: const EdgeInsets.only(top: 25),
              //decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2)),
              child: Image.file(File(imagePath)),width: 70,height: 70))),
              new Row(mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
                IconButton(
                  color: currentTheme.isDarkTheme() ? Colors.white:Colors.black,
                  icon: new Icon(Icons.add_a_photo_rounded),
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    XFile _pickedFile = await _picker.pickImage(source: ImageSource.camera);
                    if(_pickedFile!=null){
                      imagePath = _pickedFile.path;
                    }
                    
                  },
                ),
                IconButton(
                  color: currentTheme.isDarkTheme() ? Colors.white:Colors.black,
                  icon: new Icon(Icons.add_photo_alternate_rounded),
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    XFile _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                    if(_pickedFile!=null){
                      imagePath = _pickedFile.path;
                    }
                  },
                )
              ]),
              new Text('\nNombre de usuario',style: new TextStyle(fontSize: 30.0,color: currentTheme.isDarkTheme()?Colors.white:Colors.black)),
              new Text('Informacion adicional',style: new TextStyle(fontSize: 20.0,color: currentTheme.isDarkTheme()?Colors.white:Colors.black)),
              new MaterialButton(onPressed: (){
                String newTheme = currentTheme.isDarkTheme() ? ThemeM.light : ThemeM.dark;
                currentTheme.setTheme = newTheme;
                },
                color: currentTheme.isDarkTheme()?Colors.white:Colors.black,
                textColor: currentTheme.isDarkTheme()?Colors.black:Colors.white,
                child: Text('Cambia de Tema'),
              )
            ],
          )
      ),
        new Center(
          child: new ListView(children: <Widget>[
        new Text('\nTorneos\n\n',
            style: new TextStyle(fontSize: 30.0,color: currentTheme.isDarkTheme()?Colors.white:Colors.black), textAlign: TextAlign.center),
        new FutureBuilder(
          future: _listTournaments,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                  mainAxisSize:
                      MainAxisSize.max, //Arreglar el scroll y evitar overflow
                  children: _cardTournaments(snapshot.data));
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error');
            }
            return Center(
                child: CircularProgressIndicator(color: Colors.black));
          },
        )
      ])),
    ];
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
        backgroundColor: currentTheme.isDarkTheme() ? Colors.black
        : Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
            title: new Center(
                child:
                    new Text('ChessLib', style: new TextStyle(fontSize: 30.0,color: currentTheme.isDarkTheme()?Colors.black:Colors.white))),
            backgroundColor: currentTheme.isDarkTheme()?Colors.white:Colors.black),
        body: new Center(child: _options[_selectedIndex]),
        bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home), label: 'Inicio'),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.login), label: 'Crear perfil'),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.account_circle), label: 'Perfil'),
            new BottomNavigationBarItem(icon: new Icon(Icons.list), label: 'Torneos')    
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black38,
          iconSize: 35.0,
          unselectedFontSize: 15.0,
          selectedFontSize: 18.0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
//Lista de toneros
List<Widget> _cardTournaments(data){
  List<Widget> tournaments = [];
  for(TournamentM tournament in data){
    tournaments.add(new Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Localization(tournament)));
        },
        child: new SizedBox(
            width: MediaQuery.of(context).size.width*1,
            height: 100,
            child: Center(child: Column(children: <Widget>[
              new Text(tournament.name),
              new Text(tournament.city+"-"+tournament.prize),
              new Text(tournament.description)
              ])),
          ),
        ),
      )
    );
  }
  return tournaments;
}
//Lista de widgets con nombres de la partida
  List<Widget> _btnGames(data) {
    List<Widget> games = [];
    int cont = 0;
    TextStyle txtStyle;
    var color;
    for (GameM game in data) {
      if (cont == 0) {
        color = Colors.white;
        txtStyle = new TextStyle(color: Colors.black);
        cont += 1;
      } else {
        color = Colors.black;
        txtStyle = new TextStyle(color: Colors.white);
        cont = 0;
      }
      games.add(new MaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new Game(game, 0, 0)));
          },
          child: new Text(game.name, style: txtStyle),
          height: 50.0,
          minWidth: 250.0,
          splashColor: Colors.grey,
          color: color));
    }
    return games;
  }
}