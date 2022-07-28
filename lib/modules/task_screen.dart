
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/modules/board_screen.dart';
import 'package:todo_app/shared/componands/componands.dart';
import '../shared/cubit/app_cubit.dart';
import '../shared/cubit/app_states.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppInsertDatabaseSuccessfulState) {
          BlocProvider.of<AppCubit>(context).titleController.clear();
          BlocProvider.of<AppCubit>(context).startTimeController.clear();
          BlocProvider.of<AppCubit>(context).endTimeController.clear();
          BlocProvider.of<AppCubit>(context).deadLineController.clear();
          BlocProvider.of<AppCubit>(context).remindController.clear();
          NavigateAndFinish(context,  BoardScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Add Task',
              style: GoogleFonts.actor(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Title',
                      style: GoogleFonts.actor(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TFF(
                      hintText: 'Design Team Meeting',
                      controller: cubit.titleController,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Date',
                      style: GoogleFonts.actor(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TFF(
                      padding: const EdgeInsetsDirectional.only(
                        start: 20.0,
                        end: 10.0,
                      ),
                      hintText: '2020-01-01',
                      controller: cubit.deadLineController,
                      keyboardType: TextInputType.datetime,
                      isIcon: true,
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        ).then((value) {
                          if (value != null) {
                            cubit.deadLineController.text =
                                '${value.day} - ${value.month} - ${value.year}';
                            debugPrint(cubit.deadLineController.text);
                          }
                        });
                      },
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Time',
                                style: GoogleFonts.actor(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TFF(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: 10.0,
                                  ),
                                  hintText: '11:00 Am',
                                  controller: cubit.startTimeController,
                                  keyboardType: TextInputType.datetime,
                                  isIcon: true,
                                  icon: const Icon(
                                    Icons.access_time,
                                    color: Colors.grey,
                                    size: 18.0,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Start Time';
                                    }
                                  },
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      if (value != null) {
                                        cubit.startTimeController.text =
                                            '${value.hour}:${value.minute} ${value.hour > 12 ? 'PM' : 'AM'}';
                                        debugPrint(
                                            cubit.startTimeController.text);
                                      }
                                    });
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'End Time',
                                style: GoogleFonts.actor(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TFF(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 10.0,
                                ),
                                hintText: '04:00 Pm',
                                controller: cubit.endTimeController,
                                keyboardType: TextInputType.datetime,
                                isIcon: true,
                                icon: const Icon(Icons.access_time,
                                    color: Colors.grey, size: 18.0),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Start Time';
                                  }
                                },
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      cubit.endTimeController.text =
                                          '${value.hour > 12 ? value.hour - 12 : value.hour}:${value.minute} ${value.hour > 12 ? 'PM' : 'AM'}';
                                      debugPrint(cubit.endTimeController.text);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Remind',
                      style: GoogleFonts.actor(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.only(
                        start: 20.0,
                        end: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: DropdownButtonFormField<dynamic>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                        ),
                        value: cubit.selectedReminderValue,
                        hint: const Text(
                          'choose one',
                        ),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            cubit.selectedReminderValue = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            cubit.selectedReminderValue = value;
                          });
                        },
                        items: cubit.listOfValue,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Color',
                      style: GoogleFonts.actor(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var i = 0; i < cubit.colors.length; i++)
                            Container(
                              height: 30.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                border: cubit.isSelected &&
                                        cubit.colorSelected == cubit.colors[i]
                                    ? Border.all(
                                        color: Colors.black,
                                        width: 4.0,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(30.0),
                                color: cubit.colors[i],
                              ),
                              child: IconButton(
                                icon: cubit.isSelected &&
                                        cubit.colorSelected == cubit.colors[i]
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : Container(
                                        color: cubit.colors[i],
                                      ),
                                onPressed: () {
                                  cubit.setColor(cubit.colors[i]);
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    mainButton(
                      context: context,
                      text: 'Create A Task',
                      onClick: () {
                        if (cubit.titleController.text.isEmpty) {
                          cubit.errorMessage = 'Please enter a title';
                          return;
                        } else if (cubit.startTimeController.text.isEmpty) {
                          cubit.errorMessage = 'Please enter a start time';
                          return;
                        } else if (cubit.endTimeController.text.isEmpty) {
                          cubit.errorMessage = 'Please enter an end time';
                          return;
                        } else if (cubit.deadLineController.text.isEmpty) {
                          cubit.errorMessage = 'Please enter a deadline';
                          return;
                        } else {
                          cubit.errorMessage = '';
                          cubit.insertToDatabase(
                            context: context,
                            title: cubit.titleController.text,
                            startTime: cubit.startTimeController.text,
                            endTime: cubit.endTimeController.text,
                            deadline: cubit.deadLineController.text,
                            remind: cubit.selectedReminderValue,
                            color: cubit.colorSelected!,
                            status: 'active',
                            isFav: false,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
