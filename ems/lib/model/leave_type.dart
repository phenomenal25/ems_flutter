class LeaveType {
  bool status;
  String msg;
  List<LeaveTypeData> data;

  LeaveType({this.status, this.msg, this.data});

  LeaveType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<LeaveTypeData>();
      json['data'].forEach((v) {
        data.add(new LeaveTypeData.fromJson(v));
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

class LeaveTypeData {
  String leaveTypeId;
  String leaveType;
  String createdAt;
  String updatedAt;

  LeaveTypeData(
      {this.leaveTypeId, this.leaveType, this.createdAt, this.updatedAt});

  LeaveTypeData.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['leave_type_id'];
    leaveType = json['leave_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_type_id'] = this.leaveTypeId;
    data['leave_type'] = this.leaveType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
