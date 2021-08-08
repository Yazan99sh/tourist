import 'package:tourists/module_profile/response/profile_response/profile_response.dart';

class ProfileListResponse {
  String statusCode;
  String msg;
  List<ProfileResponse> data;

  ProfileListResponse({this.statusCode, this.msg, this.data});

  ProfileListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      if (json['Data'] is List) {
        data = <ProfileResponse>[];
        json['Data'].forEach((v) {
          data.add(new ProfileResponse.fromJson(v));
        });
      } else {
        data = [new ProfileResponse.fromJson(json['Data'])];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
