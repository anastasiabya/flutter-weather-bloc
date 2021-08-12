import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/AuthorizationPage/AuthorizationScreen.dart';
import 'package:test_task/AuthorizationPage/bloc/auth/AuthBloc.dart';
import 'package:test_task/AuthorizationPage/bloc/auth/AuthEvent.dart';
import 'package:test_task/HomePage/HomeScreen.dart';
import 'package:test_task/resources/UserSession.dart';
import 'AuthorizationPage/bloc/auth/AuthState.dart';
import 'AuthorizationPage/services/AuthService.dart';
import 'resources/UserSession.dart';
export 'resources/UserSession.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  session = getLoggedIn();

  runApp(RepositoryProvider<AuthenticationService>(
      create: (context) {
        return FakeAuthenticationService();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) {
              final authService =
              RepositoryProvider.of<AuthenticationService>(context);
              return AuthenticationBloc(authService)..add(AppLoaded());
            },
          ),
        ],
        child: MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<Object>(
          future: session,
          builder: (context, snapshot) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationAuthenticated) {
                  saveLogin();
                  return HomePage();
                } else if (snapshot.data == true) {
                  return HomePage();
                } else {
                  return AuthPage();
                }
              },
            );
          }),
    );
  }

}


