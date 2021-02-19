import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourists/generated/l10n.dart';

class PhoneEmailLinkLoginFormWidget extends StatefulWidget {
  final Function(String) onEmailLinkRequest;
  final Function(String) onCodeRequested;
  final Function() onGmailLoginRequested;
  final Function(String) onSnackBarRequested;

  PhoneEmailLinkLoginFormWidget({
    this.onEmailLinkRequest,
    this.onCodeRequested,
    this.onGmailLoginRequested,
    this.onSnackBarRequested,
  });

  @override
  State<StatefulWidget> createState() => _PhoneEmailLinkLoginWidgetState();
}

class _PhoneEmailLinkLoginWidgetState
    extends State<PhoneEmailLinkLoginFormWidget> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String countryCode = '+963';
  bool _phoneActive = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: __transitionBuilder,
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeOutBack,
      duration: Duration(milliseconds: 500),
      child: _phoneActive ? Padding(
        key: ValueKey<bool>(false),
        padding: const EdgeInsets.all(16.0),
        child: Card(child: _EmailSide()),
      ) : Padding(
        key: ValueKey<bool>(true),
        padding: const EdgeInsets.all(16.0),
        child: Card(child: _PhoneSide()),
      ),
    );
  }

  Widget _EmailSide() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 88,
          child: Center(
            child: Image.asset('resources/images/logo.jpg'),
          ),
        ),
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration:
                      InputDecoration(hintText: S.of(context).emailphone),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: FlatButton(
                  color: Colors.transparent,
                  child: Text(S.of(context).sendLoginLink),
                  onPressed: () {
                    if (_emailController.text.isEmpty) {
                      widget.onSnackBarRequested(
                          S.of(context).pleaseCompleteTheForm);
                    } else if (_emailController.text.contains('@') &&
                        _emailController.text.contains('.')) {
                      widget.onEmailLinkRequest(_emailController.text);
                    } else if (int.tryParse(_emailController.text) != null) {
                      widget.onCodeRequested(_emailController.text);
                    } else {
                      widget.onSnackBarRequested(
                          S.of(context).pleaseInputAnEmailOrAPhoneNumber);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      _phoneActive = !_phoneActive;
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  widget.onGmailLoginRequested();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _PhoneSide() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 88,
          child: Center(
            child: Image.asset('resources/images/logo.jpg'),
          ),
        ),
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Row(
                children: [
                  DropdownButton(
                    onChanged: (v) {
                      countryCode = v;
                      if (mounted) setState(() {});
                    },
                    value: countryCode,
                    items: [
                      DropdownMenuItem(
                        value: '+966',
                        child: Text(S.of(context).saudiArabia),
                      ),
                      DropdownMenuItem(
                        value: '+961',
                        child: Text(S.of(context).lebanon),
                      ),
                      DropdownMenuItem(
                        value: '+963',
                        child: Text(S.of(context).syria),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration:
                            InputDecoration(hintText: S.of(context).phoneNumber),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: FlatButton(
                  color: Colors.transparent,
                  child: Text(S.of(context).sendMeCode),
                  onPressed: () {
                    var phone = _phoneController.text;
                    if (phone.startsWith('0')) {
                      phone = phone.substring(1);
                    }
                    widget.onCodeRequested(countryCode + phone);
                  },
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  _phoneActive = !_phoneActive;
                  if (mounted) setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  widget.onGmailLoginRequested();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_phoneActive) != widget.key);
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}