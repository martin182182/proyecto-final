import 'dart:convert';
import 'package:chesslib_final/models/user.model.dart';
import 'package:http/http.dart' as http;

class UserS{
  Future<dynamic> createUser(User user) async {

    final Map<String, String> _headers = {"content-type": "application/json"};
    final res = await http.post(Uri.parse("https://user182.herokuapp.com/save"), headers: _headers, body: userToJson(user));
    if(res.body.isEmpty) return null;
    if(res.statusCode==200){
      return json.decode(res.body);
    }else{
      return null;
    }
  }

  Future<dynamic> login(dynamic user) async{
    final Map<String, String> _headers = {"content-type": "application/json"};
    final res = await http.post(Uri.parse("https://user182.herokuapp.com/login"), headers: _headers, body: userToJson(user));
    if(res.body.isEmpty) return null;
    if(res.statusCode==200){
      return json.decode(res.body);
    }else{
      return null;
    }   
  }
}