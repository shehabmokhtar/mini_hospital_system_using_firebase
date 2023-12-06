import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_system/cubit/cubit.dart';
import 'package:hospital_system/cubit/states.dart';
import 'package:hospital_system/modules/Patient/booking/1.dart';
import 'package:hospital_system/shared/componants/componants.dart';
import 'package:hospital_system/shared/componants/constants.dart';
import 'package:hospital_system/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAnAppointmentScreen extends StatelessWidget {
  var pageController = PageController();
  List pages = [
    CityScreen(),
    HospitalsScreen(),
    BranchesScreen(),
    DoctorsScreen(),
    DateTimeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Hospital_Cubit, States>(
      listener: (context, state) {
        if (state is AddAppointment_success_States) {
          cubit(context).city = '';
          cubit(context).Hospital = '';
          cubit(context).branch = '';
          cubit(context).doctor = '';
          cubit(context).Appointment_Date = '';
          cubit(context).selectedTime = '';
          Navigator.pop(context);
          cubit(context).Change_isLoading();
          Fluttertoast.showToast(
              msg: "Appointment Added",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: My_BackButton(context: context),
        ),
        body: ConditionalBuilder(
          //       condition: state is! getCities_loding_States,
          // condition: true,
          condition: state is! getCities_loding_States &&
                  cubit(context).cities.isNotEmpty ||
              state is! getHospitals_success_States,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 20,
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.all(10),
                      child: pages[index],
                    ),
                    onPageChanged: (value) {},
                    itemCount: pages.length,
                  ),
                ),
                if (!cubit(context).isLoading)
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                    ),
                    child: My_Button(
                        context: context,
                        function: () {
                          if (cubit(context).selectedTime != '') {
                            cubit(context).isLoading = true;
                            cubit(context).addAppointment();
                          }
                          if (cubit(context).isLoading == false) {
                            if (cubit(context).city != '') {
                              cubit(context).getHospitals(
                                index: cubit(context).city,
                              );
                            }
                            if (cubit(context).Hospital != '') {
                              cubit(context).getBranches(
                                index: cubit(context).city,
                              );
                            }
                            if (cubit(context).branch != '') {
                              cubit(context).getDoctor(
                                index: cubit(context).city,
                              );
                            }
                          }
                          print('City >> ${cubit(context).city}');
                          print('Hospital >> ${cubit(context).Hospital}');
                          print('Branch >> ${cubit(context).branch}');
                          print('Doctor >> ${cubit(context).doctor}');
                          print('Date >> ${cubit(context).Appointment_Date}');
                          print('Time >> ${cubit(context).selectedTime}');
                          print('ISLoding >> ${cubit(context).isLoading}');
                          pageController.nextPage(
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                            curve: Curves.linear,
                          );

                          print(cubit(context).Branches.length);
                        },
                        text: 'Continue'),
                  ),
                if (cubit(context).isLoading) const CircularProgressIndicator(),
                const SizedBox(
                  height: 15,
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  onDotClicked: (index) {},
                  effect: WormEffect(
                    radius: 30,
                    dotHeight: 6,
                    dotWidth: 50,
                    activeDotColor: AppColor,
                    dotColor: Colors.grey,
                  ),
                  count: pages.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
