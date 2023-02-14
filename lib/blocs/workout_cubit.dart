import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:wakelock/wakelock.dart';

import '../states/workout_states.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  // WorkoutCubit(super.initialState);
  WorkoutCubit() : super(const WorkoutInitialState());

  Timer? _timer;

  editWorkout(Workout workout, int workoutIndex) {
    return emit(WorkoutEditingState(workout, workoutIndex, null));
  }

  editExercise(int? exIndex) {
    print("..my exercise index is $exIndex");
    return emit(WorkoutEditingState(
        state.workout, (state as WorkoutEditingState).workoutIndex, exIndex));
  }

  pauseWorkout() => emit(WorkoutPaused(state.workout, state.elapsed));

  resumeWorkout() => emit(WorkoutInProgress(state.workout, state.elapsed));

  goHome() {
    emit(const WorkoutInitialState());
  }

  onTick(Timer timer) {
    if (state is WorkoutInProgress) {
      WorkoutInProgress wip = state as WorkoutInProgress;
      if (wip.elapsed! < wip.workout!.getTotal()) {
        print("My elapsed time is ${wip.elapsed}");
        emit(WorkoutInProgress(wip.workout, wip.elapsed! + 1));
      } else {
        _timer!.cancel();
        Wakelock.disable();
        emit(const WorkoutInitialState());
      }
    }
  }

  startWorkout(Workout workout, [int? index]) {
    Wakelock.enable();
    if (index != null) {
    } else {
      emit(WorkoutInProgress(workout, 0));
    }
    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }
}
