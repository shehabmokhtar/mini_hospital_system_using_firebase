class UserData_Model {
  String? Name;
  String? email;
  String? password;
  String? phoneNumber;
  String? uID;
  bool? isDoctor;
  String? Profile_Image;
  bool? Gender_IsMale;
  String? Branch;
  String? Address;
  String? Age;

  UserData_Model({
    this.Name,
    this.email,
    this.password,
    this.phoneNumber,
    this.uID,
    this.isDoctor,
    this.Address,
    this.Branch,
    this.Profile_Image,
    this.Age,
    this.Gender_IsMale,
  });

  UserData_Model.fromJson(Map<String, dynamic>? json) {
    Name = json!['Name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    uID = json['uID'];
    isDoctor = json['isDoctor'];
    Address = json['Address'];

    Branch = json['Branch'];
    Gender_IsMale = json['Gender_IsMale'];
    Profile_Image = json['profile_image'];
    Age = json['Age'];
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': Name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'uID': uID,
      'isDoctor': isDoctor,
      'Address': Address,
      'profile_image': Profile_Image,
      'Branch': Branch,
      'Age': Age,
      'Gender_IsMale': Gender_IsMale,
    };
  }
}

class UserData2_Model {
  String? Name;
  String? email;
  String? password;
  String? phoneNumber;
  String? uID;
  bool? isDoctor;
  String? Profile_Image;
  bool? Gender_IsMale;
  String? Branch;
  String? Address;
  String? Age;

  UserData2_Model({
    this.Name,
    this.email,
    this.password,
    this.phoneNumber,
    this.uID,
    this.isDoctor,
    this.Address,
    this.Branch,
    this.Profile_Image,
    this.Age,
    this.Gender_IsMale,
  });

  UserData2_Model.fromJson(Map<String, dynamic>? json) {
    Name = json!['Name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    uID = json['uID'];
    isDoctor = json['isDoctor'];
    Address = json['Address'];

    Branch = json['Branch'];
    Gender_IsMale = json['Gender_IsMale'];
    Profile_Image = json['profile_image'];
    Age = json['Age'];
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': Name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'uID': uID,
      'isDoctor': isDoctor,
      'Address': Address,
      'profile_image': Profile_Image,
      'Branch': Branch,
      'Age': Age,
      'Gender_IsMale': Gender_IsMale,
    };
  }
}
