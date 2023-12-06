import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_system/cubit/cubit.dart';
import 'package:hospital_system/cubit/states.dart';
import 'package:hospital_system/shared/componants/componants.dart';
import 'package:page_transition/page_transition.dart';

import '../shared/network/local/cache.dart';
import '../shared/styles/colors.dart';
import 'Doctor/doctor_main_screen.dart';
import 'Patient/Patient_main_screen.dart';

class RegisterScreen extends StatelessWidget {
  var emailAddress_Controller = TextEditingController();
  var password_Controller = TextEditingController();
  var ID_Controller = TextEditingController();
  var Name_Controller = TextEditingController();
  var Gender_Controller = TextEditingController();
  var PhoneNumber_Controller = TextEditingController();
  var Branch_Controller = TextEditingController();
  var Age_Controller = TextEditingController();
  var Address_Controller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Hospital_Cubit cubit = Hospital_Cubit.get(context);
    return BlocConsumer<Hospital_Cubit, States>(
        listener: (context, state) {
          if (state is register_success_State) {
            cubit.userLogin(
                email: emailAddress_Controller.text,
                password: password_Controller.text);
          }
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

            cubit.Change_isLoading();
          }
        },
        builder: (context, state) => Scaffold(
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
                                // SizedBox(
                                //   height: 50,
                                //   width: double.infinity,
                                //   child: Row(children: [
                                //     Container(
                                //       height: 33,
                                //       width: 80,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //         color: cubit.isPatient
                                //             ? Colors.deepPurple.withOpacity(.3)
                                //             : Colors.white,
                                //       ),
                                //       child: My_TextButton(
                                //         context: context,
                                //         text: 'Patient',
                                //         function: () {
                                //           if (!cubit.isPatient) {
                                //             cubit.Change_isPatient();
                                //           }
                                //         },
                                //         fontsize: 15,
                                //         color: cubit.isPatient
                                //             ? Colors.white
                                //             : AppColor,
                                //       ),
                                //     ),
                                //     const Spacer(),
                                //     Container(
                                //       height: 33,
                                //       width: 80,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //         color: !cubit.isPatient
                                //             ? Colors.deepPurple.withOpacity(.3)
                                //             : Colors.white,
                                //       ),
                                //       child: My_TextButton(
                                //         context: context,
                                //         text: 'Doctor',
                                //         function: () {
                                //           if (cubit.isPatient) {
                                //             cubit.Change_isPatient();
                                //           }
                                //         },
                                //         fontsize: 15,
                                //         color: !cubit.isPatient
                                //             ? Colors.white
                                //             : AppColor,
                                //       ),
                                //     ),
                                //   ]),
                                // ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Center(
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 33,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                My_TextFormField(
                                  controller: ID_Controller,
                                  icon: Icons.numbers,
                                  labelText: 'ID',
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                My_TextFormField(
                                  controller: Name_Controller,
                                  icon: Icons.person,
                                  labelText: 'Name',
                                ),
                                const SizedBox(
                                  height: 15,
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
                                  height: 15,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<bool>(
                                        hint: const Text('Gender'),
                                        value: cubit.isMale ? true : false,
                                        isExpanded: true,
                                        dropdownColor: Colors.white,
                                        iconSize: 32,
                                        iconEnabledColor: Colors.black,
                                        items: const [
                                          DropdownMenuItem(
                                              value: true, child: Text('Male')),
                                          DropdownMenuItem(
                                              value: false,
                                              child: Text('Female')),
                                        ],
                                        onChanged: (value) {
                                          cubit.DropDown(value);
                                        }),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                if (cubit.isPatient)
                                  My_TextFormField(
                                    controller: Age_Controller,
                                    icon: Icons.calendar_view_day,
                                    labelText: 'Age',
                                  ),
                                if (cubit.isPatient)
                                  const SizedBox(
                                    height: 15,
                                  ),
                                if (cubit.isPatient)
                                  My_TextFormField(
                                    controller: Address_Controller,
                                    icon: Icons.home,
                                    labelText: 'Address',
                                  ),
                                if (cubit.isPatient)
                                  const SizedBox(
                                    height: 15,
                                  ),
                                My_TextFormField(
                                  controller: PhoneNumber_Controller,
                                  icon: Icons.phone,
                                  labelText: 'Phone Number',
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                if (!cubit.isPatient)
                                  My_TextFormField(
                                    controller: Branch_Controller,
                                    icon: Icons.brightness_1_outlined,
                                    labelText: 'Branch',
                                  ),
                                const SizedBox(
                                  height: 15,
                                ),
                                if (cubit.isLoading) My_LinerIndicator(),
                                My_Button(
                                    context: context,
                                    text: 'Register',
                                    function: () {
                                      cubit.isLoading = true;
                                      if (formKey.currentState!.validate()) {
                                        cubit.userRegister(
                                          userName: Name_Controller.text,
                                          email: emailAddress_Controller.text,
                                          password: password_Controller.text,
                                          phoneNumber:
                                              PhoneNumber_Controller.text,
                                          Gender_IsMale: cubit.isMale,
                                          age: Age_Controller.text == null
                                              ? ''
                                              : Age_Controller.text,
                                          address:
                                              Address_Controller.text == null
                                                  ? ''
                                                  : Address_Controller.text,
                                          branch: Branch_Controller.text == null
                                              ? ''
                                              : Branch_Controller.text,
                                        );
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
