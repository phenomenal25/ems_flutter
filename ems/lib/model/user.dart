class User {
  bool _status;
  List<Data> _data;

  User({bool status, List<Data> data}) {
    this._status = status;
    this._data = data;
  }

  bool get status => _status;
  set status(bool status) => _status = status;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  User.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
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

class Data {
  String _employeeId;
  String _fname;
  String _lname;
  String _image;
  String _contact;
  String _gender;
  String _email;
  String _password;
  String _birthdate;
  String _joindate;
  String _departmentName;
  String _designationName;
  String _roleType;
  String _street;
  String _area;
  String _city;
  String _state;
  String _country;

  Data(
      {String employeeId,
      String fname,
      String lname,
      String image,
      String contact,
      String gender,
      String email,
      String password,
      String birthdate,
      String joindate,
      String departmentName,
      String designationName,
      String roleType,
      String street,
      String area,
      String city,
      String state,
      String country}) {
    this._employeeId = employeeId;
    this._fname = fname;
    this._lname = lname;
    this._image = image;
    this._contact = contact;
    this._gender = gender;
    this._email = email;
    this._password = password;
    this._birthdate = birthdate;
    this._joindate = joindate;
    this._departmentName = departmentName;
    this._designationName = designationName;
    this._roleType = roleType;
    this._street = street;
    this._area = area;
    this._city = city;
    this._state = state;
    this._country = country;
  }

  String get employeeId => _employeeId;
  set employeeId(String employeeId) => _employeeId = employeeId;
  String get fname => _fname;
  set fname(String fname) => _fname = fname;
  String get lname => _lname;
  set lname(String lname) => _lname = lname;
  String get image => _image;
  set image(String image) => _image = image;
  String get contact => _contact;
  set contact(String contact) => _contact = contact;
  String get gender => _gender;
  set gender(String gender) => _gender = gender;
  String get email => _email;
  set email(String email) => _email = email;
  String get password => _password;
  set password(String password) => _password = password;
  String get birthdate => _birthdate;
  set birthdate(String birthdate) => _birthdate = birthdate;
  String get joindate => _joindate;
  set joindate(String joindate) => _joindate = joindate;
  String get departmentName => _departmentName;
  set departmentName(String departmentName) => _departmentName = departmentName;
  String get designationName => _designationName;
  set designationName(String designationName) =>
      _designationName = designationName;
  String get roleType => _roleType;
  set roleType(String roleType) => _roleType = roleType;
  String get street => _street;
  set street(String street) => _street = street;
  String get area => _area;
  set area(String area) => _area = area;
  String get city => _city;
  set city(String city) => _city = city;
  String get state => _state;
  set state(String state) => _state = state;
  String get country => _country;
  set country(String country) => _country = country;

  Data.fromJson(Map<String, dynamic> json) {
    _employeeId = json['employee_id'];
    _fname = json['fname'];
    _lname = json['lname'];
    _image = json['image'];
    _contact = json['contact'];
    _gender = json['gender'];
    _email = json['email'];
    _password = json['password'];
    _birthdate = json['birthdate'];
    _joindate = json['joindate'];
    _departmentName = json['department_name'];
    _designationName = json['designation_name'];
    _roleType = json['role_type'];
    _street = json['street'];
    _area = json['area'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this._employeeId;
    data['fname'] = this._fname;
    data['lname'] = this._lname;
    data['image'] = this._image;
    data['contact'] = this._contact;
    data['gender'] = this._gender;
    data['email'] = this._email;
    data['password'] = this._password;
    data['birthdate'] = this._birthdate;
    data['joindate'] = this._joindate;
    data['department_name'] = this._departmentName;
    data['designation_name'] = this._designationName;
    data['role_type'] = this._roleType;
    data['street'] = this._street;
    data['area'] = this._area;
    data['city'] = this._city;
    data['state'] = this._state;
    data['country'] = this._country;
    return data;
  }
}
