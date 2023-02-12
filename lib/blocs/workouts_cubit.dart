import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

class WorkoutsCubit extends Cubit<List<Workout>> {
  WorkoutsCubit() : super([]);

  getWorkouts() async {
    final List<Workout> workouts = [];
    final workoutJson =
        jsonDecode(await rootBundle.loadString("assets/workouts.json"));
    for (var element in (workoutJson as Iterable)) {
      workouts.add(Workout.fromJson(element));
    }
    emit(workouts);
  }

  saveWorkouts(Workout workout, int workoutIndex) {
    Workout newWorkout = Workout(title: workout.title, exercises: []);
    int exIndex = 0;
    int startTime = 0;
    for (var ex in workout.exercises) {
      newWorkout.exercises.add(Exercise(
          title: ex.title,
          prelude: ex.prelude,
          duration: ex.duration,
          index: ex.index,
          startTime: ex.startTime));
      exIndex++;
      startTime += ex.prelude! + ex.duration!;
    }
    state[workoutIndex] = newWorkout;
    print("... I have ${state.length} states");
    emit([...state]);
  }
}
