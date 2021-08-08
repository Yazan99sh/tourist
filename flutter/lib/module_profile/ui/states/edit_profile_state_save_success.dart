import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_home/home_routes.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state.dart';

class EditProfileStateSaveSuccess extends EditProfileState {
  EditProfileStateSaveSuccess(MyProfileScreen screen) : super(screen);
//
  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor, shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 125,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: Text('${S.of(context).successfully_saved}',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),)),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: RaisedButton(
            elevation: 0,
            child: Text('${S.of(context).next}'),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(HomeRoutes.home, (r) => false);
            },
          ),
        )
      ],
    );
  }
}
