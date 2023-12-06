import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_system/cubit/cubit.dart';
import 'package:hospital_system/cubit/states.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../shared/componants/constants.dart';
import '../../../shared/styles/colors.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Hospital_Cubit, States>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Choose The City',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (cubit(context).cities.isNotEmpty)
              Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      hint: const Text('Cities'),
                      value: cubit(context).city == ''
                          ? null
                          : cubit(context).city,
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      iconSize: 32,
                      iconEnabledColor: Colors.black,
                      items: [
                        DropdownMenuItem(
                            value: cubit(context).cities[0].name,
                            child: Text('${cubit(context).cities[0].name}')),
                        DropdownMenuItem(
                            value: cubit(context).cities[1].name,
                            child: Text('${cubit(context).cities[1].name}')),
                        // DropdownMenuItem(
                        //     value: cubit(context).cities[2].name,
                        //     child: Text('${cubit(context).cities[2].name}')),
                      ],
                      onChanged: (value) {
                        cubit(context).Change_City(value);
                      }),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.deepPurple.shade400.withOpacity(.5),
                size: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HospitalsScreen extends StatelessWidget {
  const HospitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Hospital_Cubit, States>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Choose The Hospital',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (cubit(context).Hospitals.isNotEmpty)
              Container(
                height: 50,
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      hint: const Text('Hospitals'),
                      value: cubit(context).Hospital == ''
                          ? null
                          : cubit(context).Hospital,
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      iconSize: 32,
                      iconEnabledColor: Colors.black,
                      items: [
                        DropdownMenuItem(
                            value: cubit(context).Hospitals[0].name,
                            child: Text('${cubit(context).Hospitals[0].name}')),
                        DropdownMenuItem(
                            value: cubit(context).Hospitals[1].name,
                            child: Text('${cubit(context).Hospitals[1].name}')),
                      ],
                      onChanged: (value) {
                        cubit(context).Change_Hospital(value);
                      }),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.deepPurple.shade400.withOpacity(.5),
                size: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BranchesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Hospital_Cubit, States>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Choose The Branch',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (cubit(context).Branches.isNotEmpty)
              Container(
                height: 50,
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      hint: const Text('Branches'),
                      value: cubit(context).branch == ''
                          ? null
                          : cubit(context).branch,
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      iconSize: 32,
                      iconEnabledColor: Colors.black,
                      items: [
                        DropdownMenuItem(
                            value: cubit(context).Branches[0].name,
                            child: Text('${cubit(context).Branches[0].name}')),
                        DropdownMenuItem(
                            value: cubit(context).Branches[1].name,
                            child: Text('${cubit(context).Branches[1].name}')),
                      ],
                      onChanged: (value) {
                        cubit(context).Change_Branch(value);
                      }),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.deepPurple.shade400.withOpacity(.5),
                size: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Hospital_Cubit, States>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Choose The Doctor',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (cubit(context).Doctors.isNotEmpty)
              Container(
                height: 50,
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      hint: const Text('Doctors'),
                      value: cubit(context).doctor == ''
                          ? null
                          : cubit(context).doctor,
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      iconSize: 32,
                      iconEnabledColor: Colors.black,
                      items: [
                        DropdownMenuItem(
                            value: cubit(context).Doctors[0].ID,
                            child: Text('${cubit(context).Doctors[0].name}')),
                        DropdownMenuItem(
                            value: cubit(context).Doctors[1].ID,
                            child: Text('${cubit(context).Doctors[1].name}')),
                      ],
                      onChanged: (value) {
                        cubit(context).Change_doctor(value!);
                      }),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.deepPurple.shade400.withOpacity(.5),
                size: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateTimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Hospital_Cubit, States>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Column(
          children: [
            TableCalendar(
              focusedDay: cubit(context).today,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2023, 12, 31),
              selectedDayPredicate: (day) =>
                  isSameDay(day, cubit(context).today),
              onDaySelected: (selectedDay, focusedDay) {
                cubit(context)
                    .AppointmentDate(selectedDay, cubit(context).today);
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.5 / 0.22,
                children: List.generate(
                    cubit(context).AppointmentsTime.length,
                    (index) => timeItem(
                        context: context,
                        time: cubit(context).AppointmentsTime[index],
                        index: index)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeItem({
    required BuildContext context,
    required String time,
    required index,
//  required Function onTap,
  }) =>
      InkWell(
        onTap: () {
          print(index);
          cubit(context).Chagne_CurrentTimeIndex(index);
          cubit(context).selectedTime =
              cubit(context).AppointmentsTime[cubit(context).CurrentTimeIndex];
        },
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: cubit(context).CurrentTimeIndex == index
                ? AppColor
                : Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1.3,
            ),
          ),
          child: Center(
              child: Text(
            time,
            style: TextStyle(
              fontSize: 15,
              color: cubit(context).CurrentTimeIndex == index
                  ? Colors.white
                  : Colors.black,
            ),
          )),
        ),
      );
}

//   Column(
//     children: [
//       TableCalendar(
//         focusedDay: DateTime.now(),
//         firstDay: DateTime.now(),
//         lastDay: DateTime.now(),
//       ),
//       const SizedBox(
//         height: 10,
//       ),
//       Expanded(
//         child: GridView.count(
//           shrinkWrap: true,
//           physics: const BouncingScrollPhysics(),
//           //physics: const NeverScrollableScrollPhysics(),
//           crossAxisCount: 3,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//           childAspectRatio: 0.5 / 0.22,
//           children: List.generate(
//               6,
//               (index) => Container(
//                     height: 30,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: AppColor,
//                         width: 1.3,
//                       ),
//                     ),
//                     child: const Center(
//                         child: Text(
//                       '08:20',
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     )),
//                   )),
//         ),
//       ),
//     ],
//   ),
// ];
