import 'package:tourists/module_auth/enums/user_type.dart';

class SettingsModel {
  String lang;
  UserRole currentUserRole;

  SettingsModel(this.lang, this.currentUserRole);
}