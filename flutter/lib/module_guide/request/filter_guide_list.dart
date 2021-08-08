class FilterGuideListRequest {
  String language;
  String city;
  FilterGuideListRequest({
    this.language,
    this.city,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.city != null) {
      data['city'] = this.city;
    }
    if (this.language != null) {
      data['language'] = this.language;
    }
    return data;
  }
}
