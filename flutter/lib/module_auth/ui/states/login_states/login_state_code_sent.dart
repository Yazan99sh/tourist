import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/utils/keyboard_detector/keyboard_detector.dart';

class LoginStateCodeSent extends LoginState {
  final _confirmationController = TextEditingController();
  bool retryEnabled = false;
  bool loading = false;

  LoginStateCodeSent(LoginScreenState screen) : super(screen) {
    Future.delayed(Duration(seconds: 30), () {
      retryEnabled = true;
      screen.refresh();
    });
  }

  @override
  Widget getUI(BuildContext context) {
    return Form(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          KeyboardDetector.isUp(context)
              ? Center(
                  child: Image.asset(
                  'resources/images/logo.jpg',
                  height: 88,
                  width: 88,
                ))
              : Container(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
                controller: _confirmationController,
                decoration: InputDecoration(
                  labelText: S.of(context).confirmCode,
                  hintText: '12345',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v.isEmpty) {
                    return S.of(context).pleaseInputYourPhoneNumber;
                  }
                  return null;
                }),
          ),
          OutlinedButton(
            onPressed: retryEnabled
                ? () {
                    screen.retryPhone();
                  }
                : null,
            child: Text(S.of(context).resendCode),
          ),
          loading
              ? Text(S.of(context).loading)
              : Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: GestureDetector(
                    onTap: () {
                      loading = true;
                      Future.delayed(Duration(seconds: 10), () {
                        loading = false;
                      });
                      screen.refresh();
                      screen.confirmSMS(_confirmationController.text);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            S.of(context).confirm,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
