class AcceptedOrder {
  String statusCode;
  String msg;
  List<Data> data;

  AcceptedOrder({this.statusCode, this.msg, this.data});

  AcceptedOrder.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  Date date;
  Order order;
  String touristUserID;
  String guidUserID;
  String cost;
  String status;
  String uuid;

  Data(
      {this.id,
      this.date,
      this.order,
      this.touristUserID,
      this.guidUserID,
      this.cost,
      this.status,
      this.uuid});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    touristUserID = json['touristUserID'];
    guidUserID = json['guidUserID'];
    cost = json['cost'];
    status = json['status'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    data['touristUserID'] = this.touristUserID;
    data['guidUserID'] = this.guidUserID;
    data['cost'] = this.cost;
    data['status'] = this.status;
    data['uuid'] = this.uuid;
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

class Order {
  int id;
  Date date;
  String touristUserID;
  String guidUserID;
  String city;
  String language;
  Date arriveDate;
  Date leaveDate;
  List<String> services;
  String cost;
  String roomID;
  String uuid;
  String status;

  Order(
      {this.id,
      this.date,
      this.touristUserID,
      this.guidUserID,
      this.city,
      this.language,
      this.arriveDate,
      this.leaveDate,
      this.services,
      this.cost,
      this.roomID,
      this.status,
      this.uuid});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    touristUserID = json['touristUserID'];
    guidUserID = json['guidUserID'];
    city = json['city'];
    language = json['language'];
    arriveDate = json['arriveDate'] != null
        ? new Date.fromJson(json['arriveDate'])
        : null;
    leaveDate =
        json['leaveDate'] != null ? new Date.fromJson(json['leaveDate']) : null;
    services = json['services'].cast<String>();
    cost = json['cost'];
    roomID = json['roomID'];
    status = json['status'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    data['touristUserID'] = this.touristUserID;
    data['guidUserID'] = this.guidUserID;
    data['city'] = this.city;
    data['language'] = this.language;
    if (this.arriveDate != null) {
      data['arriveDate'] = this.arriveDate.toJson();
    }
    if (this.leaveDate != null) {
      data['leaveDate'] = this.leaveDate.toJson();
    }
    data['services'] = this.services;
    data['cost'] = this.cost;
    data['roomID'] = this.roomID;
    data['status'] = this.status;
    return data;
  }
}
