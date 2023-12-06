import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_system/modules/Patient/booking/Book_an_appointment.dart';
import 'package:hospital_system/modules/Patient/my_appointments.dart';
import 'package:hospital_system/modules/Patient/notification_screen.dart';
import 'package:hospital_system/shared/componants/constants.dart';
import 'package:page_transition/page_transition.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../shared/componants/componants.dart';
import '../../shared/styles/colors.dart';
import '../login_screen.dart';

class PatientMainScreen extends StatelessWidget {
  const PatientMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Hospital_Cubit, States>(
      listener: (context, state) {
        if (state is SignOut_Success_State) {
          My_NavigatToAndFinish(context: context, NextScreen: LoginScreen());
          Fluttertoast.showToast(
              msg: "Logout successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          actions: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Hospital',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Badge.count(
              alignment: const AlignmentDirectional(30, 10),
              count: cubit(context).Notifications.length,
              isLabelVisible:
                  cubit(context).Notifications.isEmpty ? false : true,
              backgroundColor: Colors.red,
              child: IconButton(
                  onPressed: () {
                    cubit(context).getNotifications();
                    My_NavigatTo(
                      context: context,
                      nextScreen: const NotificationScreen(),
                      type: PageTransitionType.rightToLeft,
                    );
                  },
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                    size: 35,
                  )),
            ),
            const SizedBox(
              width: 12.5,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'H',
                      style: TextStyle(
                        color: AppColor,
                        fontSize: 200,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Item(
                        context: context,
                        title: 'Book An Appointment',
                        onTap: () {
                          cubit(context).getCities();
                          My_NavigatTo(
                            context: context,
                            nextScreen: BookAnAppointmentScreen(),
                            type: PageTransitionType.rightToLeft,
                          );
                        }),
                    Item(
                        context: context,
                        title: 'My Appointments',
                        onTap: () {
                          cubit(context).getAppointments(
                            isDoctor: false,
                          );
                          My_NavigatTo(
                            context: context,
                            nextScreen: const MyAppointmentsScreen(),
                            type: PageTransitionType.rightToLeft,
                          );
                        }),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: InkWell(
                        onTap: () {
                          cubit(context).SignOut();
                        },
                        child: const Center(
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding Item({
    required BuildContext context,
    required String title,
    required Function onTap,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: 8,
      ),
      child: SizedBox(
        height: 130,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            InkWell(
              onTap: () {
                onTap();
              },
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                height: 115,
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
