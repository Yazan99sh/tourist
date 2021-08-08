import 'package:flutter/material.dart';
import 'package:tourists/module_locations/ui/screens/add_location/add_location.dart';

abstract class AddLocationState {
  final AddLocationScreen screen;

  AddLocationState(this.screen);

  Widget getUI(BuildContext context);
}