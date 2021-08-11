import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInWithLoginButtonPressed extends LoginEvent {
  final String login;
  final String password;

  LoginInWithLoginButtonPressed({@required this.login, @required this.password});

  @override
  List<Object> get props => [login, password];
}