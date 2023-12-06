//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hospital_system/models/Appointment_Model.dart';
import 'package:page_transition/page_transition.dart';

import '../styles/colors.dart';
import 'constants.dart';

void My_NavigatTo({
  required context,
  required nextScreen,
  PageTransitionType type = PageTransitionType.fade,
}) =>
    Navigator.of(context).push(PageTransition(
        child: nextScreen,
        type: type,
        duration: const Duration(
          milliseconds: 100,
        )));

void Navigate_To({
  required BuildContext context,
  required Widget nextScreen,
}) =>
    Navigator.of(context).push(PageTransition(
        child: nextScreen,
        type: PageTransitionType.fade,
        duration: Duration(
          milliseconds: 100,
        )));

void My_NavigatToAndFinish({
  required context,
  required NextScreen,
}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => NextScreen), (route) => false);

Container My_TextFormField({
  required var controller,
  required IconData icon,
  required String labelText,
}) =>
    Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) return 'Must not be empty';
          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.5),
          ),
          prefixIcon: Icon(icon),
        ),
      ),
    );

InkWell My_Button({
  required BuildContext context,
  required String text,
  required Function function,
}) =>
    InkWell(
      onTap: () {
        function();
        // TODO: Login Method
        // TODO: Form key
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.5),
          color: AppColor,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

TextButton My_TextButton({
  required BuildContext context,
  required String text,
  required Function function,
  double fontsize = 11.5,
  Color color = Colors.deepPurple,
}) =>
    TextButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontsize,
            color: color,
          ),
        ));

double height(context) => MediaQuery.of(context).size.height;
double width(context) => MediaQuery.of(context).size.width;

Padding My_User({
  required BuildContext context,
  required Appointment_Model model,
  required bool isDoctorApp,
  required index,
}) {
  return Padding(
    padding: const EdgeInsetsDirectional.symmetric(
      vertical: 10,
    ),
    child: Container(
      padding: const EdgeInsets.all(12.5),
      height: isDoctorApp
          ? 170
          : model.approved!
              ? 180
              : 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black,
          width: 1.3,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 37,
                backgroundImage: NetworkImage(
                  model.doctorImageProfile!,
                ),
              ),
              const SizedBox(
                width: 7.5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isDoctorApp
                          ? 'Mr/Ms.${model.patientName}'
                          : 'Dr.${model.doctorName!}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    if (!isDoctorApp)
                      Text(
                        model.city!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),
                    if (!isDoctorApp)
                      Text(
                        model.hospital!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),
                    if (!isDoctorApp)
                      Text(
                        model.branche!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),
                    Text(
                      model.date!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                    ),
                    Text(
                      model.time!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              if (isDoctorApp)
                Expanded(
                  child: MaterialButton(
                      onPressed: () {
                        if (!model.approved!) {
                          cubit(context).ApproveAppointment(
                            AppointmentID: cubit(context).AppointmentsID[index],
                            index: index,
                          );
                          if (isDoctorApp) {
                            cubit(context).Notification(
                                patientID: model.patientID!,
                                doctorImageProfile: model.doctorImageProfile!,
                                doctorName: model.doctorName!,
                                messages: 'Your appointment approved');
                          }
                        }
                      },
                      child: Container(
                        height: 43,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        child: Center(
                            child: Text(
                          model.approved! ? 'Apporved' : 'Approve',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      )),
                ),
              if (!model.approved!)
                Expanded(
                  child: MaterialButton(
                      onPressed: () {
                        cubit(context).Cancel_Appointment(
                            AppointmentID:
                                cubit(context).AppointmentsID[index]);
                        if (isDoctorApp) {
                          cubit(context).Notification(
                              patientID: model.patientID!,
                              doctorImageProfile: model.doctorImageProfile!,
                              doctorName: model.doctorName!,
                              messages: 'Your appointment canceled');
                        }
                      },
                      child: Container(
                        height: 43,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        child: Center(
                            child: Text(
                          isDoctorApp ? 'Cancel' : 'Cancel Appointment',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      )),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}

IconButton My_BackButton({
  required BuildContext context,
  //  bool isAppColor = true,
}) =>
    IconButton(
        onPressed: () {
          Navigator.pop(context);
          cubit(context).city = '';
          cubit(context).Hospital = '';
          cubit(context).branch = '';
          cubit(context).doctor = '';
          cubit(context).Appointment_Date = '';
          cubit(context).selectedTime = '';
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 30,
        ));

Widget My_LinerIndicator() => const Padding(
    padding: EdgeInsets.symmetric(
      vertical: 5,
    ),
    child: LinearProgressIndicator());
