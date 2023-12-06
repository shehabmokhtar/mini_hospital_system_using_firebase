class Notification_Model {
  String? doctorImageProfile;
  String? doctorName;
  String? message;

  Notification_Model({
    this.doctorImageProfile,
    this.doctorName,
    this.message,
  });

  Notification_Model.fromJson(Map<String, dynamic>? json) {
    doctorName = json!['doctorName'];
    message = json['message'];
    doctorImageProfile = json['doctorImageProfile'];
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorImageProfile': doctorImageProfile,
      'message': message,
      'doctorName': doctorName,
    };
  }
}
