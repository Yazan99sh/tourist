import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:tourists/user/bloc/request_guide/request_guide.bloc.dart';
import 'package:tourists/user/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/user/nav_arguments/request_guide/request_guide_navigation.dart';
import 'package:tourists/user/user_routes.dart';

@provide
class RequestGuideScreen extends StatefulWidget {
  final RequestGuideBloc _requestGuideBloc;

  RequestGuideScreen(this._requestGuideBloc);

  @override
  State<StatefulWidget> createState() => _RequestGuideScreenState();
}

class _RequestGuideScreenState extends State<RequestGuideScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _arrivalDateField = TextEditingController();
  final TextEditingController _stayingTime = TextEditingController();

  RequestGuideNavigationArguments _requestGuideArguments;
  String _arrivalCity;
  DateTime _arrivalDate;
  String _guideLanguage;

  static const KEY_CAR = 'car';
  static const KEY_HOTEL = 'hotel';

  GuideListItemModel _guideInfo;

  Map<String, bool> servicesMap = Map.fromIterable([
    {KEY_CAR: false},
    {KEY_HOTEL: false}
  ]);

  @override
  Widget build(BuildContext context) {
    _requestGuideArguments = ModalRoute.of(context).settings.arguments;

    if (_requestGuideArguments == null) {
      Fluttertoast.showToast(msg: 'Null Guide Id');
      return Scaffold(
        body: Center(
          child: Text('No Guide Id?!!'),
        ),
      );
    }

    // listen for guide Info
    widget._requestGuideBloc.guideInfoStream.listen((event) {
      _guideInfo = event;
      setState(() {});
    });

    // If guide id exists, we can use the list to get the info
    if (_guideInfo == null) {
      widget._requestGuideBloc.getGuideWithId(_requestGuideArguments.guideId);
      return Scaffold(
        body: Center(
          child: Text('Loading ;)'),
        ),
      );
    }

    List<Widget> pageLayout = [];

    // region Guide Info Header
    Row guideInfoHeader = Row(
      children: <Widget>[
        Image.network(_guideInfo.image),
        Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              _guideInfo.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _getStarsLine(_guideInfo.rating),
            Text(_guideInfo.status)
          ],
        )
      ],
    );
    pageLayout.add(guideInfoHeader);
    // endregion

    // region Language Selector
    List<DropdownMenuItem<String>> languageList = [];
    _guideInfo.language.forEach((guideLanguage) {
      languageList.add(
        DropdownMenuItem(
          value: guideLanguage,
          child: Text(guideLanguage),
        ),
      );
    });
    Widget languageSelector = DropdownButtonFormField(
      items: languageList,
      onChanged: (String value) {
        this._guideLanguage = value;
      },
    );
    pageLayout.add(languageSelector);
    // endregion

    // region City Selector
    List<DropdownMenuItem<String>> locationList = [];
    _guideInfo.city.forEach((guideLocation) {
      languageList.add(
        DropdownMenuItem(
          value: guideLocation,
          child: Text(guideLocation),
        ),
      );
    });
    Widget locationSelector = DropdownButtonFormField(
      items: locationList,
      onChanged: (String value) {
        this._arrivalCity = value;
      },
    );
    pageLayout.add(locationSelector);
    // endregion

    // region Dates
    Flex datesRow = Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  TextFormField(
                    controller: _arrivalDateField,
                    decoration: InputDecoration(labelText: 'Arrival Date'),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      child: Container(
                        color: Color(0x01FFFFFF),
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year,
                              DateTime.now().month + 4, DateTime.now().day),
                        ).then((value) {
                          _arrivalDate = value;
                          _arrivalDateField.text =
                              _arrivalDate.toIso8601String().substring(0, 10);
                        });
                      },
                    ),
                  )
                ],
              ),
            )),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: TextFormField(
                    controller: _stayingTime,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Staying for'),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                    child: Text('Days'),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
    pageLayout.add(datesRow);
    // endregion

    // region Services Checklist
    Flex servicesContainer = Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Text('Services'),
        CheckboxListTile(
            title: Text('Car'),
            secondary: Icon(Icons.local_taxi),
            value: false,
            onChanged: (bool value) {
              servicesMap[KEY_CAR] = value;
            }),
        CheckboxListTile(
            title: Text('Hotel'),
            secondary: Icon(Icons.hotel),
            value: false,
            onChanged: (bool value) {
              servicesMap[KEY_HOTEL] = value;
            })
      ],
    );
    pageLayout.add(servicesContainer);
    // endregion

    // region Next
    pageLayout.add(Container(
      child: RaisedButton(
        onPressed: _requestGuide(),
        child: Text('Request a Chat!'),
      ),
    ));
    // endregion

    return Scaffold(
      body: ListView(
        children: pageLayout,
      ),
    );
  }

  _getStarsLine(double starCount) {
    List<Widget> stars = [];
    for (int i = 0; i < starCount; i++) {
      stars.add(Icon(Icons.star));
    }

    return Flex(
      direction: Axis.horizontal,
      children: stars,
    );
  }

  _requestGuide() {
    Fluttertoast.showToast(msg: 'Requesting Chat Access');
    List<String> servicesList = [];
    servicesMap.forEach((key, value) {
      if (value == true) servicesList.add(key);
    });
    widget._requestGuideBloc.requestGuide(
        _requestGuideArguments.guideId,
        servicesList,
        _arrivalDateField.text,
        _stayingTime.text,
        _guideLanguage,
        _arrivalCity);
  }
}
