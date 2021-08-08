import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_forms/user_orders_module/model/request_guide/request_guide.model.dart';
import 'package:tourists/module_locations/model/location_details/location_details.dart';

class RequestLocationFormWidget extends StatefulWidget {
  final LocationDetailsModel location;
  final Function(RequestGuideModel) onRequestGuide;

  RequestLocationFormWidget({this.location, this.onRequestGuide});

  @override
  State<StatefulWidget> createState() =>
      _RequestLocationFormWidgetState(location);
}

class _RequestLocationFormWidgetState extends State<RequestLocationFormWidget> {
  final LocationDetailsModel location;

  _RequestLocationFormWidgetState(this.location);

  static const KEY_CAR = 'car';
  static const KEY_HOTEL = 'hotel';

  var servicesMap = <String>{};

  String _guideLanguage;
  String _guideId;
  final TextEditingController _arrivalDateField = TextEditingController();
  final TextEditingController _stayingTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 88,
          child: Column(
            children: [
              Expanded(
                child: Image.network('${location.regionImage[0].path}'
                        .contains('http')
                    ? '${location.regionImage[0].path.substring(location.regionImage[0].path.lastIndexOf('http'))}'
                    : '${location.regionImage[0].path}'),
              ),
              Text('${location.name}'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButtonFormField(
            items: ['العربية', 'English'].map((guideLanguage) {
              return DropdownMenuItem(
                value: guideLanguage,
                child: Text(guideLanguage),
              );
            }).toList(),
            hint: Text(S.of(context).expectedCommunicationLanguage),
            onChanged: (String value) {
              this._guideLanguage = value;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButtonFormField(
            items: (location.guides ?? []).map((theGuide) {
              return DropdownMenuItem(
                value: theGuide.userID,
                child: Text(theGuide.name),
              );
            }).toList(),
            hint: Text(S.of(context).expectedCommunicationLanguage),
            onChanged: (String value) {
              this._guideId = value;
            },
          ),
        ),
        Flex(
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
                        decoration: InputDecoration(
                            labelText: S.of(context).arrivalDate),
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
                              _arrivalDateField.text =
                                  value.toIso8601String().substring(0, 10);
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
                        decoration: InputDecoration(
                            labelText: S.of(context).stayingFor),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return S.of(context).error_null_text;
                          }
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                        child: Text(S.of(context).days),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Text(S.of(context).services),
            CheckboxListTile(
                title: Text(S.of(context).car),
                secondary: Icon(Icons.local_taxi),
                value: servicesMap.contains(KEY_CAR),
                onChanged: (bool value) {
                  servicesMap.contains(KEY_CAR);
                  setState(() {});
                }),
            CheckboxListTile(
                title: Text(S.of(context).hotel),
                secondary: Icon(Icons.hotel),
                value: servicesMap.contains(KEY_HOTEL),
                onChanged: (bool value) {
                  if (value) {
                    servicesMap.add(KEY_HOTEL);
                  } else {
                    servicesMap.remove(KEY_HOTEL);
                  }
                  setState(() {});
                })
          ],
        ),
        RaisedButton(
          onPressed: () {
            widget.onRequestGuide(RequestGuideModel(
              uid: FirebaseAuth.instance.currentUser.uid,
              guideId: _guideId,
              location: location.placeId,
              language: _guideLanguage,
              arrivalDate: DateTime.parse(_arrivalDateField.text),
              stayingDays: int.tryParse(_stayingTime.text),
              services: servicesMap.toList(),
            ));
          },
          color: Colors.greenAccent,
          child: Text(S.of(context).createNewOrder),
        ),
      ],
    );
  }
}
