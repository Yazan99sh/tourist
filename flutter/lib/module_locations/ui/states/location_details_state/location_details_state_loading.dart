import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_locations/ui/screens/location_details/location_details.dart';
import 'package:tourists/module_locations/ui/states/location_details_state/location_details_state.dart';

class LocationDetailsStateLoading extends LocationDetailsState {
  final LocationDetailsScreenState screenState;

  LocationDetailsStateLoading(this.screenState) : super(screenState);
  

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}