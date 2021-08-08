import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state.dart';

class EditProfileStateLoading extends EditProfileState {
  EditProfileStateLoading(MyProfileScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Flex(
        direction: Axis.vertical,
        children: [
          LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(S.of(context).requestingProfileFromTheServer),
          ),
        ],
      ),
    );
  }
}
