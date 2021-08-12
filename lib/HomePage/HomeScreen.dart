import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/AuthorizationPage/bloc/auth/AuthBloc.dart';
import 'package:test_task/AuthorizationPage/bloc/auth/AuthEvent.dart';
import 'package:test_task/AuthorizationPage/bloc/auth/AuthState.dart';
import 'package:test_task/QuoteListPage/QuoteListScreen.dart';
import 'package:test_task/resources/UserSession.dart';
export '../resources/UserSession.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuoteListPage(),
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        actions: <Widget>[
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            return Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    print(state);
                      saveLogout();
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(UserLoggedOut());
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text(
                          'Выйти',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Icon(
                        Icons.exit_to_app,
                        color: Color(0xFF000000),
                      ),
                    ],
                  ),
                ));
          }),
        ],
      ),
    );
  }
}
