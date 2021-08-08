class OrderModel {
  String guideUserID;
  String touristId;
  String cost;
  String status;
  List<String> services;
  DateTime arriveDate;
  DateTime leaveDate;
  DateTime date;
  String roomId;
  int id;
  String language;
  String city;

  OrderModel(
      {this.guideUserID,
        this.touristId,
        this.cost,
        this.roomId,
        this.id,
        this.city,
        this.language,
        this.status,
        this.date,
        this.services,
        this.arriveDate,
        this.leaveDate});

}
