import 'package:flutter/material.dart';

class User {
  final String login;
  final String pass;

  User({@required this.login, @required this.pass});

  @override
  String toString() => 'User { login: $login, pass: $pass}';
}