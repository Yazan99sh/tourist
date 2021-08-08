import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';
import 'package:tourists/module_profile/ui/widget/profile_form_widget.dart';
import 'package:tourists/module_search/bloc/search_bloc/search_bloc.dart';

import 'edit_profile_state.dart';

class EditProfileStateGuideLoadSuccess extends EditProfileState {
  ProfileModel userProfile;
  final SearchBloc _searchBloc;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  final languages = <String>{};
  final locations = <String>{};
  final services = <String>{};

  EditProfileStateGuideLoadSuccess(
    MyProfileScreen screen,
    this.userProfile,
    this._searchBloc,
  ) : super(screen) {
    if (userProfile == null) {
      return;
    }

    languages.addAll(userProfile.languages ?? []);
    locations.addAll(userProfile.locations ?? []);
    services.addAll(userProfile.services ?? []);

    if (userProfile != null) {
      _nameController.text = userProfile.name;
      _phoneController.text = userProfile.phone;
    }
  }

  @override
  Widget getUI(BuildContext context) {
    // var profile = userProfile;
    userProfile ??= ProfileModel();

    return GuideProfileFormWidget(
      searchBloc: _searchBloc,
      userProfile: userProfile,
      onImageSelected: (imagePath, profile) {
        profile.imageUpdated = true;
        screen.onImageSelected(imagePath, profile);
      },
      onProfileSaved: (profile) {
        profile.imageUpdated = profile.imageUpdated ?? false;
        screen.saveProfile(profile);
      },
    );
  }
}
