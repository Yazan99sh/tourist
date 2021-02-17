import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';

import 'ui/screens/create_profile/create_profile.dart';
import 'ui/screens/login/login.dart';
import 'ui/screens/register/register.dart';
import 'user_auth_routes.dart';

@provide
class UserAuthorizationModule extends YesModule {
  final LoginScreen _loginScreen;
  final RegisterScreen _registerScreen;
  final CreateProfileScreen _createProfileScreen;

  UserAuthorizationModule(
    this._createProfileScreen,
    this._registerScreen,
    this._loginScreen,
  );

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      UserAuthorizationRoutes.login: (context) => _loginScreen,
      UserAuthorizationRoutes.register: (context) => _registerScreen,
      UserAuthorizationRoutes.createProfile: (context) => _createProfileScreen
    };
  }
}