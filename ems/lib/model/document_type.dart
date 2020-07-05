class DocumentType {
  bool _status;
  String _msg;
  List<DocumentTypeData> _data;

  DocumentType({bool status, String msg, List<DocumentTypeData> data}) {
    this._status = status;
    this._msg = msg;
    this._data = data;
  }

  bool get status => _status;

  set status(bool status) => _status = status;

  String get msg => _msg;

  set msg(String msg) => _msg = msg;

  List<DocumentTypeData> get data => _data;

  set data(List<DocumentTypeData> data) => _data = data;

  DocumentType.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = new List<DocumentTypeData>();
      json['data'].forEach((v) {
        _data.add(new DocumentTypeData.fromJson(v));
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

class DocumentTypeData {
  String _documentTypeId;
  String _documentType;
  String _createdAt;
  String _updatedAt;

  DocumentTypeData(
      {String documentTypeId,
      String documentType,
      String createdAt,
      String updatedAt}) {
    this._documentTypeId = documentTypeId;
    this._documentType = documentType;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  String get documentTypeId => _documentTypeId;

  set documentTypeId(String documentTypeId) => _documentTypeId = documentTypeId;

  String get documentType => _documentType;

  set documentType(String documentType) => _documentType = documentType;

  String get createdAt => _createdAt;

  set createdAt(String createdAt) => _createdAt = createdAt;

  String get updatedAt => _updatedAt;

  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  DocumentTypeData.fromJson(Map<String, dynamic> json) {
    _documentTypeId = json['document_type_id'];
    _documentType = json['document_type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_type_id'] = this._documentTypeId;
    data['document_type'] = this._documentType;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
