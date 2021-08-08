import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_locations/bloc/location_list/location_list_bloc.dart';
import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';
import 'package:tourists/module_locations/ui/widgets/location_list_item/location_list_item.dart';

import '../../../location_routes.dart';

@provide
class LocationListScreen extends StatefulWidget {
  final LocationListBloc bloc;

  LocationListScreen(this.bloc);

  @override
  State<StatefulWidget> createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  List<LocationListItem> locationModelList;
  int currentStatus = LocationListBloc.STATUS_CODE_INIT;

  StreamSubscription _stateSubscription;

  @override
  Widget build(BuildContext context) {
    _stateSubscription = widget.bloc.stateStream.listen((event) {
      currentStatus = event[LocationListBloc.KEY_STATUS];
      if (currentStatus == LocationListBloc.STATUS_CODE_LOAD_SUCCESS) {
        locationModelList = event[LocationListBloc.KEY_PAYLOAD];
      }

      if (this.mounted) {
        setState(() {});
      }
    });

    switch (currentStatus) {
      case LocationListBloc.STATUS_CODE_INIT:
        if (this.locationModelList == null) widget.bloc.requestLocationList();
        return _getLoadingScreen();
      case LocationListBloc.STATUS_CODE_LOADING:
        return _getLoadingScreen();
      case LocationListBloc.STATUS_CODE_LOAD_SUCCESS:
        return _getSuccessScreen();
      case LocationListBloc.STATUS_CODE_LOAD_ERROR:
        return _getErrorScreen();
      default:
        return _getErrorScreen();
    }
  }

  Widget _getSuccessScreen() {
    List<Widget> locationWidgetList = [];

    if (locationModelList != null) {
      locationModelList.forEach((location) {
        locationWidgetList.add(GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              LocationRoutes.locationDetails,
              arguments: location.id.toString(),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: LocationListItemWidget(
              imageLink:location.path.length!=0?location.path[0].path:'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg',
              title: location.name,
              description: location.description,
              rate: double.parse(location.ratingAverage).floor() ?? 0,
              commentsNumber: location.commentNumber != null
                  ? int.parse(location.commentNumber)
                  : 0,
            ),
          ),
        ));
      });
    }

    return SingleChildScrollView(
      child: Flex(
        direction: Axis.vertical,
        children: locationWidgetList,
      ),
    );
  }

  Widget _getErrorScreen() {
    return Center(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(S.of(context).error_fetching_data),
          RaisedButton(
            child: Text(S.of(context).reload),
            onPressed: () {
              widget.bloc.requestLocationList();
            },
          )
        ],
      ),
    );
  }

  Widget _getLoadingScreen() {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        CircularProgressIndicator(),
        Text('${S.of(context).loading}')
      ],
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
