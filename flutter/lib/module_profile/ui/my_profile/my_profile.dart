import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';
import 'package:tourists/module_profile/state_manager/my_profile/my_profile_state_manager.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state_loading.dart';

@provide
class MyProfileScreen extends StatefulWidget {
  final MyProfileStateManager _stateManager;

  MyProfileScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => _MyProfileScreenState();

  void onImageSelected(String imagePath, ProfileModel profileModel) {
    _stateManager.upload(this, imagePath, profileModel);
  }

  void saveProfile(ProfileModel profileModel) {
    _stateManager.setMyProfile(this, profileModel);
  }

  void getProfile() {
    _stateManager.getMyProfile(this);
  }
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  StreamSubscription _stateSubscription;
  EditProfileState currentState;

  @override
  void initState() {
    super.initState();
    currentState ??= EditProfileStateLoading(widget);
    widget._stateManager.getMyProfile(widget);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    currentState ??= EditProfileStateLoading(widget);
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: currentState.getUI(context),
      ),
    );
  }

  @override
  void dispose() {
    if (_stateSubscription != null) {
      _stateSubscription.cancel();
    }
    super.dispose();
  }
}
