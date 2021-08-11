import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/AuthorizationPage/bloc/auth/AuthBloc.dart';
import 'package:test_task/AuthorizationPage/bloc/auth/AuthEvent.dart';
import 'package:test_task/AuthorizationPage/bloc/auth/AuthState.dart';
import 'package:test_task/AuthorizationPage/bloc/login/LoginEvent.dart';
import 'package:test_task/AuthorizationPage/bloc/login/LoginState.dart';
import 'package:test_task/AuthorizationPage/services/AuthService.dart';
import 'package:test_task/assets/Constants.dart';
import 'bloc/login/LoginBloc.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMain,
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          // ignore: close_sinks
          final authBloc = BlocProvider.of<AuthenticationBloc>(context);
          if (state is AuthenticationNotAuthenticated) {
            return _AuthForm();
          }
          if (state is AuthenticationFailure) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(state.message),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text('Retry'),
                  onPressed: () {
                    authBloc.add(AppLoaded());
                  },
                )
              ],
            ));
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(colorMain),
            ),
          );
        },
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthenticationService>(context);
    // ignore: close_sinks
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authBloc, authService),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final _passwordController = TextEditingController();
  final _loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      _loginBloc.add(LoginInWithLoginButtonPressed(
          login: _loginController.text, password: _passwordController.text));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          _showError(state.error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorMain)),
            );
          }
          return Container(
            child: Form(
              child: Theme(
                data: ThemeData(
                  fontFamily: 'Roboto',
                  cursorColor: Color(0xFFFFFFFF),
                  hintColor: Color(0xFFFFFFFF),
                  textTheme: TextTheme(
                    bodyText1:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned(
                      top: 135,
                      child: Text(
                        'Авторизация',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 36,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 25, left: 29),
                          child: TextFormField(
                            controller: _loginController,
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFFFFFFF)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFFFFFFF)),
                              ),
                              hintText: 'Логин',
                              hintStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25, left: 29),
                          child: TextFormField(
                            controller: _passwordController,
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFFFFFFFF)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFFFFFFFF)),
                              ),
                              hintText: 'Пароль',
                              hintStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 39,
                      child: Container(
                        width: 262,
                        height: 65,
                        child: RaisedButton(
                          color: Color(0xFF333333),
                          onPressed: state is LoginLoading
                              ? () {}
                              : _onLoginButtonPressed,
                          child: Text(
                            "ВОЙТИ",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 21,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showError(String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }
}
