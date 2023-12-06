import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_system/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospital_system/models/Appointment_Model.dart';
import 'package:hospital_system/models/doctorModel.dart';
import 'package:hospital_system/models/models.dart';
import 'package:hospital_system/models/notification_Model.dart';
import 'package:hospital_system/shared/componants/constants.dart';
import '../models/UserModel.dart';
import '../shared/network/local/cache.dart';

class Hospital_Cubit extends Cubit<States> {
  Hospital_Cubit() : super(intial_State());

  static Hospital_Cubit get(context) => BlocProvider.of(context);

// Registeration
  bool isPatient = true;
  void Change_isPatient() {
    isPatient = !isPatient;
    emit(ChangeisPatient_State());
  }

  bool isLoading = false;

  void Change_isLoading() {
    //isLoading = !isLoading;
    isLoading = false;
    emit(ChangeisPatient_State());
  }

  bool isMale = true;
  void DropDown(value) {
    isMale = value;
    emit(ChangeisPatient_State());
  }

  String Branch = '';
  void DropDown2(value) {
    Branch = value;
    emit(ChangeisPatient_State());
  }

  var Auth = FirebaseAuth.instance;
  // Login method
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(login_loding_State());
    Auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      emit(login_success_State(value.user!.uid));
    }).catchError((error) {
      emit(login_error_State());
    });
  }

// Sign Out
  void SignOut() {
    emit(SignOut_Loading_State());
    Auth.signOut().then((value) {
      CacheHelper.clearAll();
      emit(SignOut_Success_State());
    }).catchError((error) {
      emit(SignOut_Error_State());
    });
  }

  var db = FirebaseFirestore.instance;

// Add User in db when registration.
  void createUser({
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
    required String uID,
    required bool Gender_IsMale,
    required String age,
    required String address,
    required String branch,
  }) {
    emit(createUser_loding_State());
    UserData_Model usersModel = UserData_Model(
      Name: userName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      uID: uID,
      isDoctor: isPatient ? false : true,
      Gender_IsMale: Gender_IsMale,
      Age: age,
      Address: address,
      Profile_Image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQf16J-5efOXhOzBJQc8Vx_f96Y2kBZV2JM5su4EX9LFc9yGxlqKWyoJ8TzdOqa-VxFHYk&usqp=CAU',
      Branch: branch,
    );
    db.collection('users').doc(uID).set(usersModel.toMap()).then((value) {
      emit(createUser_success_State(uID));
    }).catchError((error) {
      print('>>>>>>>>>>>>>>>> ${error}');
      emit(createUser_error_State());
    });
  }

// Register method
  void userRegister({
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
    required bool Gender_IsMale,
    required String age,
    required String address,
    required String branch,
  }) {
    emit(register_loding_State());
    Auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      createUser(
          userName: userName,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          uID: value.user!.uid,
          Gender_IsMale: Gender_IsMale,
          age: age,
          address: address,
          branch: branch);

      emit(register_success_State());
    }).catchError((error) {
      print(error.toString());
      emit(register_error_State());
    });
  }

// Get Citites
  List<Cities_Model> cities = [];
  void getCities() {
    emit(getCities_loding_States());
    FirebaseFirestore.instance.collection('cities').get().then((value) {
      value.docs.forEach((element) {
        cities.add(Cities_Model.fromJson(element.data()));
        emit(getCities_success_States());
      });
    }).catchError((e) {
      emit(getCities_error_States());
    });
  }

  String city = '';
  void Change_City(value) {
    city = value;
    emit(ChangeisPatient_State());
  }

// Get Hospitals
  List<Cities_Model> Hospitals = [];
  void getHospitals({
    required String index,
  }) {
    emit(getHospitals_loding_States());
    FirebaseFirestore.instance
        .collection('cities')
        // city == The chose city.
        .doc(city)
        .collection('hospitals')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Hospitals.add(Cities_Model.fromJson(element.data()));
        emit(getHospitals_success_States());
      });
    }).catchError((e) {
      emit(getHospitals_error_States());
    });
  }

  String Hospital = '';
  void Change_Hospital(value) {
    Hospital = value;
    emit(ChangeisPatient_State());
  }

// Get Branches
  List<Cities_Model> Branches = [];
  void getBranches({
    required String index,
  }) {
    // /cities/Istanbul/hospitals/Acibadem International Hospital/branches/Family Medicine/doctors
    emit(getBranches_loding_States());
    FirebaseFirestore.instance
        .collection('cities')
        .doc(city)
        .collection('hospitals')
        .doc(Hospital)
        .collection('branches')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Branches.add(Cities_Model.fromJson(element.data()));
        emit(getBranches_success_States());
      });
    }).catchError((e) {
      emit(getBranches_error_States());
    });
  }

  String branch = '';
  void Change_Branch(value) {
    branch = value;
    emit(ChangeisPatient_State());
  }

// Get Doctor
  List<Doctor_Model> Doctors = [];
  void getDoctor({
    required String index,
  }) {
    emit(getDoctors_loding_States());
    FirebaseFirestore.instance
        //  /cities/Istanbul/hospitals/Acibadem International Hospital/branches/Family Medicine/doctors
        .collection('cities')
        .doc(city)
        .collection('hospitals')
        .doc(Hospital)
        .collection('branches')
        .doc(branch)
        .collection('doctors')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Doctors.add(Doctor_Model.fromJson(element.data()));
        emit(getDoctors_success_States());
      });
    }).catchError((e) {
      emit(getDoctors_success_States());
    });
  }

  String doctor = '';
  void Change_doctor(String value) {
    doctor = value;
    emit(ChangeisPatient_State());
  }

// Choosing Date and Time

  List<String> AppointmentsTime = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
  ];

  int CurrentTimeIndex = 0;
  String selectedTime = '';
  void Chagne_CurrentTimeIndex(int index) {
    CurrentTimeIndex = index;
    emit(ChangeisPatient_State());
  }

  //  String a = AppointmentsTime[CurrentTimeIndex];

  // Selecting date
  DateTime today = DateTime.now();
  String Appointment_Date = '';
  void AppointmentDate(selectedDay, focusedDay) {
    today = selectedDay;
    //  print(today.toString().split(' ')[0]);
    Appointment_Date = today.toString().split(' ')[0];
    emit(ChangeisPatient_State());
  }

  int pageIndex = 0;
  void ChagnePageIndex(value) {
    pageIndex = value;
    emit(ChangeisPatient_State());
  }

// Add appointment to DATABASE
  UserData_Model? userData_Model;
  UserData2_Model? DocotorData_Model;
  Appointment_Model? appointment_model;
  void addAppointment() {
    emit(AddAppointment_loding_States());
    db.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (UID == element.id) {
          userData_Model = UserData_Model.fromJson(element.data());
          print(">>>>>>>> ${userData_Model!.Name}");
        }
        if (doctor == element.id) {
          DocotorData_Model = UserData2_Model.fromJson(element.data());
        }
      });
      Future.delayed(
          const Duration(
            seconds: 2,
          ), () {
        appointment_model = Appointment_Model(
          approved: false,
          doctorID: doctor,
          patientID: UID,
          date: Appointment_Date,
          time: selectedTime,
          doctorImageProfile: DocotorData_Model!.Profile_Image ?? '',
          doctorName: DocotorData_Model!.Name ?? '',
          patientImageProfile: userData_Model!.Profile_Image ?? '',
          patientName: userData_Model!.Name ?? '',
          city: city,
          hospital: Hospital,
          branche: branch,
        );
        db
            .collection('appointments')
            .add(appointment_model!.toMap())
            .then((value) {
          emit(AddAppointment_success_States());
        }).catchError((e) {
          emit(AddAppointment_error_States());
        });
      });
    });
  }

// Get Appointments
  List<Appointment_Model> Appointments = [];
  List<String> AppointmentsID = [];
  Appointment_Model? appointment_modell;
  getAppointments({
    required bool isDoctor,
  }) {
    emit(getAppointments_loding_States());

    db.collection('appointments').snapshots().listen((event) {
      Appointments = [];
      AppointmentsID = [];
      event.docs.forEach((element) {
        appointment_modell = Appointment_Model.fromJson(element.data());
        if (isDoctor) {
          if (appointment_modell!.doctorID == UID) {
            Appointments.add(appointment_modell!);
            AppointmentsID.add(element.id);
          }
        }
        if (!isDoctor) {
          if (appointment_modell!.patientID == UID) {
            Appointments.add(appointment_modell!);
            AppointmentsID.add(element.id);
          }
        }
      });

      emit(getAppointments_success_States());
    });
  }

// Cancel Appointment in patient app and doctor app
  void Cancel_Appointment({
    required String AppointmentID,
  }) {
    emit(CancelAppointment_loding_States());
    FirebaseFirestore.instance
        .collection('appointments')
        .doc(AppointmentID)
        .delete()
        .then((value) {
      emit(CancelAppointment_success_States());
    }).catchError((e) {
      emit(CancelAppointment_error_States());
    });
  }

// Approve appointment fromm doctor app
  ApproveAppointment({
    required String AppointmentID,
    required index,
  }) {
    emit(ApproveAppointment_loding_States());
    Appointment_Model AM = Appointment_Model(
      approved: true,
      doctorID: Appointments[index].doctorID,
      patientID: Appointments[index].patientID,
      date: Appointments[index].date,
      time: Appointments[index].time,
      doctorImageProfile: Appointments[index].doctorImageProfile,
      doctorName: Appointments[index].doctorName,
      patientImageProfile: Appointments[index].patientImageProfile,
      patientName: Appointments[index].patientName,
      city: Appointments[index].city,
      hospital: Appointments[index].hospital,
      branche: Appointments[index].branche,
    );
    FirebaseFirestore.instance
        .collection('appointments')
        .doc(AppointmentID)
        .update(AM.toMap())
        .then((value) {
      emit(ApproveAppointment_success_States());
    }).catchError((e) {
      emit(ApproveAppointment_error_States());
    });
  }

  // Post notification to patient.
  Notification_Model? notification_model;
  void Notification({
    required String patientID,
    required String doctorImageProfile,
    required String doctorName,
    required String messages,
  }) {
    emit(SendNotificationToPatient_loding_States());
    notification_model = Notification_Model(
      doctorImageProfile: doctorImageProfile,
      doctorName: doctorName,
      message: messages,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(patientID)
        .collection('notifications')
        .add(notification_model!.toMap())
        .then((value) {
      emit(SendNotificationToPatient_success_States());
    }).catchError((e) {
      emit(SendNotificationToPatient_error_States());
    });
  }

// Get notification to patient app
  List<Notification_Model> Notifications = [];
  List<String> NotificationsID = [];
  getNotifications() {
    emit(getNotifications_loding_States());
    FirebaseFirestore.instance
        .collection('users')
        .doc(UID)
        .collection('notifications')
        .snapshots()
        .listen((event) {
      Notifications = [];
      NotificationsID = [];
      event.docs.forEach(
        (element) {
          Notifications.add(Notification_Model.fromJson(element.data()));
          NotificationsID.add(element.id);
        },
      );
      emit(getNotifications_success_States());
    });
  }

// Delete Notification
  void deleteNotification({
    required String NotificationID,
  }) {
    emit(deleteNotification_loding_States());
    FirebaseFirestore.instance
        .collection('users')
        .doc(UID)
        .collection('notifications')
        .doc(NotificationID)
        .delete()
        .then((value) {
      emit(deleteNotification_success_States());
    }).catchError((e) {
      emit(deleteNotification_error_States());
    });
  }
}
