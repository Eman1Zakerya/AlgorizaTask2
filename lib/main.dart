
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/bloc_observer.dart';

import 'modules/board_screen.dart';
import 'shared/cubit/app_cubit.dart';
import 'shared/cubit/app_states.dart';
import 'shared/theme/app_theme.dart';




Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
      WidgetsFlutterBinding.ensureInitialized();
      //NotificationHelper().initializeNotifications();
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (BuildContext context, AppStates state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'To-Do',
            themeMode: ThemeMode.light,
            theme: lightTheme,
            home:  BoardScreen(),
          );
        },
      ),
    );
  }
}
