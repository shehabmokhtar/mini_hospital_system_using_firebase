import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_system/cubit/cubit.dart';
import 'package:hospital_system/cubit/states.dart';
import 'package:hospital_system/modules/Patient/Patient_main_screen.dart';
import 'package:hospital_system/modules/register_screen.dart';
import 'package:hospital_system/shared/componants/componants.dart';
import 'package:hospital_system/shared/componants/constants.dart';
import 'package:hospital_system/shared/network/local/cache.dart';
import 'package:page_transition/page_transition.dart';

import '../shared/styles/colors.dart';
import 'Doctor/doctor_main_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailAddress_Controller = TextEditingController();
  var password_Controller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Hospital_Cubit cubit = Hospital_Cubit.get(context);
    return BlocConsumer<Hospital_Cubit, States>(
      listener: (context, state) {
        if (state is login_success_State) {
          CacheHelper.SaveData(
            key: 'UID',
            value: state.uID,
          ).then((value) {
            CacheHelper.SaveData(
              key: 'APP',
              value: emailAddress_Controller.text.contains('doctor')
                  ? 'doctor'
                  : 'pat',
            );
            My_NavigatToAndFinish(
                context: context,
                NextScreen: emailAddress_Controller.text.contains('doctor')
                    ? DoctorMainScreen()
                    : PatientMainScreen());
          });
          Future.delayed(
              const Duration(
                seconds: 2,
              ), () {
            cubit.getAppointments(isDoctor: true);
          });
          Fluttertoast.showToast(
              msg: "Login successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor,
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: AppColor,
                  child: const Center(
                    child: Text(
                      'H',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 200,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(25),
                        topEnd: Radius.circular(25),
                      )),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 90,
                            ),
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            My_TextFormField(
                              controller: emailAddress_Controller,
                              icon: Icons.email,
                              labelText: 'Email Address',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            My_TextFormField(
                              controller: password_Controller,
                              icon: Icons.lock,
                              labelText: 'Password',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (state is login_loding_State)
                              My_LinerIndicator(),
                            My_Button(
                              context: context,
                              text: 'Login',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                    email: emailAddress_Controller.text,
                                    password: password_Controller.text,
                                  );
                                }
                              },
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Don\'t have an account',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      My_NavigatTo(
                                          context: context,
                                          nextScreen: RegisterScreen(),
                                          type: PageTransitionType.rightToLeft);
                                    },
                                    child: const Text(
                                      'Register Now',
                                      style: TextStyle(
                                        fontSize: 11.5,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
