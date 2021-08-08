import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state.dart';
import 'package:tourists/module_profile/ui/widget/tourist_profile_form.dart';

class EditProfileStateTouristLoadSuccess extends EditProfileState {
  ProfileModel profile;

  EditProfileStateTouristLoadSuccess(MyProfileScreen screen, this.profile)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    profile ??= ProfileModel();

    return TouristProfileForm(
      profile: profile,
      onImageSelected: (image, profile) {
        profile.imageUpdated = true;
        screen.onImageSelected(image, profile);
      },
      saveProfile: (profile) {
        profile.imageUpdated = profile.imageUpdated??false;
        screen.saveProfile(profile);
      },
    );
  }
}
