import 'package:bloc/bloc.dart';
import 'package:test_task/AuthorizationPage/bloc/auth/AuthBloc.dart';
import 'package:test_task/AuthorizationPage/bloc/auth/AuthEvent.dart';
import 'package:test_task/AuthorizationPage/services/AuthService.dart';
import 'LoginEvent.dart';
import 'LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  LoginBloc(AuthenticationBloc authenticationBloc, AuthenticationService authenticationService)
      : assert(authenticationBloc != null),
        assert(authenticationService != null),
        _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithLoginButtonPressed) {
      yield* _mapLoginWithLoginToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithLoginToState(LoginInWithLoginButtonPressed event) async* {
    yield LoginLoading();
    try {
      final user = await _authenticationService.signInWithLoginAndPassword(event.login, event.password);
      if (user != null) {
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Ошибка');
      }
    } catch (err) {
      yield LoginFailure(error: 'Неверный логин или пароль');
    }
  }
}