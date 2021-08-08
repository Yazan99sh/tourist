import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_locations/bloc/location_list/location_list_bloc.dart';
import 'package:tourists/module_shared/ui/widgets/carousel/carousel.dart';
import 'package:tourists/module_shared/ui/widgets/carousel_card/carousel_card.dart';

import '../../../location_routes.dart';

@provide
class LocationCarouselScreen extends StatefulWidget {
  final LocationListBloc bloc;

  LocationCarouselScreen(this.bloc);

  @override
  State<StatefulWidget> createState() => _LocationCarouselScreenState();
}

class _LocationCarouselScreenState extends State<LocationCarouselScreen> {
  List locationList;
  int currentStatus = -1;

  StreamSubscription _stateSubscription;

  @override
  Widget build(BuildContext context) {
    _stateSubscription = widget.bloc.stateStream.listen((event) {
      currentStatus = event[LocationListBloc.KEY_STATUS];

      if (currentStatus == LocationListBloc.STATUS_CODE_LOAD_SUCCESS) {
        locationList = event[LocationListBloc.KEY_PAYLOAD];
      }

      if (this.mounted) setState(() {});
    });

    switch (currentStatus) {
      case LocationListBloc.STATUS_CODE_INIT:
        if (this.locationList == null) widget.bloc.requestLocationList();
        return _getLoadingScreen();
      case LocationListBloc.STATUS_CODE_LOADING:
        return _getLoadingScreen();
      case LocationListBloc.STATUS_CODE_LOAD_SUCCESS:
        return _getSuccessScreen();
      default:
        return _getErrorScreen();
    }
  }

  Widget _getSuccessScreen() {
    List<Widget> locationWidgetList = [];

    locationList.forEach((location) {
      locationWidgetList.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            LocationRoutes.locationDetails,
            arguments: location.id.toString(),
          );
        },
        child: CarouselCard(
          title: location.name,
          description: location.description,
          image: location.path.length!=0?location.path[0].path:'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg',
          commentsNumber: location.commentNumber != null
              ? int.parse(location.commentNumber)
              : 0,
          stars: double.parse(location.ratingAverage).floor() ?? 0,
        ),
      ));
    });

    return CarouselWidget(locationWidgetList);
  }

  Widget _getErrorScreen() {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(S.of(context).error_fetching_data),
        RaisedButton(
            child: Text(S.of(context).reload),
            onPressed: () {
              widget.bloc.requestLocationList();
            }),
      ],
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
