import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_authorization/guide_authorization_module/bloc/guide_login/guide_login.bloc.dart';

import '../../../guide_authorization_routes.dart';

@provide
class GuideLoginScreen extends StatefulWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GuideLoginBloc _guideLoginBloc;

  GuideLoginScreen(this._guideLoginBloc);

  @override
  State<StatefulWidget> createState() => _GuideLoginScreenState();
}

class _GuideLoginScreenState extends State<GuideLoginScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  int stateCode = GuideLoginBloc.STATUS_CODE_INIT;

  bool canRequest = true;

  void loginUser(String phoneNumber, BuildContext context) {
    widget._guideLoginBloc.login(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    User user = widget._firebaseAuth.currentUser;
    print('User Logged in: ' + (user != null).toString());
    if (user != null) {
      Navigator.pushNamed(context, GuideAuthorizationRoutes.guideUpdateProfile);
    }

    widget._guideLoginBloc.stateStream.listen((event) {
      if (event.first == GuideLoginBloc.STATUS_CODE_RECEIVED) {
        Navigator.pushNamed(
            context, GuideAuthorizationRoutes.guideUpdateProfile);
      }

      if (event.first == GuideLoginBloc.STATUS_CODE_FAILED) {
        canRequest = true;
        Fluttertoast.showToast(msg: 'Error, Sorry =(');
      }

      if (event.first == GuideLoginBloc.STATUS_CODE_CONFIRM_ERROR) {
        canRequest = true;
        Fluttertoast.showToast(msg: 'SMS Code is incorrect, Please Try Again');
      }

      if (event.first == GuideLoginBloc.STATUS_CODE_SENT) {
        canRequest = false;
        Fluttertoast.showToast(msg: 'Code Sent!');
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('Please Provide the Code from the SMS'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: 'Confirmation Code'),
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Confirm'),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {
                      final code = _codeController.text.trim();
                      widget._guideLoginBloc.confirmCode(code);
                    },
                  )
                ],
              );
            });
      }
    });

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 36,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Mobile Number'),
                    controller: _phoneController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      child: Text('LOGIN'),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () {
                        if (!canRequest) return;
                        final phone = _phoneController.text.trim();
                        setState(() {
                          canRequest = false;
                        });
                        loginUser(phone, context);
                      },
                      color: canRequest ? Colors.blue : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}