class OldLeave {
  bool _status;
  List<OldLeaveData> _data;

  OldLeave({bool status, List<OldLeaveData> data}) {
    this._status = status;
    this._data = data;
  }

  bool get status => _status;

  set status(bool status) => _status = status;

  List<OldLeaveData> get data => _data;

  set data(List<OldLeaveData> data) => _data = data;

  OldLeave.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = new List<OldLeaveData>();
      json['data'].forEach((v) {
        _data.add(new OldLeaveData.fromJson(v));
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

class OldLeaveData {
  String _leaveId;
  String _fname;
  String _lname;
  String _leaveType;
  String _description;
  String _fromDate;
  String _toDate;
  String _status;

  OldLeaveData(
      {String leaveId,
      String fname,
      String lname,
      String leaveType,
      String description,
      String fromDate,
      String toDate,
      String status}) {
    this._leaveId = leaveId;
    this._fname = fname;
    this._lname = lname;
    this._leaveType = leaveType;
    this._description = description;
    this._fromDate = fromDate;
    this._toDate = toDate;
    this._status = status;
  }

  String get leaveId => _leaveId;

  set leaveId(String leaveId) => _leaveId = leaveId;

  String get fname => _fname;

  set fname(String fname) => _fname = fname;

  String get lname => _lname;

  set lname(String lname) => _lname = lname;

  String get leaveType => _leaveType;

  set leaveType(String leaveType) => _leaveType = leaveType;

  String get description => _description;

  set description(String description) => _description = description;

  String get fromDate => _fromDate;

  set fromDate(String fromDate) => _fromDate = fromDate;

  String get toDate => _toDate;

  set toDate(String toDate) => _toDate = toDate;

  String get status => _status;

  set status(String status) => _status = status;

  OldLeaveData.fromJson(Map<String, dynamic> json) {
    _leaveId = json['leave_id'];
    _fname = json['fname'];
    _lname = json['lname'];
    _leaveType = json['leave_type'];
    _description = json['description'];
    _fromDate = json['from_date'];
    _toDate = json['to_date'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_id'] = this._leaveId;
    data['fname'] = this._fname;
    data['lname'] = this._lname;
    data['leave_type'] = this._leaveType;
    data['description'] = this._description;
    data['from_date'] = this._fromDate;
    data['to_date'] = this._toDate;
    data['status'] = this._status;
    return data;
  }
}
