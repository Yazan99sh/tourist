import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_auth/enums/user_type.dart';

class PhoneEmailLinkLoginFormWidget extends StatefulWidget {
  final Function(String, UserRole) onEmailLinkRequest;
  final Function(String, UserRole) onCodeRequested;
  final Function(UserRole) onGmailLoginRequested;
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
  bool isGuide = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: __transitionBuilder,
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeOutBack,
      duration: Duration(milliseconds: 500),
      child:Padding(
              key: ValueKey<bool>(true),
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: isGuide ? Theme.of(context).primaryColor : Colors.white,
                child: _PhoneSide(),
              ),
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
        Text(isGuide
            ? S.of(context).loginAsGuide
            : S.of(context).loginAsTourist),
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
                  onFieldSubmitted: (s) {
                    FocusScope.of(context).unfocus();
                  },
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
                      widget.onEmailLinkRequest(
                          _emailController.text,
                          isGuide
                              ? UserRole.ROLE_GUIDE
                              : UserRole.ROLE_TOURIST);
                    } else if (int.tryParse(_emailController.text) != null) {
                      widget.onCodeRequested(
                          _emailController.text,
                          isGuide
                              ? UserRole.ROLE_GUIDE
                              : UserRole.ROLE_TOURIST);
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
                  widget.onGmailLoginRequested(
                      isGuide ? UserRole.ROLE_GUIDE : UserRole.ROLE_TOURIST);
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
            _userTypeSwitcher(),
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
        Text(
          isGuide ? S.of(context).loginAsGuide : S.of(context).loginAsTourist,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
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
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onFieldSubmitted: (s) {
                          FocusScope.of(context).unfocus();
                        },
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: S.of(context).phoneNumber),
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
                  color: isGuide ? Colors.white : Colors.transparent,
                  child: Text(S.of(context).sendMeCode),
                  onPressed: () {
                    var phone = _phoneController.text;
                    if (phone.startsWith('0')) {
                      phone = phone.substring(1);
                    }
                    widget.onCodeRequested(countryCode + phone,
                        isGuide ? UserRole.ROLE_GUIDE : UserRole.ROLE_TOURIST);
                  },
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  widget.onGmailLoginRequested(
                      isGuide ? UserRole.ROLE_GUIDE : UserRole.ROLE_TOURIST);
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
            _userTypeSwitcher(),
          ],
        ),
      ],
    );
  }

  Widget _userTypeSwitcher() {
    if (isGuide) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            isGuide = !isGuide;
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
              child: Icon(Icons.person),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            isGuide = !isGuide;
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
              child: Container(
                height: 24,
                width: 24,
                child: Image.asset('resources/images/logo.png'),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_phoneActive) != widget.key);
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}
