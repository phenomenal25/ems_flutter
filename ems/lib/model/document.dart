class Document {
  bool _status;
  List<DocumentData> _data;

  Document({bool status, List<DocumentData> data}) {
    this._status = status;
    this._data = data;
  }

  bool get status => _status;
  set status(bool status) => _status = status;
  List<DocumentData> get data => _data;
  set data(List<DocumentData> data) => _data = data;

  Document.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = new List<DocumentData>();
      json['data'].forEach((v) {
        _data.add(new DocumentData.fromJson(v));
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

class DocumentData {
  String _fname;
  String _lname;
  String _documentType;
  String _date;
  String _status;

  DocumentData(
      {String fname,
        String lname,
        String documentType,
        String date,
        String status}) {
    this._fname = fname;
    this._lname = lname;
    this._documentType = documentType;
    this._date = date;
    this._status = status;
  }

  String get fname => _fname;
  set fname(String fname) => _fname = fname;
  String get lname => _lname;
  set lname(String lname) => _lname = lname;
  String get documentType => _documentType;
  set documentType(String documentType) => _documentType = documentType;
  String get date => _date;
  set date(String date) => _date = date;
  String get status => _status;
  set status(String status) => _status = status;

  DocumentData.fromJson(Map<String, dynamic> json) {
    _fname = json['fname'];
    _lname = json['lname'];
    _documentType = json['document_type'];
    _date = json['date'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this._fname;
    data['lname'] = this._lname;
    data['document_type'] = this._documentType;
    data['date'] = this._date;
    data['status'] = this._status;
    return data;
  }
}
