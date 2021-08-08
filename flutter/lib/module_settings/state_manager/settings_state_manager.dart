import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/module_settings/model/settings_module.dart';
import 'package:tourists/utils/language/language.dart';

@provide
class SettingsStateManager {
  final AuthService _authService;
  final LanguageHelper _languageHelper;

  SettingsStateManager(
    this._authService,
    this._languageHelper,
  );

  Future<SettingsModel> getSettings() async {
    var lang = await _languageHelper.getLanguage();
    UserRole userRole;
    try {
      userRole = await _authService.userRole;
    } catch (e) {
      userRole = null;
    }
    if (!await _authService.isLoggedIn) {
      userRole = null;
    }
    return SettingsModel(lang, userRole);
  }

  void logout(BuildContext context) {
    _authService.logout().then((value) => Navigator.of(context)
        .pushNamedAndRemoveUntil(HomeRoutes.home, (r) => false));
  }

  void changeLanguage(String lang) {
    _languageHelper.setLanguage(lang);
  }
}
