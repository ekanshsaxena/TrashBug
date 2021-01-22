import 'package:flutter/cupertino.dart';

class User {

  /* More attributes will be added or customised. These are just for sake of testing*/
  static String _email;
  String get email => _email;

  static String _username;
  String get username => _username;

  static String _pass;
  String get pass => _pass;

  static String _name;
  String get name => _name;

  static String _id;
  String get id => _id;

  User({String email, String username, String pass, String name, String id}){
    _email=email;
    _username=username;
    _pass=pass;
    _name=name;
    _id=id;
  }

  set email (String a){
    _email=a;
    //notifyListeners();
  }

  set pass (String a){
    _pass=a;
    //notifyListeners();
  }

  set username (String a){
    _username=a;
    //notifyListeners();
  }

  set name (String a){
    _name=a;
    //notifyListeners();
  }

  set id (String a){
    _id=a;
    //notifyListeners();
  }

}
