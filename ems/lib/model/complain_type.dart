class ComplainType {
  bool _status;
  String _msg;
  List<ComplainTypeData> _data;

  ComplainType({bool status, String msg, List<ComplainTypeData> data}) {
    this._status = status;
    this._msg = msg;
    this._data = data;
  }

  bool get status => _status;
  set status(bool status) => _status = status;
  String get msg => _msg;
  set msg(String msg) => _msg = msg;
  List<ComplainTypeData> get data => _data;
  set data(List<ComplainTypeData> data) => _data = data;

  ComplainType.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = new List<ComplainTypeData>();
      json['data'].forEach((v) {
        _data.add(new ComplainTypeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComplainTypeData {
  String _complainTypeId;
  String _complainType;
  String _createdAt;
  String _updatedAt;

  ComplainTypeData(
      {String complainTypeId,
      String complainType,
      String createdAt,
      String updatedAt}) {
    this._complainTypeId = complainTypeId;
    this._complainType = complainType;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  String get complainTypeId => _complainTypeId;
  set complainTypeId(String complainTypeId) => _complainTypeId = complainTypeId;
  String get complainType => _complainType;
  set complainType(String complainType) => _complainType = complainType;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  ComplainTypeData.fromJson(Map<String, dynamic> json) {
    _complainTypeId = json['complain_type_id'];
    _complainType = json['complain_type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['complain_type_id'] = this._complainTypeId;
    data['complain_type'] = this._complainType;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
