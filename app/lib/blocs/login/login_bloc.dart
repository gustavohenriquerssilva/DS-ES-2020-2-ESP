import 'dart:async';

import 'package:app/repositories/user_repository.dart';
import 'package:app/services/login_service.dart';
import 'package:bloc/bloc.dart';

import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressedEvent) {
      if (event.login.isEmpty || event.senha.isEmpty) {
        yield LoginState.failure("Informe login e a senha");
        return;
      }
      if (event.senha.length < 6) {
        yield LoginState.failure("Senha deve conter no mínimo 6 dígitos");
        return;
      }

      if (event.senha.length > 30) {
        yield LoginState.failure("Senha deve conter no máximo 30 dígitos");
        return;
      }

      yield LoginState.loading();

      try {
        var loginModel =
            await LoginService().realizeLogin(event.login, event.senha);
        UserRepository().persist(loginModel.user);
        yield LoginState.success(loginModel);
      } catch (e) {
        yield LoginState.failure(e.toString());
      }
    }
  }
}
