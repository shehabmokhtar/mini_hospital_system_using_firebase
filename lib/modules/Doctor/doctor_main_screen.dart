import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_system/cubit/cubit.dart';
import 'package:hospital_system/cubit/states.dart';
import 'package:hospital_system/modules/login_screen.dart';
import 'package:hospital_system/shared/componants/constants.dart';

import '../../shared/componants/componants.dart';
import '../../shared/styles/colors.dart';

class DoctorMainScreen extends StatelessWidget {
  const DoctorMainScreen({super.key});

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
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Appointments',
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                cubit(context).SignOut();
              },
              child: const Center(
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: ConditionalBuilder(
          condition: state is! getAppointments_loding_States,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => cubit(context).Appointments.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Icon(
                        Icons.check_box_outline_blank,
                        size: 100,
                        color: Colors.grey[300],
                      ),
                    ),
                    Text(
                      'There is no appointments',
                      style: TextStyle(
                        color: Colors.grey[350],
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 15,
                        ),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => My_User(
                              context: context,
                              model: cubit(context).Appointments[index],
                              isDoctorApp: true,
                              index: index),
                          itemCount: cubit(context).Appointments.length,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
