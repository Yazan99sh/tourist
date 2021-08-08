import 'dart:async';

import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_profile/profile_routes.dart';

@provide
class LoginScreen extends StatefulWidget {
  final LoginStateManager _stateManager;

  LoginScreen(this._stateManager);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  UserRole currentUserRole;
  LoginState _currentStates;

  StreamSubscription _stateSubscription;
  bool deepLinkChecked = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _currentStates ??= LoginStateInit(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
          _currentStates = event;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(),
        body: SafeArea(
          child: _currentStates.getUI(context),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }

  void moveToNext() {
    Navigator.of(context).pushReplacementNamed(ProfileRoutes.MY_ROUTE_PROFILE);
  }

  void loginViaPhone(String phoneNumber, UserRole role) {
    widget._stateManager.loginViaPhoneNumber(phoneNumber, role, this);
  }

  void loginViaGoogle(UserRole role) {
    currentUserRole = role;
    widget._stateManager.loginViaGoogle(this, role);
  }

  void sendLoginLink(String email, UserRole role) {
    widget._stateManager.sendLoginLink(this, email, role);
  }

  void loginOwner(String email, String password, UserRole role) {
    widget._stateManager.loginViaEmailAndPassword(this, email, password, role);
  }

  void showSnackBar(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  void confirmSMS(String smsCode) {
    widget._stateManager.confirmSMSCode(smsCode, this);
  }

  void retryPhone() {
    _currentStates = LoginStateInit(this);
  }
}
