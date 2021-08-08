import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';

class GuidesResponse {
  String statusCode;
  String msg;
  List<GuideListItemModel> data;
  var noData;
  GuidesResponse({this.statusCode, this.msg, this.data});

  GuidesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <GuideListItemModel>[];
      try {
        json['Data'].forEach((v) {
          if (v != null) data.add(new GuideListItemModel.fromJson(v));
        });
      } catch (e) {
        noData = json['Data'];
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
