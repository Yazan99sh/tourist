class GuideListItemModel {
  int id;
  String user;
  String userID;
  String name;
  String status;
  List<String> city;
  List<String> language;
  double rating;
  String image;
  List<Regions> regions;

  GuideListItemModel(
      {this.id,
        this.user,
        this.userID,
        this.name,
        this.status,
        this.city,
        this.language,
        this.rating,
        this.image,
        this.regions});

  GuideListItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    userID = json['userID'];
    name = json['name'];
    status = json['status'];
    city = json['city']?.cast<String>();
    language = json['language']?.cast<String>();
    rating = double.parse(json['rating'] ?? '0');
    image = json['image'];
    if (json['regions'] != null) {
      regions = <Regions>[];
      json['regions'].forEach((v) {
        regions.add(new Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user'] = this.user;
    data['userID'] = this.userID;
    data['name'] = this.name;
    data['status'] = this.status;
    data['city'] = this.city;
    data['language'] = this.language;
    data['rating'] = this.rating;
    data['image'] = this.image;
    if (this.regions != null) {
      data['regions'] = this.regions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Regions {
  int id;
  String name;
  String description;
  List<String> location;
  String placeId;

  Regions({this.id, this.name, this.description, this.location, this.placeId});

  Regions.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    id = json['id'];
    name = json['name'];
    description = json['description'];
    location = json['location']?.cast<String>();
    placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location'] = this.location;
    data['placeId'] = this.placeId;
    return data;
  }
}