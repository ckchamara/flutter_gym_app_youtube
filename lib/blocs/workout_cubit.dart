import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

import '../states/workout_states.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  // WorkoutCubit(super.initialState);
  WorkoutCubit() : super(const WorkoutInitialState());

  editWorkout(Workout workout, int workoutIndex) {
    return emit(WorkoutEditingState(workout, workoutIndex, null));
  }

  editExercise(int? exIndex) {
    print("..my exercise index is $exIndex");
    return emit(WorkoutEditingState(state.workout, (state as WorkoutEditingState).workoutIndex, exIndex));
  }

  goHome() {
    emit(const WorkoutInitialState());
  }

}
