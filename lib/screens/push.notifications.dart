import 'package:firebase_messaging/firebase_messaging.dart';

class PushProvider{
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  initNotifications(){
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.data);
    });
  }
}