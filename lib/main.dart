//@dart = 2.9
import 'package:chesslib_final/providers/theme.provider.dart';
import 'package:chesslib_final/screens/home.dart';
import 'package:chesslib_final/screens/push.notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = new ThemeProvider();

  @override
  void initState(){
    super.initState();
    getCurrentTheme();
  }

  void getCurrentTheme() async {
    themeChangeProvider.setTheme = await themeChangeProvider.themePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp() ,
      builder: (context, snapshot){
      if(snapshot.hasError){
        return Text("Error");
      }
      if (snapshot.connectionState == ConnectionState.done) {
            final pushProvider = new PushProvider();
            pushProvider.initNotifications();
          return ChangeNotifierProvider.value(
            value: themeChangeProvider,
            child: MaterialApp(
              title: 'ChessLib',
              home: Home(),
            ),
          );
      }
       return CircularProgressIndicator(color: Colors.black);
    });
  }
}

//Token: fjajIErzSMW56kS0z2iU8w:APA91bFrcw_AXDN4zwcu0DpJoMxj4MrLrSATHPdMJKLpnBcvHjeNPzq2qfW5Ntm9HYDyrDSPy_X8HEXeAedBnEOg8jpCUhqv_2t0iVMgI3abJJQiakeIQkMMOjkltDcJWWa51wgof1KV
