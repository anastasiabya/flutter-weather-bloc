import 'package:services/exceptions/AuthenticationException.dart';
import 'package:test_task/AuthorizationPage/models/User.dart';

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<User> signInWithLoginAndPassword(String login, String password);
  Future<void> signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<User> getCurrentUser() async {
    return null;
  }

  @override
  Future<User> signInWithLoginAndPassword(String login, String password) async {

    const userLogin = 'admin';
    const userPassword = 'admin';

    if (login != userLogin || password != userPassword) {
      throw AuthenticationException(message: 'Неправильный логин или пароль');
    }

    return User(login: userLogin, pass: userPassword);
  }


  @override
  Future<void> signOut() {
    return null;
  }
}