import 'package:equatable/equatable.dart';

import '../models/workout.dart';

abstract class WorkoutState extends Equatable {
  final Workout? workout;
  final int? elapsed;

  const WorkoutState(this.workout, this.elapsed);
}

class WorkoutInitialState extends WorkoutState {
  const WorkoutInitialState() : super(null, 0);

  @override
  List<Object?> get props => [];
}

class WorkoutEditingState extends WorkoutState {
  final int workoutIndex;
  final int? exIndex;

  const WorkoutEditingState(Workout? workout, this.workoutIndex, this.exIndex)
      : super(workout, 0);

  @override
  List<Object?> get props => [workout, workoutIndex, exIndex];
}

class WorkoutInProgress extends WorkoutState {
  const WorkoutInProgress(Workout? workout, int? elapsed)
      : super(workout, elapsed);

  @override
  List<Object?> get props => [workout, elapsed];
}

class WorkoutPaused extends WorkoutState {
  const WorkoutPaused(Workout? workout, int? elapsed) : super(workout, elapsed);

  @override
  List<Object?> get props => [workout, elapsed];
}
