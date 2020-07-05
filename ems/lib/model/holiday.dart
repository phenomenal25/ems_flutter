class HolidayListModel {
  bool status;
  String msg;
  List<HolidayData> data;

  HolidayListModel({this.status, this.msg, this.data});

  HolidayListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<HolidayData>();
      json['data'].forEach((v) {
        data.add(new HolidayData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HolidayData {
  String holidayId;
  String holidayTitle;
  String date;
  String createdAt;
  String updatedAt;

  HolidayData(
      {this.holidayId,
      this.holidayTitle,
      this.date,
      this.createdAt,
      this.updatedAt});

  HolidayData.fromJson(Map<String, dynamic> json) {
    holidayId = json['holiday_id'];
    holidayTitle = json['holiday_title'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holiday_id'] = this.holidayId;
    data['holiday_title'] = this.holidayTitle;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
