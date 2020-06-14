import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

@provide
class RegisterService {
  SharedPreferencesHelper _sharedPrefsHelper;

  RegisterService(this._sharedPrefsHelper);

  Future<String> register(String username, String password) async {
    log('Register a user with email: ' + username + ' and Password: ' + password);
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
    email: username,
    password: password,
    )).user;
    if (user != null) {
      this.cacheLoggedInUser(user);
      return user.uid;
    } else {
      log('User Registration Failed');
      return null;
    }
  }

  cacheLoggedInUser(FirebaseUser user) {
    _sharedPrefsHelper.setCurrentUsername(user.email);
    _sharedPrefsHelper.setUserUID(user.uid);
  }
}