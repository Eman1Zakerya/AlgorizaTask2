import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/componands/componands.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';
import 'package:todo_app/shared/cubit/app_states.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Schedule',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            elevation: 1,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CalendarTimeline(
                  initialDate:cubit.scheduleDate ,
                  firstDate: DateTime(2022, 1, 1),
                  lastDate: DateTime(2022, 12, 31),
                  onDateSelected: (date) {
                    cubit.setDate(date);
                  },
                  leftMargin: 20,
                  monthColor: Colors.blueGrey,
                  dotsColor: Colors.teal[200],
                  activeDayColor: Colors.white,
                  activeBackgroundDayColor: Colors.green,
                  dayColor: const Color(0xFF333A47),
                  selectableDayPredicate: (date) => date.day != 23,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        cubit.scheduleDate != DateTime.now() ? '${cubit.scheduleDate.weekday}' : 'Today',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${cubit.scheduleDate.day} ${cubit.scheduleDate.month} ${cubit.scheduleDate.year}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                  width: 500,
                  child: ListView.builder(
                    itemCount: cubit.getTaskPerDate(cubit.tasks , cubit.scheduleDate).length,
                      itemBuilder: (context, index){
                      print('${cubit.taskPerDate[0]['title']}');
                        return buildTaskItem(cubit.taskPerDate[index], context);/*Text('${cubit.taskPerDate[index]['title']}',style: TextStyle(color: Colors.black,),);*/
                      },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
