class UpdateOrderRequest {
  String date;
  String touristUserID;
  String guidUserID;
  String city;
  String language;
  String arriveDate;
  String leaveDate;
  String status;
  List<String> services;
  String orderID;
  int id;
  int cost;
  String roomID;

  UpdateOrderRequest(
      {this.date,
      this.touristUserID,
      this.guidUserID,
      this.city,
      this.language,
      this.arriveDate,
      this.leaveDate,
      this.status,
      this.services,
      this.id,
      this.cost,
      this.roomID,
      this.orderID});

  UpdateOrderRequest.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    touristUserID = json['touristUserID'];
    guidUserID = json['guidUserID'];
    city = json['city'];
    language = json['language'];
    arriveDate = json['arriveDate'];
    leaveDate = json['leaveDate'];
    status = json['status'];
    services = json['services'].cast<String>();
    id = json['id'];
    cost = json['cost'];
    roomID = json['roomID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.date != null) {
      data['date'] = this.date;
    }
    if (this.touristUserID != null) {
      data['touristUserID'] = this.touristUserID;
    }
    if (this.guidUserID != null) {
      data['guidUserID'] = this.guidUserID;
    }
    if (this.city != null) {
      data['city'] = this.city;
    }
    if (this.language != null) {
      data['language'] = this.language;
    }
    if (this.arriveDate != null) {
      data['arriveDate'] = this.arriveDate;
    }
    if (this.leaveDate != null) {
      data['leaveDate'] = this.leaveDate;
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.services != null) {
      data['services'] = this.services;
    }
    if (this.orderID != null) {
      data['orderID'] = this.orderID;
    }
    if (this.cost != null) {
      data['cost'] = this.cost;
    }
    if (this.roomID != null) {
      data['roomID'] = this.roomID;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    return data;
  }
}
