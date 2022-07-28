import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/schedule_screen.dart';
import 'package:todo_app/modules/screens/all_tasks.dart';
import 'package:todo_app/modules/screens/completed_tasks.dart';
import 'package:todo_app/modules/screens/favourite_tasks.dart';
import 'package:todo_app/modules/screens/unCompleted_tasks.dart';
import 'package:todo_app/modules/task_screen.dart';
import 'package:todo_app/shared/componands/componands.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';
import 'package:todo_app/shared/cubit/app_states.dart';
import '../services/notification_services.dart';

class BoardScreen extends StatefulWidget {


  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late NotificationHelper  notificationHelper;
  @override
  void initState() {
    super.initState();
    notificationHelper = NotificationHelper();
    notificationHelper.requestAndroidPremition();
    notificationHelper.initializeNotifications();
  }
  //const BoardScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {

        AppCubit cubit = BlocProvider.of<AppCubit>(context);
        return DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: const Color(0xffcccccc),
            appBar: AppBar(
              title: const Text(
                'Board',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              elevation: 1,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    notificationHelper.displayNotification(title: 'title', body: 'body');
                    notificationHelper.scheuledNotification();
                    NavigateTo(context, const ScheduleScreen());
                  },
                ),
              ],
              bottom: TabBar(
                tabs: cubit.tabs,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.blueGrey,
                indicatorColor: Colors.black,
                indicatorWeight: 3.0,
                physics: const NeverScrollableScrollPhysics(),
                labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: cubit.tabController,
                      children: const [
                        AllTasksScreen(),
                        UnCompletedTasksScreen(),
                        CompletedTasksScreen(),
                        FavouriteTaskScreen(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  mainButton(
                    context: context,
                    onClick: () {
                      NavigateTo(
                        context,
                        const TaskScreen(),
                      );
                    },
                    text: 'Add a task',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
