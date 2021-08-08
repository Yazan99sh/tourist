import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';

class LocationListResponse {
  String statusCode;
  String msg;
  List<LocationListItem> locationList;

  LocationListResponse({this.statusCode, this.msg, this.locationList});

  LocationListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      locationList = <LocationListItem>[];
      json['Data'].forEach((v) {
        locationList.add(new LocationListItem.fromJson(v));
      });
    }
  }
}
