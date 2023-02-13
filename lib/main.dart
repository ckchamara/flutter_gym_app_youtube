import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/screens/edit_workout_screen.dart';
import 'package:flutter_bloc_app_complete/screens/home_screen.dart';
import 'package:flutter_bloc_app_complete/screens/workout_in_progress_screen.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/workouts_cubit.dart';
import 'models/workout.dart';

// void main() => runApp(const WorkoutTime());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(() => runApp(const WorkoutTime()), storage: storage);
}

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
        home: MultiBlocProvider(
            providers: [
              BlocProvider<WorkoutsCubit>(create: (BuildContext context) {
                WorkoutsCubit workoutsCubit = WorkoutsCubit();
                if (workoutsCubit.state.isEmpty) {
                  print("Loading json - state is empty");
                  workoutsCubit.getWorkouts();
                } else {
                  print("state not empty");
                }
                return workoutsCubit;
              }),
              BlocProvider<WorkoutCubit>(
                  create: (BuildContext context) => WorkoutCubit())
            ],
            child: BlocBuilder<WorkoutCubit, WorkoutState>(
              builder: (context, state) {
                if (state is WorkoutInitialState) {
                  return const HomeScreen();
                } else if (state is WorkoutEditingState) {
                  return const EditWorkoutScreen();
                }
                return const WorkoutInProgressScreen();
              },
            )));
  }
}
