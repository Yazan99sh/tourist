import 'package:flutter/cupertino.dart';
import 'package:tourists/module_locations/ui/screens/location_details/location_details.dart';

abstract class LocationDetailsState {
  final LocationDetailsScreenState _screenState;
  LocationDetailsState(this._screenState);
  Widget getUI(BuildContext context);
}
