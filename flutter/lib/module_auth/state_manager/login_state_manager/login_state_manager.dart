import 'package:flutter/foundation.dart';
import 'package:tourists/module_auth/enums/auth_status.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state_code_sent.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state_email_sent.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state_error.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state_loading.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state_success.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class LoginStateManager {
  final AuthService _authService;
  final PublishSubject<LoginState> _loginStateSubject =
      PublishSubject<LoginState>();

  String _email;
  String _password;

  LoginScreenState _screenState;

  LoginStateManager(this._authService) {
    _authService.authListener.listen((event) {
      debugPrint(event.toString());
      if (event == AuthStatus.AUTHORIZED) {
        _screenState.moveToNext();
      }
    });
  }

  Stream<LoginState> get stateStream => _loginStateSubject.stream;

  void loginViaPhoneNumber(
      String phoneNumber, UserRole role, LoginScreenState _loginScreenState) {
    _loginStateSubject.add(LoginStateLoading(_loginScreenState));
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _loginStateSubject.add(LoginStateSuccess(_loginScreenState));
          break;
        case AuthStatus.CODE_SENT:
          _loginStateSubject.add(LoginStateCodeSent(_loginScreenState));
          break;
        case AuthStatus.CODE_TIMEOUT:
          _loginStateSubject.add(LoginStateError(
              _loginScreenState, 'Code Timeout', _email, _password, role));
          break;
        default:
          _loginStateSubject.add(LoginStateInit(_loginScreenState));
          break;
      }
    }).onError((err) {
      _loginStateSubject.add(LoginStateError(
          _loginScreenState, err.toString(), _email, _password, role));
    });

    _authService.verifyWithPhone(true, phoneNumber, role);
  }

  void loginViaEmailAndPassword( LoginScreenState _loginScreenState,
      String email, String password, UserRole role) {
    _loginStateSubject.add(LoginStateLoading(_loginScreenState));
    _email = email;
    _password = password;
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _loginStateSubject
              .add(LoginStateSuccess(_loginScreenState ?? _screenState));
          break;
        default:
          _loginStateSubject.add(LoginStateInit(_loginScreenState));
          break;
      }
    }).onError((err) {
      _loginStateSubject.add(LoginStateError(
          _loginScreenState, err.toString(), _email, _password, role));
    });

    _authService.signInWithEmailAndPassword(
        email, password, UserRole.ROLE_TOURIST, true);
  }

  void confirmSMSCode(String smsCode, LoginScreenState screenState) {
    _screenState = screenState;
    _authService.confirmWithCode(smsCode, UserRole.ROLE_GUIDE, true);
  }

  void loginViaGoogle(LoginScreenState screenState, UserRole role) {
    _screenState = screenState;
    _authService.verifyWithGoogle(role, true);
  }

  void sendLoginLink(
      LoginScreenState screenState, String email, UserRole role) {
    _authService.sendEmailLink(email, role);
    _loginStateSubject.add(LoginStateEmailSent(screenState));
  }
}
