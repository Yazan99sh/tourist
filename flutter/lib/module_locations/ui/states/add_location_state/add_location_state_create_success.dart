import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_locations/ui/screens/add_location/add_location.dart';
import 'package:tourists/module_locations/ui/states/add_location_state/add_location_state.dart';
import 'package:tourists/module_profile/profile_routes.dart';

class AddLocationStateCreateSuccess extends AddLocationState {
  final String placeId;
  AddLocationStateCreateSuccess(AddLocationScreen screen, this.placeId) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(Icons.check),
        onPressed: () {
          Navigator.of(context).pushNamed(ProfileRoutes.MY_ROUTE_PROFILE);
        },
      ),
    );
  }
}
