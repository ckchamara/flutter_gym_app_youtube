import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/helpers.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';

import '../blocs/workouts_cubit.dart';
import 'edit_excercise_screen.dart';

class EditWorkoutScreen extends StatelessWidget {
  const EditWorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            WorkoutEditingState we = state as WorkoutEditingState;
            return Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  onPressed: () =>
                      BlocProvider.of<WorkoutCubit>(context).goHome(),
                ),
                title: InkWell(
                  child: Text(we.workout!.title!),
                  onTap: () => showDialog(
                      context: context,
                      builder: (_) {
                        final controller =
                            TextEditingController(text: we.workout!.title!);
                        return AlertDialog(
                          content: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                                labelText: "Workout Title"),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    Navigator.pop(context);
                                    Workout renamedWorkout = we.workout!
                                        .copyWith(title: controller.text);
                                    BlocProvider.of<WorkoutsCubit>(context)
                                        .saveWorkouts(
                                            renamedWorkout, we.workoutIndex);
                                    BlocProvider.of<WorkoutCubit>(context)
                                        .editWorkout(
                                            renamedWorkout, we.workoutIndex);
                                  }
                                },
                                child: const Text("Rename"))
                          ],
                        );
                      }),
                ),
              ),
              body: ListView.builder(
                  itemCount: we.workout!.exercises.length,
                  itemBuilder: (context, index) {
                    Exercise exercise = we.workout!.exercises[index];
                    if (we.exIndex == index) {
                      return EditExerciseScreen(
                          workout: we.workout,
                          workoutIndex: we.workoutIndex,
                          exIndex: we.exIndex);
                    } else {
                      return ListTile(
                        leading: Text(formatTime(exercise.prelude!, true)),
                        title: Text(exercise.title!),
                        trailing: Text(formatTime(exercise.duration!, true)),
                        onTap: () => BlocProvider.of<WorkoutCubit>(context)
                            .editExercise(index),
                      );
                    }
                  }),
            );
          },
        ),
        onWillPop: () => BlocProvider.of<WorkoutCubit>(context).goHome());
  }
}
