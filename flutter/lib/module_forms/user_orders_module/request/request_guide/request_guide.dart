class RequestGuideRequest {
  DateTime date;
  String touristUserID;
  String guidUserID;
  String city;
  String language;
  DateTime arriveDate;
  DateTime leaveDate;
  List<String> services;
  String roomID;
  String status;
  int cost;

  RequestGuideRequest({
    this.date,
    this.touristUserID,
    this.guidUserID,
    this.city,
    this.language,
    this.arriveDate,
    this.leaveDate,
    this.services,
    this.roomID,
    this.status,
    this.cost,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = {};
    if (this.date != null) {
      jsonData['date'] = this.date.toIso8601String();
    }
    if (this.touristUserID != null) {
      jsonData['touristUserID'] = this.touristUserID;
    }
    if (this.guidUserID != null) {
      jsonData['guidUserID'] = this.guidUserID;
    }
    if (this.city != null) {
      jsonData['city'] = this.city;
    }
    if (this.language != null) {
      jsonData['language'] = this.language;
    }
    if (this.arriveDate != null) {
      jsonData['arriveDate'] = this.arriveDate.toIso8601String();
    }

    if (this.leaveDate != null) {
      jsonData['leaveDate'] = this.leaveDate.toIso8601String();
    }

    if (this.services != null) {
      jsonData['services '] = this.services;
    }

    if (this.roomID != null) {
      jsonData['roomID'] = this.roomID;
    }

    if (this.status != null) {
      jsonData['status'] = this.status;
    }

    if (this.cost != null) {
      jsonData['cost'] = this.cost;
    }

    return jsonData;
  }
}
