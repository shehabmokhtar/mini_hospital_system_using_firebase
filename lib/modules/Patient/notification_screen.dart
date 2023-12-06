import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_system/cubit/cubit.dart';
import 'package:hospital_system/models/notification_Model.dart';
import 'package:hospital_system/shared/componants/constants.dart';

import '../../cubit/states.dart';
import '../../shared/componants/componants.dart';
import '../../shared/styles/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Hospital_Cubit, States>(
      listener: (context, state) {
        if (state is deleteNotification_success_States) {
          Fluttertoast.showToast(
              msg: "Notification Deleted",
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
            'Notifications',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        body: ConditionalBuilder(
          condition: state is! getNotifications_loding_States,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => cubit(context).Notifications.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Icon(
                        Icons.notifications_none,
                        size: 100,
                        color: Colors.grey[300],
                      ),
                    ),
                    Text(
                      'There is no notifications',
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
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => My_NotificationItem(
                      context: context,
                      index: index,
                      model: cubit(context).Notifications[index],
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: cubit(context).Notifications.length,
                  ),
                ),
        ),
      ),
    );
  }

  Padding My_NotificationItem({
    required BuildContext context,
    required Notification_Model model,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 10,
      ),
      child: Container(
        padding: const EdgeInsets.all(12.5),
        height: 170,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 37,
                  backgroundImage: NetworkImage(model.doctorImageProfile!),
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
                        'Dr.${model.doctorName!}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        model.message!,
                        maxLines: null,
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
            MaterialButton(
                onPressed: () {
                  cubit(context).deleteNotification(
                      NotificationID: cubit(context).NotificationsID[index]);
                },
                child: Container(
                  height: 43,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: const Center(
                      child: Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                )),
          ],
        ),
      ),
    );
  }
}
