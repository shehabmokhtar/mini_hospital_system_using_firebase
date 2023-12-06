import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_system/cubit/cubit.dart';
import 'package:hospital_system/cubit/states.dart';
import 'package:hospital_system/models/Appointment_Model.dart';
import 'package:hospital_system/shared/componants/constants.dart';

import '../../shared/componants/componants.dart';
import '../../shared/styles/colors.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Hospital_Cubit, States>(
      listener: (context, state) {
        if (state is CancelAppointment_success_States) {
          Fluttertoast.showToast(
              msg: "Appointment Canceled",
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
          leading: My_BackButton(context: context),
          title: const Text(
            'My Appointments',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
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
              : Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 15,
                  ),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => My_User(
                      context: context,
                      model: cubit(context).Appointments[index],
                      isDoctorApp: false,
                      index: index,
                    ),
                    itemCount: cubit(context).Appointments.length,
                  ),
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
