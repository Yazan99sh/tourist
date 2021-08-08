import 'package:flutter/material.dart';

class CreateRatingRequest {
  String user;
  String rate;
  int region;
  String guide;

  CreateRatingRequest(
      {@required this.user, @required this.rate, this.region, this.guide});

  CreateRatingRequest.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    rate = json['rate'];
    region = json['region'];
    guide = json['guid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = this.user;
    data['rate'] = this.rate;
    if (region != null) data['region'] = this.region;
    if (guide != null) data['guid'] = this.guide;
    return data;
  }
}
