class CreateLocationRequest {
  String name;
  String description;
  // Image Path
  String path;
  Map<String, dynamic> location;
  String placeId;

  CreateLocationRequest({
    this.name,
    this.description,
    this.path,
    this.location,
    this.placeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'path': path,
      'location': location,
      'placeId': placeId,
    };
  }
}
