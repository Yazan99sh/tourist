import 'package:tourists/module_comment/response/comment/comment_response.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';

class LocationDetailsModel {
  int id;
  String name;
  String description;
  dynamic location;
  List<CommentModel> comments;
  String ratingAverage;
  List<RegionImage> regionImage;
  List<GuideListItemModel> guides;
  String placeId;
  var userRating;
  LocationDetailsModel(
      {this.id,
      this.name,
      this.description,
      this.location,
      this.comments,
      this.ratingAverage,
      this.regionImage,
      this.guides,
      this.placeId,
      this.userRating});

  LocationDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    location = json['location'];
    if (json['comments'] != null) {
      comments = <CommentModel>[];
      json['comments'].forEach((v) {
        comments.add(new CommentModel.fromJson(v));
      });
    }
    ratingAverage = json['ratingAverage'];
    if (json['regionImage'] != null) {
      regionImage = <RegionImage>[];
      json['regionImage'].forEach((v) {
        regionImage.add(new RegionImage.fromJson(v));
      });
    }
    if (json['guides'] != null) {
      guides = <GuideListItemModel>[];
      json['guides'].forEach((v) {
        guides.add(new GuideListItemModel.fromJson(v));
      });
    }
    placeId = json['placeId'];
    userRating = json['userRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location'] = this.location;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['ratingAverage'] = this.ratingAverage;
    if (this.regionImage != null) {
      data['regionImage'] = this.regionImage.map((v) => v.toJson()).toList();
    }
    if (this.guides != null) {
      data['guides'] = this.guides.map((v) => v.toJson()).toList();
    }
    data['placeId'] = this.placeId;
    return data;
  }
}

class Date {
  Timezone timezone;
  int offset;
  int timestamp;

  Date({this.timezone, this.offset, this.timestamp});

  Date.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'] != null
        ? new Timezone.fromJson(json['timezone'])
        : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.timezone != null) {
      data['timezone'] = this.timezone.toJson();
    }
    data['offset'] = this.offset;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Timezone {
  String name;
  List<Transitions> transitions;
  Location location;

  Timezone({this.name, this.transitions, this.location});

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = <Transitions>[];
      json['transitions'].forEach((v) {
        transitions.add(new Transitions.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    if (this.transitions != null) {
      data['transitions'] = this.transitions.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    return data;
  }
}

class Transitions {
  int ts;
  String time;
  int offset;
  bool isdst;
  String abbr;

  Transitions({this.ts, this.time, this.offset, this.isdst, this.abbr});

  Transitions.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ts'] = this.ts;
    data['time'] = this.time;
    data['offset'] = this.offset;
    data['isdst'] = this.isdst;
    data['abbr'] = this.abbr;
    return data;
  }
}

class Location {
  String countryCode;
  int latitude;
  int longitude;
  String comments;

  Location({this.countryCode, this.latitude, this.longitude, this.comments});

  Location.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['comments'] = this.comments;
    return data;
  }
}

class RegionImage {
  String path;
  String pathURL;
  String baseURL;

  RegionImage({this.path, this.pathURL, this.baseURL});

  RegionImage.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    pathURL = json['pathURL'];
    baseURL = json['baseURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = this.path;
    data['pathURL'] = this.pathURL;
    data['baseURL'] = this.baseURL;
    return data;
  }
}
