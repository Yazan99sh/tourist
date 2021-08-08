import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state.dart';
import 'package:flutter/material.dart';

class LoginStateSuccess extends LoginState {
  LoginStateSuccess(LoginScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('resources/images/logo.jpg'),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          padding: EdgeInsets.all(16),
          onPressed: () {
            screen.moveToNext();
          },
          child: Text('${S.of(context).welcome}'),
        )
      ],
    );
  }
}
