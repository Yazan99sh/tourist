import 'package:tourists/module_auth/enums/user_type.dart';

class CreateProfileRequest {
  String userName;
  String userID;
  String story;
  String image;
  String phoneNumber;
  List<String> location;
  List<String> services;
  List<String> languages;
  UserRole role;

  CreateProfileRequest({
    this.userID,
    this.role,
    this.story,
    this.userName,
    this.phoneNumber,
    this.location,
    this.image,
    this.languages,
    this.services,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': this.userID,
      'userID': this.userID,
      'userName': this.userName,
      'name': this.userName,
      'story': this.story,
      'location': this.location,
      'places': this.location,
      'city': this.location,
      'path': this.image,
      'image': this.image,
      'service': this.services,
      'language': this.languages,
      'phoneNumber': this.phoneNumber,
    };
  }
}
