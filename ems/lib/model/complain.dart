class Complain {
  bool _status;
  List<ComplainData> _data;

  Complain({bool status, List<ComplainData> data}) {
    this._status = status;
    this._data = data;
  }

  bool get status => _status;
  set status(bool status) => _status = status;
  List<ComplainData> get data => _data;
  set data(List<ComplainData> data) => _data = data;

  Complain.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = new List<ComplainData>();
      json['data'].forEach((v) {
        _data.add(new ComplainData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComplainData {
  String _fname;
  String _lname;
  String _complainType;
  String _date;
  String _description;

  ComplainData(
      {String fname,
      String lname,
      String complainType,
      String date,
      String description}) {
    this._fname = fname;
    this._lname = lname;
    this._complainType = complainType;
    this._date = date;
    this._description = description;
  }

  String get fname => _fname;
  set fname(String fname) => _fname = fname;
  String get lname => _lname;
  set lname(String lname) => _lname = lname;
  String get complainType => _complainType;
  set complainType(String complainType) => _complainType = complainType;
  String get date => _date;
  set date(String date) => _date = date;
  String get description => _description;
  set description(String description) => _description = description;

  ComplainData.fromJson(Map<String, dynamic> json) {
    _fname = json['fname'];
    _lname = json['lname'];
    _complainType = json['complain_type'];
    _date = json['date'];
    _description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this._fname;
    data['lname'] = this._lname;
    data['complain_type'] = this._complainType;
    data['date'] = this._date;
    data['description'] = this._description;
    return data;
  }
}
