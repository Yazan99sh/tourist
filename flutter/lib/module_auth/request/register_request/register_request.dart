import 'package:tourists/module_auth/enums/user_type.dart';

class RegisterRequest {
  String userID;
  String password;
  UserRole role;
  String username;

  RegisterRequest({this.userID, this.password, this.role, this.username});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = this.userID;
    data['password'] = this.password;
    data['name'] = this.username ?? 'user';
    data['places'] = ['-1'];
    return data;
  }
}
