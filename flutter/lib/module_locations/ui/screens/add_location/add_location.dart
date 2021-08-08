import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_locations/bloc/add_location/add_location.dart';
import 'package:tourists/module_locations/model/location_details/location_details.dart';
import 'package:tourists/module_locations/ui/states/add_location_state/add_location_state.dart';
import 'package:tourists/module_locations/ui/states/add_location_state/add_location_state_loading.dart';

@provide
class AddLocationScreen extends StatefulWidget {
  final AddLocationBloc addLocationBloc;
  AddLocationScreen(this.addLocationBloc);

  void uploadImage(String imagePath, LocationDetailsModel model) {
    addLocationBloc.uploadImage(this, imagePath, model);
  }

  void saveLocation(LocationDetailsModel model) {
    addLocationBloc.saveLocation(this, model);
  }

  @override
  State<StatefulWidget> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  AddLocationState currentState;
  StreamSubscription _stateSubscription;

  @override
  void initState() {
    _stateSubscription = widget.addLocationBloc.stateSubject.stream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentState == null) {
      var args = ModalRoute.of(context).settings.arguments;
      widget.addLocationBloc.getLocation(widget, '${args}');
      currentState = AddLocationStateLoading(widget);
    }

    return Scaffold(
      appBar: AppBar(),
      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    if (_stateSubscription != null) {
      _stateSubscription.cancel();
    }
    super.dispose();
  }
}