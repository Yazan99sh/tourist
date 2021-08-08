class CreateCommentRequest {
  String comment;
  String region;
  String user;
  var event;
  CreateCommentRequest({this.comment, this.region, this.user, this.event});

  CreateCommentRequest.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    region = json['region'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = this.comment;
    if (this.region != null) {
      data['region'] = this.region;
    }
    data['user'] = this.user;
    data['date'] = DateTime.now().toIso8601String();
    if (this.event != null) {
      data['event'] = this.event;
    }
    return data;
  }
}
