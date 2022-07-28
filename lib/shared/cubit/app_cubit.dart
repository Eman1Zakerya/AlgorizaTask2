

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  List<DropdownMenuItem> listOfValue = [
    const DropdownMenuItem<String>(
        value: '10 min before', child: Text('10 min before')),
    const DropdownMenuItem<String>(
      value: '30 min before',
      child: Text('30 min before'),
    ),
    const DropdownMenuItem<String>(
      value: '1 hour before',
      child: Text('1 hour before'),
    ),
    const DropdownMenuItem<String>(
      value: '1 day before',
      child: Text('1 day before'),
    ),
  ];

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Color> colors = [
    Color.fromARGB(255, 128, 0, 70),
    Color.fromARGB(255, 96, 89, 0),
    Color.fromARGB(255, 0, 155, 160),
    Color.fromARGB(255, 0, 128, 85),
    Color.fromARGB(255, 245, 229, 3),
  ];

  bool isSelected = false;

  dynamic selectedReminderValue;

  TabController? tabController;

  List<Tab> tabs = [
    const Tab(
      text: 'All',
    ),
    const Tab(
      text: 'UnCompleted',
    ),
    const Tab(
      text: 'Completed',
    ),
    const Tab(
      text: 'Favourites',
    ),
  ];
  String errorMessage = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController deadLineController = TextEditingController();
  TextEditingController remindController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController repeatController = TextEditingController();

  

  dynamic colorSelected;

  Database? database;
  List<Map> tasks = [];
  List<Map> unCompletedTasks = [];
  List<Map> completedTasks = [];
  List<Map> favouriteTasks = [];
  List<Map> taskPerDate=[];

  void createDatabase() {
    openDatabase(
      'Todo.db',
      version:1 ,
      onCreate: (database, version) {
        print('database created');
        database
            .execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, start_time TEXT, end_time TEXT, deadline TEXT, remind TEXT, color BLOB, status TEXT, is_fav TEXT)')
            .then((value) {
          print('Table created');
        }).catchError((error) {
          print('Error is ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database opened');
        getDataFromDataBase(database);
        print('data received From Database successfully');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseSuccess());
    });
  }

  insertToDatabase({
    required BuildContext context,
    required String title,
    required String startTime,
    required String endTime,
    required String deadline,
    required String remind,
    required Color color,
    String status = 'active',
    bool isFav = false,
  }) async {
    await database?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, start_time, end_time, deadline, remind, color, status, is_fav) VALUES("$title","$startTime","$endTime","$deadline","$remind","$color","$status","$isFav")')
          .then((value) {
        print('$value is inserting successfully');
        emit(AppInsertDatabaseSuccessfulState());
        getDataFromDataBase(database);
      }).catchError((error) {
        print('Error when Insert new raw Record ${error.toString()}');
      });
    });
  }

  void getDataFromDataBase(database) {
    tasks = [];
    unCompletedTasks = [];
    completedTasks = [];
    favouriteTasks = [];

    emit(AppGetDatabaseLoadingState());

    database.rawQuery("SELECT * FROM tasks").then((value) {
      tasks = value;
       print('tasks $tasks');
      value.forEach((element) {
        if (element['status'] == 'completed') {
          completedTasks.add(element);
        } else if (element['status'] == 'active') {
          unCompletedTasks.add(element);
        }
        if (element['is_fav'] == 'true') {
          favouriteTasks.add(element);
        }
      });
      emit(AppGetDatabaseSuccessfulState());
    });
  }

  void setChecked({required bool value}) {
    value = !value;
    emit(AppSetCheckedSuccess(value));
  }

  void updateTaskStatus(Map model, s) {
    emit(AppUpdateTaskStatusLoadingState());
    database
        ?.rawUpdate(
            'UPDATE tasks SET status = "$s" WHERE id = "${model['id']}"')
        .then((value) {
      print('${model['title']} is updated successfully');
      emit(AppUpdateTaskStatusSuccessfulState());
      getDataFromDataBase(database);
    }).catchError((error) {
      print('Error when update ${model['title']} ${error.toString()}');
      emit(AppUpdateTaskStatusErrorState(error));
    });
  }

  void setFav(Map<dynamic, dynamic> model) {
    emit(AppSetFavLoadingState());
    database
        ?.rawUpdate(
            'UPDATE tasks SET is_fav = "${model['is_fav'] == 'true' ? 'false' : 'true'}" WHERE id = "${model['id']}"')
        .then((value) {
      print('${model['title']} is updated successfully');
      emit(AppSetFavSuccessfulState());
      getDataFromDataBase(database);
    }).catchError((error) {
      print('Error when update ${model['title']} ${error.toString()}');
      emit(AppSetFavErrorState(error));
    });
  }

  void deleteTask(Map<dynamic, dynamic> model) {
    emit(AppDeleteTaskLoadingState());
    database
        ?.rawDelete('DELETE FROM tasks WHERE id = "${model['id']}"')
        .then((value) {
      debugPrint('${model['title']} is deleted successfully');
      emit(AppDeleteTaskSuccessfulState());
      getDataFromDataBase(database);
    }).catchError((error) {
      debugPrint('Error when delete ${model['title']} ${error.toString()}');
      emit(AppDeleteTaskErrorState(error));
    });
  }

  void setColor(Color color) {
    isSelected = true;
    colorSelected = color;
    emit(AppChangeColorStates());
  }

  DateTime scheduleDate =  DateTime.now();

  void setDate(DateTime date) {
    scheduleDate = date;
    emit(AppChangeDateStates());
  }

   getTaskPerDate(List<Map> task ,DateTime day ){
     taskPerDate= task.where((element) => element['deadline'].split('-').first.replaceAll(' ', '')==day.day.toString()).toList();
     print(taskPerDate.length);

    return taskPerDate;
  }
}