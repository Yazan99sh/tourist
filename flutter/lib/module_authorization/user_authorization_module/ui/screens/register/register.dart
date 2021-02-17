import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_authorization/user_authorization_module/bloc/register/register.bloc.dart';

import '../../../user_auth_routes.dart';

@provide
class RegisterScreen extends StatefulWidget {
  final RegisterBloc _registerBloc;

  RegisterScreen(this._registerBloc);

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool success = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool submitAvailable = true;

  bool _error;
  String _userEmail;

  @override
  Widget build(BuildContext context) {
    widget._registerBloc.registerStatus.listen((event) {
      if (event != null && event.isNotEmpty) {
        Navigator.of(context).pushNamed(UserAuthorizationRoutes.createProfile);
      }
      submitAvailable = true;
      setState(() {});
    });

    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: <Widget>[
            Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // LOGO
                Container(
                  height: 156,
                  width: 156,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        height: 156,
                        width: 156,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(78),
                            color: Colors.green),
                      ),
                      Image.asset(
                        'resources/images/logo.jpg',
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                // Divider
                Container(
                  height: 56,
                ),
                Container(
                  width: 256,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          decoration:
                              InputDecoration(labelText: S.of(context).email),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return S.of(context).error_null_text;
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: S.of(context).password),
                          validator: (String value) {
                            if (value.isEmpty || value.length < 6) {
                              return S.of(context).error_null_text;
                            }
                            return null;
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            _register();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            alignment: Alignment.center,
                            child: Container(
                              width: 190,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90)),
                                color: submitAvailable
                                    ? Colors.greenAccent
                                    : Colors.grey,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  S.of(context).register_submit,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(_error == null
                              ? ''
                              : (_error
                                  ? S.of(context).successfully_registered +
                                      _userEmail
                                  : S.of(context).registration_failed)),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 56,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, UserAuthorizationRoutes.login);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(S.of(context).move_to_login),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    if (submitAvailable) {
      submitAvailable = false;
      setState(() {});
      widget._registerBloc.register(
          _emailController.text.trim(), _passwordController.text.trim());
    } else {
      Fluttertoast.showToast(msg: 'Please Wait!');
    }
  }
}