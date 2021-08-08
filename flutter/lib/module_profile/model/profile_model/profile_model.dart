import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';

class ProfileModel {
  String name;
  String image;
  String phone;
  List<String> locations = <String>[];
  List<String> languages = <String>[];
  List<String> services = <String>[];
  List<LocationListItem> availableLocations = <LocationListItem>[];
  String imageUrl;
  bool imageUpdated;
  ProfileModel(
      {this.name,
      this.image,
      this.locations,
      this.languages,
      this.availableLocations,
      this.phone,
      this.services,
      this.imageUrl,
      this.imageUpdated}) {
    if (this.languages == null) {
      this.languages = [];
    }
    if (this.locations == null) {
      this.locations = [];
    }
    if (this.services == null) {
      this.services = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['image'] = this.image;
    data['languages'] = languages;
    data['city'] = locations;
    return data;
  }
}
