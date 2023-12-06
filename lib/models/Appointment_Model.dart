import 'package:hospital_system/modules/Patient/booking/1.dart';

class Appointment_Model {
  String? doctorID;
  String? doctorImageProfile;
  String? doctorName;
  String? patientID;
  String? patientImageProfile;
  String? patientName;
  String? city;
  String? hospital;
  String? branche;
  String? date;
  String? time;
  bool? approved;

  Appointment_Model({
    this.doctorID,
    this.doctorImageProfile,
    this.doctorName,
    this.patientID,
    this.patientImageProfile,
    this.patientName,
    this.city,
    this.hospital,
    this.date,
    this.time,
    this.branche,
    this.approved,
  });

  Appointment_Model.fromJson(Map<String, dynamic>? json) {
    doctorID = json!['doctorID'];
    patientID = json['patientID'];
    patientName = json['patientName'];
    doctorName = json['doctorName'];
    patientImageProfile = json['patientImageProfile'];
    doctorImageProfile = json['doctorImageProfile'];
    approved = json['approved'];
    branche = json['branche'];
    city = json['city'];
    hospital = json['hospital'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorID': doctorID,
      'patientID': patientID,
      'date': date,
      'time': time,
      'city': city,
      'approved': approved,
      'hospital': hospital,
      'branche': branche,
      'doctorImageProfile': doctorImageProfile,
      'patientImageProfile': patientImageProfile,
      'doctorName': doctorName,
      'patientName': patientName,
    };
  }
}
