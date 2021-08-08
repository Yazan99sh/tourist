import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state.dart';
import 'package:tourists/module_auth/ui/widget/phone_email_link_login/phone_email_link_login.dart';
import 'package:flutter/material.dart';

class LoginStateError extends LoginState {
  String errorMsg;
  UserRole userType = UserRole.ROLE_TOURIST;
  final loginTypeController =
      PageController(initialPage: UserRole.ROLE_TOURIST.index);
  bool loading = false;

  String email;
  String password;
  UserRole role;

  LoginStateError(LoginScreenState screen, this.errorMsg, this.email,
      this.password, this.role)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: PhoneEmailLinkLoginFormWidget(
                onEmailLinkRequest: (email, role) {
                  screen.sendLoginLink(email, role);
                },
                onCodeRequested: (phoneNumber, role) {
                  screen.loginViaPhone(phoneNumber, role);
                },
                onGmailLoginRequested: (role) {
                  screen.loginViaGoogle(role);
                },
                onSnackBarRequested: (msg) {
                  screen.showSnackBar(msg);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              errorMessage(context, errorMsg),
              maxLines: 3,
            ),
          )
        ],
      ),
    );
  }

  String errorMessage(BuildContext context, String error) {
    if (error == 'Code Timeout') {
      return S.of(context).codeTimeout;
    } else if (error == 'Error finding the profile, please register first') {
      return S.of(context).errorFindingProfile;
    } else {
      return error;
    }
  }
}
