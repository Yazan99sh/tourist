import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_locations/ui/screens/add_location/add_location.dart';
import 'package:tourists/module_locations/ui/screens/event_details/event_details_screen.dart';
import 'package:tourists/module_locations/ui/screens/location_details/location_details.dart';

import 'location_routes.dart';

@provide
class LocationModule extends YesModule {
  final LocationDetailsScreen _locationDetailsScreen;
  final EventDetailsScreen _eventDetailsScreen;
  final AddLocationScreen _addLocationScreen;

  LocationModule(
    this._locationDetailsScreen,
    this._eventDetailsScreen,
    this._addLocationScreen,
  );

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      LocationRoutes.eventDetails: (context) => _eventDetailsScreen,
      LocationRoutes.locationDetails: (context) => _locationDetailsScreen,
      LocationRoutes.addLocation: (context) => _addLocationScreen,
    };
  }
}
