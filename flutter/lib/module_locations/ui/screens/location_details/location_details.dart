import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_locations/bloc/location_details/location_details_bloc.dart';
import 'package:tourists/module_locations/ui/states/location_details_state/location_details_state.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';

@provide
class LocationDetailsScreen extends StatefulWidget {
  final LocationDetailsBloc _locationBloc;
  final AuthGuard _authGuard;

  LocationDetailsScreen(this._locationBloc, this._authGuard);

  @override
  State<StatefulWidget> createState() => LocationDetailsScreenState();
}

class LocationDetailsScreenState extends State<LocationDetailsScreen> {
  LocationDetailsState _currentState;

  @override
  void initState() {
    super.initState();
    widget._locationBloc.stateStream.listen((event) {
      _currentState = event;
      if (this.mounted) setState(() {});
    });
  }

  void refresh() {
    setState(() {});
  }

  void createComment(String comment, String regionId, String detailsId) {
    widget._locationBloc.postComment(comment, regionId, detailsId, this);
  }

  void createRate(double rate, String regionId, String detailsId) {
    widget._locationBloc.createRate(rate, regionId, detailsId, this);
  }
  @override
  Widget build(BuildContext context) {
    if (_currentState == null) {
      var locationId = ModalRoute.of(context).settings.arguments;
      widget._locationBloc.getLocation(locationId, this);
    }
    return Scaffold(body: _currentState?.getUI(context));
  }
}
