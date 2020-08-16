class Urls {
  static final _baseAPI = 'http://35.228.120.165/';

  static final loginAPI = _baseAPI + 'login';
  static final loginGuideAPI = _baseAPI + 'guid';
  static final createProfileAPI = _baseAPI + 'tourist';
  static final getProfileAPI = _baseAPI + 'tourist';
  static final locationList = _baseAPI + 'regions';
  static final locationDetails = _baseAPI + 'region/';
  static final guideList = _baseAPI + 'guides';
  static final guidesByRegion = _baseAPI + 'guid';
  static final orderGuide = _baseAPI + 'order';
  static final orderLookup = _baseAPI + 'orderlookup';
  static final acceptOrder = _baseAPI + 'acceptorder';
  static final updateOrder = _baseAPI + 'orderUpdate';
  static final comment = _baseAPI + 'comment';
  static final event = _baseAPI + 'event';
  static final rate = _baseAPI + 'rating';
}