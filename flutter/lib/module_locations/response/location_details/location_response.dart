import 'package:tourists/module_locations/model/location_details/location_details.dart';

class LocationDetailsResponse {
  String statusCode;
  String msg;
  LocationDetailsModel locationDetails;

  LocationDetailsResponse({this.statusCode, this.msg, this.locationDetails});

  LocationDetailsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    locationDetails = LocationDetailsModel.fromJson(json['Data']);
  }
}