import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_system/cubit/cubit.dart';
import 'package:hospital_system/modules/Doctor/doctor_main_screen.dart';
import 'package:hospital_system/modules/Patient/Patient_main_screen.dart';
import 'package:hospital_system/shared/componants/constants.dart';
import 'package:hospital_system/shared/network/local/cache.dart';
import 'package:hospital_system/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'BlocObserver.dart';
import 'firebase_options.dart';
import 'modules/login_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.intial();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  UID = CacheHelper.GetData(key: 'UID');
  dynamic APP = CacheHelper.GetData(
    key: 'APP',
  );
  print(UID);
  Widget startScreen = LoginScreen();

  if (UID != null) {
    if (APP == 'doctor') {
      startScreen = const DoctorMainScreen();
    } else {
      startScreen = const PatientMainScreen();
    }
  }
  runApp(MyApp(startScreen));
}

class MyApp extends StatelessWidget {
  Widget? startScreen;
  MyApp(this.startScreen);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Hospital_Cubit()
        ..getAppointments(
          isDoctor: true,
        )
        ..getNotifications(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: LightTheme,
        home: startScreen,
      ),
    );
  }
}
