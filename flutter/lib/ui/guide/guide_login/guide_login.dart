import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/guide_login/guide_login.bloc.dart';
import 'package:tourists/components/guide/guide_routes.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/ui/guide/guide_home/guide_home.dart';

@provide
class GuideLoginScreen extends StatefulWidget {
  final GuideLoginBloc _guideLoginBloc;
  final SharedPreferencesHelper _preferencesHelper;

  GuideLoginScreen(this._guideLoginBloc, this._preferencesHelper);

  @override
  State<StatefulWidget> createState() => _GuideLoginScreenState();
}

class _GuideLoginScreenState extends State<GuideLoginScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  int stateCode = GuideLoginBloc.STATUS_CODE_INIT;

  loginUser(String phoneNumber, BuildContext context) {
    widget._guideLoginBloc.login(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    widget._guideLoginBloc.stateStream.listen((event) {
      if (event.first == GuideLoginBloc.STATUS_CODE_RECEIVED) {
        Navigator.pushReplacementNamed(context, GuideRoutes.guideRegister);
      }

      if (event.first == GuideLoginBloc.STATUS_CODE_FAILED) {
        Fluttertoast.showToast(msg: 'Error, Sorry =(');
      }

      if (event.first == GuideLoginBloc.STATUS_CODE_CONFIRM_ERROR) {
        Fluttertoast.showToast(msg: 'SMS Code is incorrect, Please Try Again');
      }

      if (event.first == GuideLoginBloc.STATUS_CODE_SENT) {
        Fluttertoast.showToast(msg: 'Code Sent!');
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Please Provide the Code from the SMS"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {
                      // TODO: Move this to confirm code
                      final code = _codeController.text.trim();
                      widget._guideLoginBloc.confirmCode(code);
                    },
                  )
                ],
              );
            });
      }
    });

    String myPhoneNumber = '+963953691509';

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Mobile Number"),
                controller: _phoneController,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text("LOGIN"),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () {
                    final phone = _phoneController.text.trim();
                    loginUser(phone, context);
                  },
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
