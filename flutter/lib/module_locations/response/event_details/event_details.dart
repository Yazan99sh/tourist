import 'package:tourists/module_comment/response/comment/comment_response.dart';
import 'package:tourists/module_shared/model/date/date.dart';

class EventResponse {
  String statusCode;
  String msg;
  Data data;

  EventResponse({this.statusCode, this.msg, this.data});

  EventResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String type;
  String subType;
  Date date;
  String status;
  String location;
  String description;
  var images;
  List<CommentModel> comments;
  int commentNumber;
  Data(
      {this.id,
      this.name,
      this.type,
      this.subType,
      this.date,
      this.status,
      this.location,
      this.description,
      this.images,
      this.comments,
      this.commentNumber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    subType = json['subType'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    status = json['status'];
    location = json['location'];
    description = json['description'];
    if (json['images'] != null) {
      images = json['images'];
      bool flag = images?.isEmpty;
      if (flag) {
        images = <String>[];
      } else {
        images = json['images']['image'];
      }
    }
    commentNumber = json['commentNumber'];
    if (json['comments'] != null) {
      comments = <CommentModel>[];
      json['comments'].forEach((v) {
        comments.add(new CommentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['subType'] = this.subType;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    data['status'] = this.status;
    data['location'] = this.location;
    data['description'] = this.description;
    data['images'] = this.images;
    return data;
  }
}
