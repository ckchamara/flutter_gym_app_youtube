 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/screens/home_screen.dart';

import 'blocs/workouts_cubit.dart';
import 'models/workout.dart';

void main() => runApp(const WorkoutTime());


class WorkoutTime extends StatelessWidget {
  const WorkoutTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Workouts',
      theme: ThemeData(
          primaryColor: Colors.blue,
          textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Color.fromARGB(255, 66, 74, 96)))),
      home: BlocProvider<WorkoutsCubit>(
        create: (BuildContext context) {
          WorkoutsCubit workoutsCubit = WorkoutsCubit();
          if(workoutsCubit.state.isEmpty){
            print("Loading json - state is empty");
            workoutsCubit.getWorkouts();
          }else {
            print("state not empty");
          }
          return workoutsCubit;
        },
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, state) {
            return HomeScreen();
          },
        ),
      ),
    );
  }
}
