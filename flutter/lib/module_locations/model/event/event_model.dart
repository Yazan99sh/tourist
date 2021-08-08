import 'package:tourists/module_comment/response/comment/comment_response.dart';
import 'package:tourists/module_shared/model/date/date.dart';

class EventModel {
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
  bool isLogged;
  var commentNumber;
  EventModel(
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
      this.isLogged,
      this.commentNumber
      });
}
